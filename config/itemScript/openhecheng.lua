--[[
�򿪺ϳ�
lizhuangzhuang
2015��7��10��12:26:44
]]

ItemScriptCfg:Add(
{
	name = "openhecheng",
	execute = function(bag,pos)
		local bagVO = BagModel:GetBag(bag);
		if not bagVO then return; end
		local item = bagVO:GetItemByPos(pos);
		if not item then return; end
		FuncManager:OpenFunc(FuncConsts.HeCheng,false,BagModel.compoundMap[item:GetTid()]);
		return true;
	end
}
);