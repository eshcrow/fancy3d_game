--[[
�������ż�
����:
@param activityId �id
lizhuangzhuang
2015��11��26��04:35:56
]]

NoticeScriptCfg:Add(
{
	name = "openswyj",
	execute = function(activityId)
		if not activityId then return false; end
		local activityId = toint(activityId);
		if not activityId then return false; end
		ActivityController:EnterActivity(activityId,{param1=1})
		return true;
	end
}
);