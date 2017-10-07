--[[
神武 controller
haohu
2015年12月25日16:36:03
]]

_G.ShenWuController = setmetatable( {}, {__index = IController} );
ShenWuController.name = "ShenWuController"

function ShenWuController:Create()
	MsgManager:RegisterCallBack( MsgType.SC_ShenWuInfo, self, self.OnShenWuInfo )
	MsgManager:RegisterCallBack( MsgType.SC_ShenWuStarUp, self, self.OnShenWuStarUpResult )
	MsgManager:RegisterCallBack( MsgType.SC_ShenWuLevelUp, self, self.OnShenWuLevelUpResult )
end



-------------------------------------------------resp-----------------------------------------------

-- Máy chủ trả về：神武信息上线推
function ShenWuController:OnShenWuInfo(msg)
	---[[
	QuestController:TestTrace("Máy chủ trả về：thông tin Thần Võ Tín")
	QuestController:TestTrace(msg)
	--]]
	ShenWuModel:SetLevel( msg.level )
	ShenWuModel:SetStar( msg.star )
	ShenWuModel:SetUseStoneNum( msg.stoneNum )
	ShenWuModel:SetStarRate( msg.rate )
end

-- Máy chủ trả về：神武升星
function ShenWuController:OnShenWuStarUpResult(msg)
	---[[
	QuestController:TestTrace("Máy chủ trả về：Thần võ thăng tinh")
	QuestController:TestTrace(msg)
	--]]
	local result = msg.result
	if result == 0 then
		ShenWuModel:SetStar( msg.star )
		ShenWuModel:SetStarRate( msg.rate )
		FloatManager:AddNormal(StrConfig['shenwu8'])
	elseif result == 5 then -- 概率失败
		FloatManager:AddNormal(StrConfig['shenwu9'])
		ShenWuModel:SetStarRate( msg.rate )
	end
end

-- Máy chủ trả về：神武激活/进阶
function ShenWuController:OnShenWuLevelUpResult(msg)
	---[[
	QuestController:TestTrace("Máy chủ trả về：Thần võ kích hoạt / Tiến giai")
	QuestController:TestTrace(msg)
	--]]
	local result = msg.result
	if result == 0 then -- 成功
		ShenWuModel:SetLevel( msg.level )
		ShenWuModel:SetStar( msg.star )
		ShenWuModel:SetUseStoneNum( msg.stoneNum )
		local isActive = msg.level == 1
		FloatManager:AddNormal( isActive and StrConfig['shenwu24'] or StrConfig['shenwu6'])
		ShenWuModel:SetStarRate( ShenWuUtils:GetOStarRate(msg.level) )
	elseif result == 1 then -- 掉星
		local oldStar = ShenWuModel:GetStar()
		local starDown = oldStar - msg.star
		FloatManager:AddNormal( string.format( StrConfig['shenwu7'], starDown ) )
		ShenWuModel:SetStar( msg.star )
		ShenWuModel:SetUseStoneNum( msg.stoneNum )
	end
end

----------------------------------------------req--------------------------------------------------

-- Yêu cầu người chơi：神武升星
function ShenWuController:ReqShenWuStarUp()
	if ShenWuModel:IsFull() then
		FloatManager:AddNormal(StrConfig['shenwu5'])
		return
	end
	if not ShenWuUtils:IsCurrentMaterialEnough() then
		FloatManager:AddNormal(StrConfig['shenwu4'])
		return
	end
	local msg = ReqShenWuStarUpMsg:new()
	MsgManager:Send(msg)
	---[[
	QuestController:TestTrace("Yêu cầu người chơi：Thần võ thăng tinh")
	--]]
end

-- Yêu cầu người chơi：神武激活/进阶
function ShenWuController:ReqShenWuLevelUp()
	if not ShenWuController:CheckLevelUpCondition() then
		return
	end
	local msg = ReqShenWuLevelUpMsg:new()
	MsgManager:Send(msg)
	---[[
	QuestController:TestTrace("Yêu cầu người chơi：Thần võ kích hoạt / Tiến giai")
	--]]
end

function ShenWuController:CheckLevelUpCondition()
	if ShenWuModel:IsFull() then
		FloatManager:AddNormal(StrConfig['shenwu5'])
		return false
	end
	if not ShenWuUtils:IsCurrentMaterialEnough() then
		FloatManager:AddNormal(StrConfig['shenwu4'])
		return false
	end
	return true
end