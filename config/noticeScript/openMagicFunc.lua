--[[
打开绝学界面
参数:FuncConsts.MagicSkill  61
houxudong
2016年8月9日18:01:28
]]

NoticeScriptCfg:Add(
{
	name = "openMagic",
	execute = function()
		if not FuncManager:GetFuncIsOpen(FuncConsts.MagicSkill) then return true; end  
			FuncManager:OpenFunc(FuncConsts.MagicSkill, false, FuncConsts.MagicSkill);
		return true;
	end
}
);