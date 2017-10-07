--[[
	2015��3��13��, AM 11:11:52
	NPC����Ի���ģ������
	wangyanwei
]]

_G.ToolsRandomRaffleNpcDraw = BaseUI:new("ToolsRandomRaffleNpcDraw");

ToolsRandomRaffleNpcDraw.defaultCfg = {
	EyePos = _Vector3.new(0,-40,20),
	LookPos = _Vector3.new(0,0,10),
	VPort = _Vector2.new(1800,1200),
	Rotation = 0
};

ToolsRandomRaffleNpcDraw.currNpcId = 0;
ToolsRandomRaffleNpcDraw.list = {};

function ToolsRandomRaffleNpcDraw:Create()
	self:AddSWF("toolRandomDungeonRaffle.swf",true,"center");
end

function ToolsRandomRaffleNpcDraw:OnLoaded(objSwf,name)
	objSwf.btnClose.click = function() self:OnBtnCloseClick(); end
	objSwf.btnZoomOut.autoRepeat = true;
	objSwf.btnZoomIn.autoRepeat = true;
	objSwf.btnZoomOut.click = function() self:OnBtnZoomOut(); end
	objSwf.btnZoomIn.click = function() self:OnBtnZoomIn(); end
	objSwf.btnLeft.autoRepeat = true;
	objSwf.btnRight.autoRepeat = true;
	objSwf.btnLeft.click = function() self:OnBtnLeft(); end
	objSwf.btnRight.click = function() self:OnBtnRight(); end
	objSwf.btnUp.autoRepeat = true;
	objSwf.btnDown.autoRepeat = true;
	objSwf.btnUp.click = function() self:OnBtnUp(); end
	objSwf.btnDown.click = function() self:OnBtnDown(); end
	objSwf.btnLookUp.autoRepeat = true;
	objSwf.btnLookDown.autoRepeat = true;
	objSwf.btnLookUp.click = function() self:OnBtnLookUp(); end
	objSwf.btnLookDown.click = function() self:OnBtnLookDown(); end

	objSwf.btnTurnLeft.autoRepeat = true;
	objSwf.btnTurnLeft.buttonRepeatDelay = 20;
	objSwf.btnTurnLeft.buttonRepeatDuration = 20;
	objSwf.btnTurnRight.autoRepeat = true;
	objSwf.btnTurnRight.buttonRepeatDelay = 20;
	objSwf.btnTurnRight.buttonRepeatDuration = 20;
	objSwf.btnTurnLeft.click = function() self:OnBtnTurnLeft(); end
	objSwf.btnTurnRight.click = function() self:OnBtnTurnRight(); end
	--
	objSwf.list.itemClick = function(e) self:OnListItemClick(e); end
	objSwf.btnUseParam.click = function() self:OnBtnUseParam(); end
	objSwf.btnSave.click = function() self:OnBtnSave(); end
end

function ToolsRandomRaffleNpcDraw:OnDelete()
	if self.objUIDraw then
		self.objUIDraw:SetUILoader(nil);
	end
end

function ToolsRandomRaffleNpcDraw:GetWidth()
	return 789
end

function ToolsRandomRaffleNpcDraw:GetHeight()
	return 269
end

function ToolsRandomRaffleNpcDraw:OnShow(name)
	--�����Ч����
	for id,cfg in pairs(UIDrawRandomNpcCfg) do
		if not t_npc[id] then
			UIDrawRandomNpcCfg[id] = nil;
		end
	end
	--
	local objSwf = self:GetSWF("ToolsRandomRaffleNpcDraw");
	if not objSwf then return; end
	objSwf.list.dataProvider:cleanUp();
	self.list = {};
	for i,cfg in pairs(t_qiyuzu) do
		if cfg.modelid ~= 0 then
			local listVO = {};
			listVO.name = 'npc';
			listVO.flag = UIDrawRandomNpcCfg[cfg.id] and "��" or "";
			listVO.npcId = cfg.modelid;
			table.push(self.list,listVO);
			objSwf.list.dataProvider:push(UIData.encode(listVO));
		end
	end
	objSwf.list:invalidateData();
	if #self.list <= 0 then return; end
	self:DrawNpc(self.list[1].npcId);
	objSwf.list:scrollToIndex(0);
	objSwf.list.selectedIndex = 0;
