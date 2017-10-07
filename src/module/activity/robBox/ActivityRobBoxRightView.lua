--[[
	2016年8月5日, AM 12:31:25
	抢宝箱活动右侧面板
	houxudong
]]
_G.UIRobBoxRight = BaseUI:new('UIRobBoxRight');

UIActivity:RegisterChild(ActivityConsts.T_RobBox,UIRobBoxRight)

UIRobBoxRight.activityId = 0;
function UIRobBoxRight:Create()
	self:AddSWF("robBoxActivityRightPanel.swf", true, nil);
end

function UIRobBoxRight:OnLoaded(objSwf)
	objSwf.btnEnter.htmlLabel = UIStrConfig['activity005'];
	objSwf.btnEnter.click = function() self:OnBtnEnterClick(); end;
	objSwf.btnRule.rollOver = function() self:OnBtnRuleOver() end;
	objSwf.btnRule.rollOut = function() TipsManager:Hide()end;

	objSwf.rewardlist.itemRollOver = function (e) TipsManager:ShowItemTips(e.item.id); end
	objSwf.rewardlist.itemRollOut = function () TipsManager:Hide(); end
end

function UIRobBoxRight:OnShow( )
	local activity = ActivityModel:GetActivity(self.activityId);
	if not activity then return; end
	local cfg = activity:GetCfg();
	if not cfg then return; end
	local objSwf = self.objSwf;
	if not objSwf then return; end
	objSwf.bgLoader.source = ResUtil:GetActivityJpgUrl(cfg.bg);
	objSwf.nameLoader.source = ResUtil:GetActivityUrl(cfg.nameIcon.."_b");
	objSwf.explainLoader.source = ResUtil:GetActivityUrl(cfg.explain);
	objSwf.result.htmlText = StrConfig[
	"activity"..self.activityId]
	if activity:CanIn() == 1 then
		objSwf.btnEnter.disabled = false;
	else
		objSwf.btnEnter.disabled = true;
	end
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
	objSwf.rewardlist.dataProvider:cleanUp();
	objSwf.rewardlist.dataProvider:push(unpack(rewardStrList));
	objSwf.rewardlist:invalidateData();
end

function UIRobBoxRight:OnBtnRuleOver()
	local objSwf = self.objSwf;
	if not objSwf then return; end
	if StrConfig["activityru"..self.activityId] then
		TipsManager:ShowBtnTips(StrConfig["activityru"..self.activityId],TipsConsts.Dir_RightDown);
	end
end

function UIRobBoxRight:CheckCanIn()
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

function UIRobBoxRight:OnBtnEnterClick()
	if TeamModel:IsInTeam() then   
		local func = function ( )
			TeamController:QuitTeam()
			self:limitClick()
		end
		UIConfirm:Open(StrConfig['fubenentertema001'],func)
	else
		self:limitClick()
	end
end

--限制频繁点击
function UIRobBoxRight:limitClick()
	if self.timeKey then
		return
	end
	local func = function ()
		TimerManager:UnRegisterTimer(self.timeKey);
		self.timeKey = nil;
	end
	self.timeKey = TimerManager:RegisterTimer(func,3000,1);
	ActivityController:EnterActivity(self.activityId);
end

function UIRobBoxRight:HandleNotification(name,body)
	if not self.bShowState then return; end
	if name == NotifyConsts.ActivityState then
		if body.id == self.activityId then
			self:CheckCanIn();
		end
	end
end

function UIRobBoxRight:ListNotificationInterests()
	return {NotifyConsts.ActivityState};
end

function UIRobBoxRight:SignUpPhase()

end