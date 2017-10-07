﻿--[[
战印
参数:type,战印id
lizhuangzhuang
2015年11月6日22:31:30
]]

_G.WarPrintChatParam = setmetatable({},{__index=ChatParam});

function WarPrintChatParam:GetType()
	return ChatConsts.ChatParam_WarPrint;
end

function WarPrintChatParam:DecodeToText(paramStr,withLink)
	local params = self:Decode(paramStr);
	local id = toint(params[1]);
	local cfg = t_zhanyin[id];
	if not cfg then return ""; end
	local qualityStr = "";
	if cfg.quality == 3 then
		qualityStr = "cam phẩm chất";
	elseif cfg.quality == 4 then
		qualityStr = "đỏ phẩm chất";
	end
	local str = qualityStr.."<font color='"..TipsConsts:GetItemQualityColor(cfg.quality).."'>"..cfg.name.."</font>";
	return str;
end