end

function ToolsRandomRaffleNpcDraw:OnListItemClick(e)
	local npcId = e.item.npcId;
	self:DrawNpc(npcId);
end

function ToolsRandomRaffleNpcDraw:DrawNpc(npcId)
	local objSwf = self:GetSWF("ToolsRandomRaffleNpcDraw");
	if not objSwf then return; end
	self.currNpcId = npcId;
	local npcAvatar = NpcAvatar:NewNpcAvatar(npcId);

	npcAvatar:InitAvatar();
	local drawCfg = UIDrawRandomNpcCfg[npcId];
	if not drawCfg then


		drawCfg = self:GetDefaultCfg();
		UIDrawRandomNpcCfg[npcId] = drawCfg;
		self:SetListHasCfg(npcId);



	end
	if not self.objUIDraw then
		self.objUIDraw = UIDraw:new("ToolsRandomRaffleNpcDraw",npcAvatar, objSwf.npcLoader,
							drawCfg.VPort,drawCfg.EyePos,drawCfg.LookPos,
							0x00000000,"UINpc");
	else
		self.objUIDraw:SetUILoader(objSwf.npcLoader);
		self.objUIDraw:SetCamera(drawCfg.VPort,drawCfg.EyePos,drawCfg.LookPos);
		self.objUIDraw:SetMesh(npcAvatar);
	end
	local rotation = drawCfg.Rotation or 0;
	npcAvatar.objMesh.transform:setRotation( 0, 0, 1, rotation );
	self.objUIDraw:SetDraw(true);
	self:OnCfgChange();
end

--����ĳ����������
function ToolsRandomRaffleNpcDraw:SetListHasCfg(npcId)
	local objSwf = self:GetSWF("ToolsRandomRaffleNpcDraw");
	if not objSwf then return; end
	for i,listVO in ipairs(self.list) do
		if listVO.npcId == npcId then
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

local rotation = -0.7;
function ToolsRandomRaffleNpcDraw:OnCfgChange()
	if not self.objUIDraw then return; end
	local npcId = self.currNpcId;
	local cfg = UIDrawRandomNpcCfg[npcId];
	if not UIDrawRandomNpcCfg[npcId] then
		cfg = self:GetDefaultCfg();
	end
	cfg.EyePos = self.objUIDraw.objCamera.eye:clone();
	cfg.LookPos = self.objUIDraw.objCamera.look:clone();
	cfg.VPort = self.defaultCfg.VPort:clone();
	cfg.Rotation = rotation;
	--��ʾ����
	local objSwf = self:GetSWF("ToolsRandomRaffleNpcDraw");
	if not objSwf then return; end
	objSwf.ipEyeX.text = cfg.EyePos.x;
	objSwf.ipEyeY.text = cfg.EyePos.y;
	objSwf.ipEyeZ.text = cfg.EyePos.z;
	objSwf.ipLookX.text = cfg.LookPos.x;
	objSwf.ipLookY.text = cfg.LookPos.y;
	objSwf.ipLookZ.text = cfg.LookPos.z;
	objSwf.txtRotation.text = cfg.Rotation;
end

function ToolsRandomRaffleNpcDraw:GetDefaultCfg()
	local cfg = {};
	cfg.EyePos = self.defaultCfg.EyePos:clone();
	cfg.LookPos = self.defaultCfg.LookPos:clone();
	cfg.VPort = self.defaultCfg.VPort:clone();
	cfg.Rotation = 0;
	return cfg;
end

function ToolsRandomRaffleNpcDraw:OnHide()
	if self.objUIDraw then
		self.objUIDraw:SetDraw(false);
	end
	self.currNpcId = 0;
end

function ToolsRandomRaffleNpcDraw:OnBtnUseParam()
	if not self.objUIDraw then return; end
	local objSwf = self:GetSWF("ToolsRandomRaffleNpcDraw");
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
	local rot = objSwf.txtRotation.text;
	if not tonumber(rot) then
		FloatManager:AddNormal("V? hi?u Rotation Tham s?");
		return;
	end
	--
	self.objUIDraw.objCamera.eye:set(eyeX,eyeY,eyeZ);
	self.objUIDraw.objCamera.look:set(lookX,lookY,lookZ);
	self.objUIDraw.objEntity.objMesh.transform:setRotation( 0, 0, 1, rot );
	self:OnCfgChange();
