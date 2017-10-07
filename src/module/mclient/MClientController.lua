--[[
΢��
lizhuangzhuang
2015��5��14��14:44:04
]]

_G.MClientController = setmetatable({},{__Index = IController});
MClientController.name = "MClientController";

function MClientController:Create()
	MsgManager:RegisterCallBack(MsgType.SC_MClientReward,self,self.OnMClientReward);
end

--��ȡ΢�˽���
function MClientController:GetReward()
	local msg = ReqMClientRewardMsg:new();
	MsgManager:Send(msg);
end

--����΢�˽���
function MClientController:OnMClientReward(msg)
	if msg.result == 0 then
		if UIMClientReward:IsShow() then
			UIMClientReward:Hide();
		end
		self:OnMClientRewardState(1);
		local mainBtn = YunYingBtnManager:GetBtn(YunYingConsts.BT_MClient);
		if mainBtn then
			mainBtn:RefreshBtn();
		end
		FloatManager:AddNormal(StrConfig["mclient101"]);
	elseif msg.result == 1 then
		FloatManager:AddNormal(StrConfig["mclient102"]);
	elseif msg.result == 2 then
		FloatManager:AddNormal(StrConfig["mclient103"]);
	end
end

--����΢�˽�����ȡ״̬
function MClientController:OnMClientRewardState(state)
	MClientModel:SetHasGetReward(state);
end
