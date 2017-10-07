--[[
天神技能tips
]]

_G.UITransforSkillTips = BaseUI:new("UITransforSkillTips");

UITransforSkillTips.tansformodel = nil;

function UITransforSkillTips:Create()
	self:AddSWF("TransforSkillTips.swf",true,"float");
end


function UITransforSkillTips:Open(tansformodel)
	self.tansformodel = tansformodel;
	if self:IsShow() then
		self:OnShow();
	else
		self:Show()
	end
end

function UITransforSkillTips:Close()
	self:Hide();
end

function UITransforSkillTips:OnShow()
	local objSwf = self.objSwf;
	if not objSwf then return; end
	local tipsX,tipsY = TipsUtils:GetTipsPos(objSwf.bg._width,objSwf.bg._height,self.tipsDir);
	objSwf._x = tipsX;
	objSwf._y = tipsY;
	--
	local cfg = t_tianshen[self.tansformodel.tid];

	local iszhantianshen = true
	if not cfg then
		--cfg = t_wuhunachieve[self.tansformodel]
		iszhantianshen = false
	end
	if not cfg then
		self:Hide()
		return 
	end
	
	if iszhantianshen then
		objSwf.tfTitle.htmlText ="<font color='#f9680c'>" .. cfg.name .. "</font>";
		--objSwf.tfTitle2.htmlText = StrConfig['tianshen028'];	
	end
	
	local skillList = {}
	local skills=t_tianshenlv[self.tansformodel.step]
	if not skills then return end
	local skillList=GetCommaTable(skills.skill)
   
	if not skillList or #skillList <= 0 then return end
	for k,v in pairs (skillList) do
		
		local skillVO = t_skill[toint(v)]
	
		if skillVO then
			-- 技能名 等级 
			local str = "";
			str = str .. "<font size='14' color='#ff6600'>" .. skillVO.name .. "</font><br/>";
			str = str .. "<font size='12' color='#d5b772'>" .. skillVO.keyword .. "</font>";
			objSwf["skill"..k].tf.htmlText = str;
			objSwf["skill"..k].loader.source = ResUtil:GetSkillIconUrl(skillVO.icon,"54");
		end
	end
end

function UITransforSkillTips:HandleNotification(name,body)
	if name == NotifyConsts.StageMove then
		local objSwf = self.objSwf;
		if not objSwf then return; end
		local tipsX,tipsY = TipsUtils:GetTipsPos(objSwf.bg._width,objSwf.bg._height,TipsConsts.Dir_RightUp);
		objSwf._x = tipsX;
		objSwf._y = tipsY;
	end
end

function UITransforSkillTips:ListNotificationInterests()
	return {NotifyConsts.StageMove};
end

function UITransforSkillTips:GetNum(num)
	if num == 1 then return 'Nhất ' 
	elseif num == 2 then return 'Nhị '
	elseif num == 3 then return 'Tam '
	elseif num == 4 then return 'Tứ '	
	elseif num == 5 then return 'Ngũ '
	elseif num == 6 then return 'Lục '
	elseif num == 7 then return 'Thất '
	elseif num == 8 then return 'Bát '
	elseif num == 9 then return 'Cửu '
	elseif num == 10 then return 'Thập '
	elseif num == 11 then return 'Thập Nhất '
	elseif num == 12 then return 'Thập Nhị '
	elseif num == 13 then return 'Thập Tam '
	elseif num == 14 then return 'Thập Tam '
	else return tostring(num);
	end
end