--[[
	�䱦��ģ�͵�������
	2014��11��29��, PM 01:46:41
	wangyanwei
]]

_G.UIToolsJewelleryDraw = BaseUI:new("UIToolsJewelleryDraw");

UIToolsJewelleryDraw.defaultCfg = {
									EyePos = _Vector3.new(0,-40,20),
									LookPos = _Vector3.new(0,0,10),
									VPort = _Vector2.new(800,600)
								  };
UIToolsJewelleryDraw.list = {};


function UIToolsJewelleryDraw:Create()
	self:AddSWF("toolsJewellery.swf",true,"center");
end

function UIToolsJewelleryDraw:OnLoaded(objSwf)
	objSwf.btnClose.click = function() self:OnCloseClickHandler(); end;
	
	objSwf.btn_up.click = function () self : OnBtnUpclick()end;--���ϵ��
	objSwf.btn_down.click = function () self : OnBtnDownclick()end;--���µ��
	objSwf.btn_right.click = function () self : OnBtnRightclick()end;--���ҵ��
	objSwf.btn_left.click = function () self : OnBtnLeftclick()end;--������
	
	objSwf.btn_up.autoRepeat = true;
	objSwf.btn_down.autoRepeat = true;
	objSwf.btn_right.autoRepeat = true;
	objSwf.btn_left.autoRepeat = true;

	objSwf.btn_small.autoRepeat = true;
	objSwf.btn_max.autoRepeat = true;
	objSwf.btn_yang.autoRepeat = true;
	objSwf.btn_fu.autoRepeat = true;
	
	objSwf.btn_small.click = function () self : OnBtnSmallclick()end;--��С���
	objSwf.btn_max.click = function () self : OnBtnMaxclick()end;--�Ŵ���
	objSwf.btn_yang.click = function () self : OnBtnYangclick()end;--���ӵ��
	objSwf.btn_fu.click = function () self : OnBtnFuclick()end;--���ӵ��

	objSwf.btn_user.click = function () self : OnBtnUserclick()end; --ʹ�õ��
	objSwf.btn_save.click = function () self : OnBtnSaveclick()end; --������
	
	objSwf.list.itemClick = function(e) self:OnListItemClick(e); end; --list���
end

function UIToolsJewelleryDraw:OnDelete()
	if self.objUIDraw then
		self.objUIDraw:SetUILoader(nil);
	end
end

function UIToolsJewelleryDraw:OnShow()
	--UIDrawJewelleryConfig
	-- �����ЧConfig
	local jewellerylist = {};
	for i,v in pairs(t_zhenbao) do 
		jewellerylist[20100000 + v.id] = 0;
	end;
	
	for id , cfg in pairs(UIDrawJewelleryConfig) do
		if not cfg.EyePos then
			UIDrawJewelleryConfig[id] = nil;
		end
	end
	
	self:InitList();
end

--�༭list
function UIToolsJewelleryDraw:InitList()
	local objSwf = self.objSwf;
	if not objSwf then return end;
	
	objSwf.list.dataProvider:cleanUp();
	for i,cfg in ipairs(t_zhenbao) do
		local listVO = {};
		if t_map[cfg.mapId] then
			listVO.name = t_map[cfg.mapId].name;
		else
			listVO.name = "";
		end
		listVO.id = cfg.id;
		listVO.unlockLvl=false;
		table.push(self.list,listVo)
		objSwf.list.dataProvider:push(UIData.encode(listVO));
	end
	objSwf.list:invalidateData();
end
--�ر����
function UIToolsJewelleryDraw:OnCloseClickHandler()
	self:Hide();
end

--���ϵ��
function UIToolsJewelleryDraw:OnBtnUpclick()
	if self.objUIDraw then
		local newLook = self.objUIDraw.objCamera.look:add(0,0,-1);
		self.objUIDraw.objCamera.look = newLook;
		self:OnCfgChange();
	end
end

--���µ��
function UIToolsJewelleryDraw:OnBtnDownclick()
	if self.objUIDraw then
		local newLook = self.objUIDraw.objCamera.look:add(0,0,1);
		self.objUIDraw.objCamera.look = newLook;
		self:OnCfgChange();
	end
end

--���ҵ��
function UIToolsJewelleryDraw:OnBtnRightclick()
	if self.objUIDraw then
		local newLook = self.objUIDraw.objCamera.look:add(1,0,0);
		self.objUIDraw.objCamera.look = newLook;
		self:OnCfgChange();
	end
end

--������
function UIToolsJewelleryDraw:OnBtnLeftclick()
	if self.objUIDraw then
		local newLook = self.objUIDraw.objCamera.look:add(-1,0,0);
		self.objUIDraw.objCamera.look = newLook;
		self:OnCfgChange();
	end
end

--��С���
function UIToolsJewelleryDraw:OnBtnSmallclick()
	if self.objUIDraw then
		local newEye = self.objUIDraw.objCamera.eye:add(0,-1,0);
		self.objUIDraw.objCamera.eye = newEye;
		self:OnCfgChange();
	end
end

