--[[
��ūģ�ͱ�����
zhangshuihui
]]

_G.UIToolsBingNuDraw = BaseUI:new("UIToolsBingNuDraw");

UIToolsBingNuDraw.list={};
UIToolsBingNuDraw.curid=0;
UIToolsBingNuDraw.curModel = nil;
UIToolsBingNuDraw.modelTurnDir = 0;--ģ����ת���� 0,����ת;1��;-1��
UIToolsBingNuDraw.meshDir = 0; --ģ�͵ĵ�ǰ����
UIToolsBingNuDraw.curtexDriX = 0;
UIToolsBingNuDraw.texDri = 0;
UIToolsBingNuDraw.texName = 0;
UIToolsBingNuDraw.defaultCfg = {
									EyePos = _Vector3.new(0,-40,20),
									LookPos = _Vector3.new(0,0,10),
									VPort = _Vector2.new(1000,500),
									Rotation = 0,
								  }
								  
function UIToolsBingNuDraw:Create()
	self:AddSWF("toolsBingNuDraw.swf",true,"center");
end

function UIToolsBingNuDraw:OnLoaded(objSwf,name)
	objSwf.btnClose.click = function() self : OnCloseClick()end

	objSwf.btn_up.click = function () self : OnBtnUpclick()end;
	objSwf.btn_down.click = function () self : OnBtnDownclick()end;
	objSwf.btn_right.click = function () self : OnBtnRightclick()end;
	objSwf.btn_left.click = function () self : OnBtnLeftclick()end;

	objSwf.btnBingNuRight.stateChange = function (e) self : OnBingNuRight(e.state)end;
	objSwf.btnBingNuLeft.stateChange = function (e) self : OnBingNuLeft(e.state)end;


	objSwf.btn_up.autoRepeat = true;
	objSwf.btn_down.autoRepeat = true;
	objSwf.btn_right.autoRepeat = true;
	objSwf.btn_left.autoRepeat = true;

	objSwf.btn_small.autoRepeat = true;
	objSwf.btn_max.autoRepeat = true;
	objSwf.btn_yang.autoRepeat = true;
	objSwf.btn_fu.autoRepeat = true;

	objSwf.btn_small.click = function () self : OnBtnSmallclick()end;
	objSwf.btn_max.click = function () self : OnBtnMaxclick()end;
	objSwf.btn_yang.click = function () self : OnBtnYangclick()end;
	objSwf.btn_fu.click = function () self : OnBtnFuclick()end;

	objSwf.btn_user.click = function () self : OnBtnUserclick()end;
	objSwf.btn_save.click = function () self : OnBtnSaveclick()end;

	objSwf.list.itemClick = function(e) self:OnListItemClick(e); end
end

function UIToolsBingNuDraw:OnDelete()
	if self.objUIDraw then
		self.objUIDraw:SetUILoader(nil);
	end
end

function UIToolsBingNuDraw:OnShow()
	for l,k in pairs(UIDrawBingNuConfig) do
		if not t_collection[l] then 
			UIDrawBingNuConfig[l] = nil;
		end;
	end;
	self:Initlist();
end

function UIToolsBingNuDraw:OnListItemClick(e)
	local bingnuid = e.item.bingnuid;
	self:DrawBingNu(bingnuid);
end

function UIToolsBingNuDraw:Initlist()
	local objSwf = self.objSwf;
	objSwf.list.dataProvider:cleanUp();
	for i,cf in pairs(t_collection) do
		if cf.cost_type == 0 and cf.taskType == 2 then
			local listVo = {};
			listVo.name = cf.name;
			listVo.flag = UIDrawBingNuConfig[i] and "��" or "";
			listVo.bingnuid = i;
			table.push(self.list,listVo)
			objSwf.list.dataProvider:push(UIData.encode(listVo));
		end
	end;
	objSwf.list:invalidateData();
	objSwf.list.selectedIndex = 0;
	self.id = self.list[1].bingnuid;
	self:DrawBingNu(self.id)
end