end

function ToolsRandomRaffleNpcDraw:OnBtnTurnLeft()
	rotation = rotation + 0.05;
	self.objUIDraw.objEntity.objMesh.transform:setRotation( 0, 0, 1, rotation );
	self:OnCfgChange();
end

function ToolsRandomRaffleNpcDraw:OnBtnTurnRight()
	rotation = rotation - 0.05;
	self.objUIDraw.objEntity.objMesh.transform:setRotation( 0, 0, 1, rotation );
	self:OnCfgChange();
end

function ToolsRandomRaffleNpcDraw:OnBtnSave()
	local file = _File:new();
	file:create(ClientConfigPath .. 'config/gui/UIDrawRandomNpcConfig.lua');
	file:write("_G.UIDrawRandomNpcCfg = {\n");
	for npcId,cfg in pairs(UIDrawRandomNpcCfg) do
		file:write("\t["..npcId.."] = \n\t{\n");
		file:write("\t\tEyePos = _Vector3.new(" ..cfg.EyePos.x.. "," ..cfg.EyePos.y.. "," ..cfg.EyePos.z .."),\n");
		file:write("\t\tLookPos = _Vector3.new(" ..cfg.LookPos.x.. "," ..cfg.LookPos.y.. "," ..cfg.LookPos.z .."),\n");
		file:write("\t\tVPort = _Vector2.new(" .. cfg.VPort.x.. "," ..cfg.VPort.y.. "),\n");
		file:write("\t\tRotation =".. rotation .."\n")
		file:write("\t},\n");
	end
	file:write("\n}");
	file:close();
end

--����
function ToolsRandomRaffleNpcDraw:OnBtnLeft()
	if self.objUIDraw then
		local newLook = self.objUIDraw.objCamera.look:add(-1,0,0);
		self.objUIDraw.objCamera.look = newLook;
		self:OnCfgChange();
	end
end

--����
function ToolsRandomRaffleNpcDraw:OnBtnRight()
	if self.objUIDraw then
		local newLook = self.objUIDraw.objCamera.look:add(1,0,0);
		self.objUIDraw.objCamera.look = newLook;
		self:OnCfgChange();
	end
end

--����
function ToolsRandomRaffleNpcDraw:OnBtnUp()
	if self.objUIDraw then
		local newLook = self.objUIDraw.objCamera.look:add(0,0,-1);
		self.objUIDraw.objCamera.look = newLook;
		self:OnCfgChange();
	end
end

--����
function ToolsRandomRaffleNpcDraw:OnBtnDown()
	if self.objUIDraw then
		local newLook = self.objUIDraw.objCamera.look:add(0,0,1);
		self.objUIDraw.objCamera.look = newLook;
		self:OnCfgChange();
	end
end

--����
function ToolsRandomRaffleNpcDraw:OnBtnLookUp()
	if self.objUIDraw then
		local newEye = self.objUIDraw.objCamera.eye:add(0,0,1);
		self.objUIDraw.objCamera.eye = newEye;
		self:OnCfgChange();
	end
end

--����
function ToolsRandomRaffleNpcDraw:OnBtnLookDown()
	if self.objUIDraw then
		local newEye = self.objUIDraw.objCamera.eye:add(0,0,-1);
		self.objUIDraw.objCamera.eye = newEye;
		self:OnCfgChange();
	end
end

--��С
function ToolsRandomRaffleNpcDraw:OnBtnZoomOut()
	if self.objUIDraw then
		local newEye = self.objUIDraw.objCamera.eye:add(0,-1,0);
		self.objUIDraw.objCamera.eye = newEye;
		self:OnCfgChange();
	end
end

--�Ŵ�
function ToolsRandomRaffleNpcDraw:OnBtnZoomIn()
	if self.objUIDraw then
		local newEye = self.objUIDraw.objCamera.eye:add(0,1,0);
		self.objUIDraw.objCamera.eye = newEye;
		self:OnCfgChange();
	end
end

--�ر��¼�
function ToolsRandomRaffleNpcDraw:OnBtnCloseClick()
	self:Hide();
end