--[[
	vip激活提示
	参数:type,活动id
	houxudong
	2016年12月16日 03:46:25
]]
_G.classlist['VipItemUseChatParam'] = 'VipItemUseChatParam'
_G.VipItemUseChatParam = setmetatable({},{__index=ChatParam})
VipItemUseChatParam.objName = 'VipItemUseChatParam'

function VipItemUseChatParam:GetType()
	return ChatConsts.ChatParam_VipItemUse
end

local vipName = {"Bạch ngân","Hoàng kim","Kim cương"}
local day = {"10 ngày","30 ngày","Vĩnh viễn"}

function VipItemUseChatParam:DecodeToText(paramStr,withLink)
	local params = self:Decode(paramStr)
	if params[1] then
		local types = vipName[params[1]] or ''
		local days = ''
		if params[2] == 10 then
			days = day[1] or ''
		elseif params[2] == 30 then
			days = day[2] or ''
		else
			days = day[3] or ''
		end
		return "<font color='#ffffff'>"..types..days.."</font>";
	else
		return "";
	end
end