function UIToolsBingNuDraw:DrawBingNu(id)
	local objswf = self.objSwf;
	if not objswf then return end;
	self.curid = id;

	local colAvater = CollectionAvatar:NewCollectionAvatar(id);
	colAvater:InitAvatar();
	self.curModel = colAvater;

	local drawcfg = UIDrawBingNuConfig[id]
	if not drawcfg then 
		drawcfg = self:GetDefaultCfg();

		UIDrawBingNuConfig[id] = drawcfg;
		
		self:SetListHasCfg(self.curid);
	end;
	if not self.objUIDraw then 
		self.objUIDraw = UIDraw:new("toolsBingNu",colAvater, objswf.modelload,  
			drawcfg.VPort,   drawcfg.EyePos,  
			drawcfg.LookPos,  0x00000000);
	else 
		self.objUIDraw:SetUILoader(objswf.modelload);
		self.objUIDraw:SetCamera(drawcfg.VPort,drawcfg.EyePos,drawcfg.LookPos);
		self.objUIDraw:SetMesh(colAvater);
	end;
	-- ģ����ת
	self.meshDir = drawcfg.Rotation;
	self.curModel.objMesh.transform:setRotation(0,0,1,drawcfg.Rotation);
	
	self.objUIDraw:SetDraw(true);

	self:OnCfgChange();
end

function UIToolsBingNuDraw:OnCfgChange()
if not self.objUIDraw then return ;end;

	local bingnuid = self.curid;
	if not UIDrawBingNuConfig[bingnuid] then 
		UIDrawBingNuConfig[bingnuid] = self:GetDefaultCfg();
	end;
	local cfg = UIDrawBingNuConfig[bingnuid];
	cfg.EyePos = self.objUIDraw.objCamera.eye:clone();
	cfg.LookPos = self.objUIDraw.objCamera.look:clone();
	cfg.VPort = self.defaultCfg.VPort:clone();

	-- ��ʾ����
	local objSwf = self.objSwf;
	objSwf.ipEyeX.text = cfg.EyePos.x;
	objSwf.ipEyeY.text = cfg.EyePos.y;
	objSwf.ipEyeZ.text = cfg.EyePos.z;
	objSwf.ipLookX.text = cfg.LookPos.x;
	objSwf.ipLookY.text = cfg.LookPos.y;
	objSwf.ipLookZ.text = cfg.LookPos.z;
end

function UIToolsBingNuDraw:OnBtnUserclick()
	-- user
	if not self.objUIDraw then return; end
	local objSwf = self.objSwf;
	if not objSwf then return; end
	local eyeX = tonumber(objSwf.ipEyeX.text);
	local eyeY = tonumber(objSwf.ipEyeY.text);
	local eyeZ = tonumber(objSwf.ipEyeZ.text);
	if (not eyeX) or (not eyeY) or (not eyeZ) then
		FloatManager:AddNormal("V? hi?u Eye Tham s?");
		return;
	end
	local lookX = tonumber(objSwf.ipLookX.text);
	local lookY = tonumber(objSwf.ipLookY.text);
	local lookZ = tonumber(objSwf.ipLookZ.text);
	if (not lookX) or (not lookY) or (not lookZ) then
		FloatManager:AddNormal("V? hi?u Look Tham s?");
		return;
	end
	--
	self.objUIDraw.objCamera.eye:set(eyeX,eyeY,eyeZ);
	self.objUIDraw.objCamera.look:set(lookX,lookY,lookZ);
	self:OnCfgChange();
end

function UIToolsBingNuDraw:OnBingNuRight(state)
	if state == "down" then
		self.modelTurnDir = -1;
	elseif state == "release" then
		self.modelTurnDir = 0;
	elseif state == "out" then
		self.modelTurnDir = 0;
	end
end

function UIToolsBingNuDraw:OnBingNuLeft(state)
	if state == "down" then
		self.modelTurnDir = 1;
	elseif state == "release" then
		self.modelTurnDir = 0;
	elseif state == "out" then
		self.modelTurnDir = 0;
	end
end

function UIToolsBingNuDraw:Update()
	self:SetBingNuRotation()
end

function UIToolsBingNuDraw:SetBingNuRotation()
	if self.modelTurnDir == 0 then
		return;
	end
	if not self.curModel then
		return;
	end
	self.meshDir = self.meshDir + math.pi/100*self.modelTurnDir;

	if self.meshDir < 0 then
		self.meshDir = self.meshDir + math.pi*2;
	end

	if self.meshDir > math.pi*2 then
		self.meshDir = self.meshDir - math.pi*2;
	end
	self.curModel.objMesh.transform:setRotation(0,0,1,self.meshDir);
	if not UIDrawBingNuConfig[self.curid] then 
		UIDrawBingNuConfig[self.curid] = self:GetDefaultCfg();
	end;
	local cfg = UIDrawBingNuConfig[self.curid];
	cfg.Rotation = self.meshDir;
end

