﻿--[[
	世界BOSS右侧面板
	2015年9月10日, PM 09:17:39
	wangyanwei
]]
_G.UIWorldBossRight = BaseUI:new('UIWorldBossRight');

UIActivity:RegisterChild(ActivityConsts.T_WorldBoss,UIWorldBossRight)


UIWorldBossRight.activityId = 0;
function UIWorldBossRight:Create()
	self:AddSWF("zhanchangRightPanel.swf", true, nil);
end

function UIWorldBossRight:OnLoaded(objSwf)
	objSwf.btnEnter.htmlLabel = UIStrConfig['activity005'];
	objSwf.btnEnter.click = function() self:OnBtnEnterClick(); end;
	objSwf.btnRule.rollOver = function() self:OnBtnRuleOver() end;
	objSwf.btnRule.rollOut = function() TipsManager:Hide()end;
	
	objSwf.rewardlist.itemRollOver = function (e) TipsManager:ShowItemTips(e.item.id); end
	objSwf.rewardlist.itemRollOut = function () TipsManager:Hide(); end
end

function UIWorldBossRight:OnShow()
	local activity = ActivityModel:GetActivity(self.activityId);
	if not activity then return; end
	local cfg = activity:GetCfg();
	if not cfg then return; end
	local objSwf = self.objSwf;
	if not objSwf then return; end
	objSwf.bgLoader.source = ResUtil:GetActivityJpgUrl(cfg.bg);
	objSwf.nameLoader.source = ResUtil:GetActivityUrl(cfg.nameIcon.."_b");
	objSwf.explainLoader.source = ResUtil:GetActivityUrl(cfg.explain);
	
	local cfg = t_activity[self.activityId];
	if not cfg then return end
	
	--[[if cfg.openTime == '00:00:00' and cfg.duration == 0 and cfg.enter_time == 0 then
		objSwf.tfTime.text = StrConfig['worldBoss501'];
	else
		local openTimeList = activity:GetOpenTime();
		local str = "";
		for i,openTime in ipairs(openTimeList) do
			local startHour,startMin = CTimeFormat:sec2format(openTime.startTime);
			local endHour,endMin = CTimeFormat:sec2format(openTime.endTime);
			str = str .. string.format("%02d:%02d-%02d:%02d",startHour,startMin,endHour,endMin);
			str = str .. " ";
		end
		objSwf.tfTime.text = str;
	end
	
	if cfg.needLvl <= MainPlayerModel.humanDetailInfo.eaLevel then
		objSwf.tfLevel.htmlText = string.format(StrConfig["activity001"],cfg.needLvl);
	else
		objSwf.tfLevel.htmlText = string.format(StrConfig["activity002"],cfg.needLvl);
	end]]
	objSwf.result.htmlText = StrConfig["activity"..self.activityId]
	if activity:CanIn() == 1 then
		objSwf.btnEnter.disabled = false;
	else
		objSwf.btnEnter.disabled = true;
	end
	objSwf.rewardlist.dataProvider:cleanUp();
	local rewardStr = "";
	local rewardlist = activity:GetRewardList();
	if rewardlist then
		for i,vo in ipairs(rewardlist) do
			rewardStr = rewardStr .. vo.id .. "," .. vo.count;
			if i < #rewardlist then
				rewardStr = rewardStr .. "#";
			end
		end
	end
	local rewardStrList = RewardManager:Parse(rewardStr);
	
	objSwf.rewardlist.dataProvider:push(unpack(rewardStrList));
	objSwf.rewardlist:invalidateData();
end

function UIWorldBossRight:OnHide()

end

function UIWorldBossRight:OnBtnRuleOver()
	local objSwf = self.objSwf;
	if not objSwf then return; end
	if StrConfig["activityru"..self.activityId] then
		TipsManager:ShowBtnTips(StrConfig["activityru"..self.activityId],TipsConsts.Dir_RightDown);
	end
end

--检查是否可进入
function UIWorldBossRight:CheckCanIn()
	local objSwf = self.objSwf;
	if not objSwf then return; end
	local activity = ActivityModel:GetActivity(self.activityId);
	if not activity then return; end
	if activity:CanIn() == 1 then
		objSwf.btnEnter.disabled = false;
	else
		objSwf.btnEnter.disabled = true;
	end
end

function UIWorldBossRight:OnBtnRuleOver()
	local objSwf = self.objSwf;
	if not objSwf then return; end
	if StrConfig["activityru"..self.activityId] then
		TipsManager:ShowBtnTips(StrConfig["activityru"..self.activityId],TipsConsts.Dir_RightDown);
	end
end

-- function UIActivityDefault:OnBtnRuleOut()
-- 	TipsManager:Hide();
-- end

function UIWorldBossRight:OnBtnEnterClick()
	FuncManager:OpenFunc(FuncConsts.WorldBoss);
end

function UIWorldBossRight:HandleNotification(name,body)
	if not self.bShowState then return; end
	if name == NotifyConsts.ActivityState then
		if body.id == self.activityId then
			self:CheckCanIn();
		end
	end
end

function UIWorldBossRight:ListNotificationInterests()
	return {NotifyConsts.ActivityState};
end

function UIWorldBossRight:SignUpPhase()

end