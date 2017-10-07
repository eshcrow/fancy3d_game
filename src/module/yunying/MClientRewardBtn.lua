--[[
΢�˽�����ť
lizhuangzhuang
2015��5��14��17:21:58
]]

_G.MClientReawrdBtn = BaseYunYingBtn:new();

YunYingBtnManager:RegisterBtnClass(YunYingConsts.BT_MClient,MClientReawrdBtn);

function MClientReawrdBtn:GetStageBtnName()
	return "MClientReward";
end

function MClientReawrdBtn:IsShow()

	if t_consts[345] then
		local constCfgNeedLevel = t_consts[345].val1
		if constCfgNeedLevel then
			local curRoleLvl = MainPlayerModel.humanDetailInfo.eaLevel -- ��ǰ����ȼ�
			if curRoleLvl < constCfgNeedLevel then return false end
		end
    end
	if Version:IsHideMClient() then
		return false;
	end
	return false;
end	
function MClientReawrdBtn:OnBtnClick()
	self:DoShowUI("UIMClientReward");
end
function MClientReawrdBtn:OnRefresh()
	if not self.button then return; end
	if _G.ismclient and not MClientModel.hasGetReward then
		self.button.effect:playEffect(0);
	else
		self.button.effect:stopEffect();
	end
end
