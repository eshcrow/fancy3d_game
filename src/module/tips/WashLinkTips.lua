﻿--[[
装备强化连锁Tips
lizhuangzhuang
2014年11月18日20:00:38
]]

_G.WashLinkTips = BaseTips:new();

TipsManager:AddParseClass(TipsConsts.Type_WashLink,WashLinkTips);

WashLinkTips.tipsVO = nil;

function WashLinkTips:Parse(tipsInfo)
	self.tipsVO = tipsInfo;
	--
	self.str = "";
	--当前等级
	self.str = self.str .. self:GetTitle(self.tipsVO.linkId,self.tipsVO.activeNum);
	self.str = self.str .. self:GetVGap(4);
	self.str = self.str .. self:SetLeftMargin(self:GetAttr(self.tipsVO.linkId,self.tipsVO.activeNum),5);
	--下级
	if self.tipsVO.nextLinkId then
		self.str = self.str .. self:GetVGap(15);
		self.str = self.str .. self:GetTitle(self.tipsVO.nextLinkId,self.tipsVO.nextActiveNum);
		self.str = self.str .. self:GetVGap(13);
		self.str = self.str .. self:SetLeftMargin(self:GetAttr(self.tipsVO.nextLinkId,self.tipsVO.nextActiveNum),5);
	end
end

function WashLinkTips:GetShowIcon()
	return false;
end

function WashLinkTips:GetWidth()
	return 220;
end

--获取标题
function WashLinkTips:GetTitle(linkId,activeNum)
	local cfg = t_extrachain[linkId];
	if not cfg then return ""; end
	local str = "";
	str = str .. self:GetVGap(5);
	str = str .. "<textformat leftmargin='5'>";
	str = str .. self:GetHtmlText(cfg.name,"#ffcc33",TipsConsts.TitleSize_Two,false);
	str = str .. "</textformat>";
	str = str .. self:GetLine(10,13);
	--
	str = str .. "<textformat leftmargin='5'>";
	local s = string.format(StrConfig['tips1349'],cfg.lv);
	 s = self:GetHtmlText(s,"#e59607",TipsConsts.Default_Size,false,false);
	 str = str..s..self:GetVGap(7);
	local curalllen = cfg.lv
	if activeNum >= curalllen then 
		str = str .. self:GetHtmlText(string.format(StrConfig['tips1306'],curalllen,curalllen),"#00ff00");
	else
		str = str .. self:GetHtmlText(string.format(StrConfig['tips1307'],activeNum,curalllen),"#ff0000");
	end;
	str = str .. "</textformat>";
	return str;
end

--获取增加属性
function WashLinkTips:GetAttr(linkId,activeNum)
	local cfg = t_extrachain[linkId];
	if not cfg then return ""; end
	local str = "";
	str = str .. self:GetHtmlText(StrConfig['tips1308'],"#e59607",TipsConsts.TitleSize_Two);
	str = str .. self:GetVGap(5);
	local list = AttrParseUtil:Parse(cfg.attr);
	local attrStr = "";
	for i=1,#list do
		local attrStr = "";
		attrStr = enAttrTypeName[list[i].type];
		if activeNum >= cfg.lv then
			attrStr = self:GetHtmlText(attrStr,"#d5b772",TipsConsts.Default_Size,false);
		else
			attrStr = self:GetHtmlText(attrStr,"#5a5a5a",TipsConsts.Default_Size,false);
		end
		attrStr = "<textformat leading='-14' leftmargin='5'><p>" .. attrStr .. "</p></textformat>";
		str = str .. attrStr;
		local leading = 0;
		if i < #list then
			leading = 5;
		end
		attrStr = "+" .. getAtrrShowVal(list[i].type,list[i].val);
		if activeNum >= cfg.lv then
			attrStr = self:GetHtmlText(attrStr,"#00ff00",TipsConsts.Default_Size,false);
		else
			attrStr = self:GetHtmlText(attrStr,"#5a5a5a",TipsConsts.Default_Size,false);
		end
		attrStr = "<textformat leading='"..leading.."' leftmargin='75'><p>" .. attrStr .. "</p></textformat>";
		str = str .. attrStr;
	end
	return str;
end