function UIToolsBingNuDraw:SetListHasCfg(id)
	local objSwf = self.objSwf;
	if not objSwf then return; end
	for i,listVO in ipairs(self.list) do
		if listVO.bingnuid == id then
			listVO.flag = "��";
			objSwf.list.dataProvider[i-1] = UIData.encode(listVO);
			local uiItem = objSwf.list:getRendererAt(i-1);
			if uiItem then
				uiItem:setData(UIData.encode(listVO));
			end
			return;
		end
	end
end

-- ���������ļ�
function UIToolsBingNuDraw:GetDefaultCfg()
	local cfg = {};
	cfg.EyePos = self.defaultCfg.EyePos:clone();
	cfg.LookPos = self.defaultCfg.LookPos:clone();
	cfg.VPort = self.defaultCfg.VPort:clone();
	cfg.Rotation = 0;
	return cfg;
end

function UIToolsBingNuDraw:OnBtnSmallclick()
	--small
	if self.objUIDraw then
		local newEye = self.objUIDraw.objCamera.eye:add(0,-1,0);
		self.objUIDraw.objCamera.eye = newEye;
		self:OnCfgChange();
	end
end

function UIToolsBingNuDraw:OnBtnMaxclick()
	-- max
	if self.objUIDraw then
		local newEye = self.objUIDraw.objCamera.eye:add(0,1,0);
		self.objUIDraw.objCamera.eye = newEye;
		self:OnCfgChange();
	end
end

function UIToolsBingNuDraw:OnBtnFuclick()
	-- fu
	if self.objUIDraw then
		local newEye = self.objUIDraw.objCamera.eye:add(0,0,-1);
		self.objUIDraw.objCamera.eye = newEye;
		self:OnCfgChange();
	end
end

function UIToolsBingNuDraw:OnBtnYangclick()
	-- yang
		if self.objUIDraw then
		local newEye = self.objUIDraw.objCamera.eye:add(0,0,1);
		self.objUIDraw.objCamera.eye = newEye;
		self:OnCfgChange();
	end
end

function UIToolsBingNuDraw:OnBtnDownclick()
	-- down
	if self.objUIDraw then
		local newLook = self.objUIDraw.objCamera.look:add(0,0,1);
		self.objUIDraw.objCamera.look = newLook;
		self:OnCfgChange();
	end
end

function UIToolsBingNuDraw:OnBtnUpclick()
	-- up
	if self.objUIDraw then
		local newLook = self.objUIDraw.objCamera.look:add(0,0,-1);
		self.objUIDraw.objCamera.look = newLook;
		self:OnCfgChange();
	end
end

function UIToolsBingNuDraw:OnBtnLeftclick()
	--left
	if self.objUIDraw then
		local newLook = self.objUIDraw.objCamera.look:add(-1,0,0);
		self.objUIDraw.objCamera.look = newLook;
		self:OnCfgChange();
	end
end

function UIToolsBingNuDraw:OnBtnRightclick()
	--right
		if self.objUIDraw then
		local newLook = self.objUIDraw.objCamera.look:add(1,0,0);
		self.objUIDraw.objCamera.look = newLook;
		self:OnCfgChange();
	end
end

function UIToolsBingNuDraw:OnCloseClick()
	self:Hide();
end

function UIToolsBingNuDraw:OnBtnSaveclick()
	-- save
	local file = _File:new();
	file:create(ClientConfigPath .. 'config/gui/UIDrawBingNuConfig.lua');
	file:write("--[[ ��ūģ�������ļ�\nzhangshuhui\n]]\n".."_G.UIDrawBingNuConfig = {\n");
	for id,cfg in pairs(UIDrawBingNuConfig) do
		file:write("\t["..id.."] = \n\t{\n");
		file:write("\t\tEyePos = _Vector3.new(" ..cfg.EyePos.x.. "," ..cfg.EyePos.y.. "," ..cfg.EyePos.z .."),\n");
		file:write("\t\tLookPos = _Vector3.new(" ..cfg.LookPos.x.. "," ..cfg.LookPos.y.. "," ..cfg.LookPos.z .."),\n");
		file:write("\t\tVPort = _Vector2.new(" .. cfg.VPort.x.. "," ..cfg.VPort.y.. "),\n");
		file:write("\t\tRotation ="..cfg.Rotation..",\n")
		file:write("\t},\n");
	end
	file:write("\n}");
	file:close();
end

function UIToolsBingNuDraw:OnHide()
	if self.objUIDraw then
		self.objUIDraw:SetDraw(false);
	end
	self.curid = 0;
end