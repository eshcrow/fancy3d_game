--[[
2�����Ԥ������
lizhuangzhuang
2015��7��9��22:01:43
]]
local t = 0;
local flyOver = false;

QuestScriptCfg:Add(
{
	name = "wingpreviewguide",
	--stopQuestGuide = true,--ͣ����
	
	steps = {
		
		--��1s
		[1] = {
			type = "normal",
			execute = function() t = GetCurTime();  return true; end,
			complete = function() 
				if t == 0 then
					t = GetCurTime();
				end
				return GetCurTime()-t > 1000; 
			end,
			Break = function() return false; end,
		},
		
		--�ȹ��˾���
		[2] = {
			type = "normal",
			execute = function() 
				t = 0;
				return true; 
			end,
			complete = function() t=0; return not StoryController:IsStorying(); end,
			Break = function() return false; end
		},
		
		--�������Ϸ���ʾ
		[3] = {
			type = "normal",
			execute = function() return true; end,
			complete = function() UIWingRightOpen:Show("guide"); return true; end,
			Break = function() return false; end
		},
		
		--�ȴ������
		[4] = {
			type = "normal",
			execute = function() return true; end,
			complete = function() return UIWingRightOpen:IsFullShow(); end,
			Break = function() return false; end
		},
		
		[5] = {
			type = "normal",
			execute = function() t = GetCurTime();  return true; end,
			complete = function() 
				if t == 0 then
					t = GetCurTime();
				end
				return GetCurTime()-t > 1000; 
			end,
			Break = function() return false; end,
		},
		
		--����Ч
		[6] = {
			type = "normal",
			execute = function()
						t = 0;
						local flyVO = {};
						flyVO.startPos = {x=_rd.w/2,y=_rd.h/2};
						flyVO.endPos = UIWingRightOpen:GetStarEndPos();
						flyVO.time = 0.5;
						flyVO.url = ResUtil:GetWingStarEffect();
						flyVO.tweenParam = {};
						flyVO.tweenParam.delay = 0.2;
						flyVO.onComplete = function()
							UIWingRightOpen:PlayBombEff();
							flyOver = true;
						end
						FlyManager:FlyEffect(flyVO);
						return true; 
					end,
			complete = function() return flyOver; end,
			Break = function() return false; end
		},
		
		[7] = {
			type = "normal",
			execute = function() flyOver=false; t = GetCurTime();  return true; end,
			complete = function() 
				if t == 0 then
					t = GetCurTime();
				end
				return GetCurTime()-t > 2000; 
			end,
			Break = function() return false; end
		},
		

	}
});