--�Ŵ���
function UIToolsJewelleryDraw:OnBtnMaxclick()
	if self.objUIDraw then
		local newEye = self.objUIDraw.objCamera.eye:add(0,1,0);
		self.objUIDraw.objCamera.eye = newEye;
		self:OnCfgChange();
	end
end

--���ӵ��
function UIToolsJewelleryDraw:OnBtnYangclick()
	if self.objUIDraw then
		local newEye = self.objUIDraw.objCamera.eye:add(0,0,1);
		self.objUIDraw.objCamera.eye = newEye;
		self:OnCfgChange();
	end
end

--���ӵ��
function UIToolsJewelleryDraw:OnBtnFuclick()
	if self.objUIDraw then
		local newEye = self.objUIDraw.objCamera.eye:add(0,0,-1);
		self.objUIDraw.objCamera.eye = newEye;
		self:OnCfgChange();
	end
end

--ʹ�õ��
function UIToolsJewelleryDraw:OnBtnUserclick()
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

--������
function UIToolsJewelleryDraw:OnBtnSaveclick()
	local file = _File:new();
	file:create(ClientConfigPath .. 'config/gui/UIDrawJewelleryConfig.lua');
	file:write("--[[�䱦3Dģ�������ļ�\nWangyanwei\n]]\n".."_G.UIDrawJewelleryConfig = {\n");
	for id,cfg in pairs(UIDrawJewelleryConfig) do
		file:write("\t["..id.."] = \n\t{\n");
		file:write("\t\tEyePos = _Vector3.new(" ..cfg.EyePos.x.. "," ..cfg.EyePos.y.. "," ..cfg.EyePos.z .."),\n");
		file:write("\t\tLookPos = _Vector3.new(" ..cfg.LookPos.x.. "," ..cfg.LookPos.y.. "," ..cfg.LookPos.z .."),\n");
		file:write("\t\tVPort = _Vector2.new(" .. cfg.VPort.x.. "," ..cfg.VPort.y.. ")\n");
		file:write("\t},\n");
	end
	file:write("\n}");
	file:close();
end

--list���
function UIToolsJewelleryDraw:OnListItemClick(e)
	local jewelleryID = e.item.id;
	self:OnDrawJewellery(jewelleryID);
end

--�����䱦ģ��
UIToolsJewelleryDraw.jewelleryID = 0;
function UIToolsJewelleryDraw:OnDrawJewellery(jewelleryID)
	local objSwf = self.objSwf;
	if not objSwf then return end;
	local selectID = tonumber(t_zhenbao[jewelleryID].zhenbaoName)
	self.jewelleryID = 20100000 + jewelleryID
	local jewellery = JewelleryAvatar:new();
	jewellery:SetModelId(selectID);
	local drawcfg = UIDrawJewelleryConfig[self.jewelleryID];
	if not drawcfg then 
		drawcfg = self:GetDefaultCfg();
		UIDrawJewelleryConfig[self.jewelleryID] = drawcfg;
		self:SetListHasCfg(self.jewelleryID)
	end
	
	if not self.objUIDraw then
		self.objUIDraw = UIDraw:new("toolsJewellery",jewellery, objSwf.jewelleryLoader,  
			drawcfg.VPort,   drawcfg.EyePos,  
			drawcfg.LookPos,  0x00000000);
	else
		self.objUIDraw:SetUILoader(objSwf.jewelleryLoader);
		self.objUIDraw:SetCamera(drawcfg.VPort,drawcfg.EyePos,drawcfg.LookPos);
		self.objUIDraw:SetMesh(jewellery);
	end
	
	self.objUIDraw:SetDraw(true);

	self:OnCfgChange();
end
--�ر���ʾ
function UIToolsJewelleryDraw:OnHide()
	local objSwf = self:GetSWF("UIToolsJewelleryDraw");
	if not objSwf then return; end
	if self.objUIDraw then
		self.objUIDraw:SetDraw(false);
	end
end
--���ñ䶯
function UIToolsJewelleryDraw:OnCfgChange()
	if not self.objUIDraw then return ;end;
	local jewellery = self.jewelleryID;
	if not UIDrawJewelleryConfig[jewellery] then 
		UIDrawJewelleryConfig[jewellery] = self:GetDefaultCfg();
	end;
	local cfg = UIDrawJewelleryConfig[jewellery];
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

--���������ļ�
function UIToolsJewelleryDraw:GetDefaultCfg()
	local cfg = {};
	cfg.EyePos = self.defaultCfg.EyePos:clone();
	cfg.LookPos = self.defaultCfg.LookPos:clone();
	cfg.VPort = self.defaultCfg.VPort:clone();
	return cfg;
end

--��������
function UIToolsJewelleryDraw:SetListHasCfg(jewellertId)
	local objSwf = self.objSwf;
	if not objSwf then return; end
	for i,listVO in ipairs(self.list) do
		local listJewelleryId = 20100000 + listVO.id;
		if listJewelleryId == jewellertId then
			objSwf.list.dataProvider[i-1] = UIData.encode(listVO);
			local uiItem = objSwf.list:getRendererAt(i-1);
			if uiItem then
				uiItem:setData(UIData.encode(listVO));
			end
			return;
		end
	end
end