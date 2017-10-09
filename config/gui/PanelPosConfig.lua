﻿--[[
	UI面板位置配置表
	haohu 2014年8月9日15:58:36
]]

--1. key表示对齐方式: 水平方向left, center, right; 垂直方向top, middle, bottom
--2. value表示距离或者基于窗口尺寸的百分比
--3. 默认为水平垂直居中(配表中没有配置的面板的默认对齐方式)
--例：["UIExample"] = {left = 60, middle = -0.3}
-- >>>>> left=60表示面板距离窗口左边沿60像素; middle=-0.3表示面板中心在窗口垂直高度的中心线上方，距离为窗口高度的30%处
_G.PanelPosConfig =
{
	["UICaveBossInfo"]           = {right = 0, top = 255},
	["UIYaotaInfo"]              = {right = 0, top = 255},
	["UIMainControlBar"]         = {left =0, top = 0},
	["UICreateRole"]             = {left =0, top = 0},
	["UIMainTop"]                = {left = 0, top = 0},
	["UIMainHead"]               = {left = 0, top = 0},
	["UIMainMap"]                = {top = 0, right = 0},
	["UILoginWait"]              = {left=0,top=0},
	["UIRole"]                   = {center = 0, middle = 0},
	["UISkill"]             = {center = 0, middle = 0},
	["UIBigMap"]             = {center = 0, middle = 0},
	["UISmithing"]             = {center = 0, middle = 0},
	["UIUnionUnCreate"]             = {center = 0, middle = 0},
    ["UIBabel"]             = {center = 0, middle = 0},
	["UIFengYao"] 	 			 = {center = 0, middle = 0},
	["UIYaota"]             = {center = 0, middle = 0},	
    ["UIDungeon"]             = {center = 0, middle = 0},
    ["UIActivity"]             = {center = 0, middle = 0},
    ["UIMClientReward"]             = {center = 0, middle = -100},	
	["UIHuoYueDuView"]             = {center = 0, middle = 0},
    ["UIZhuanZhiView"]             = {center = 0, middle = 0},
	["UITeam"]             = {center = 0, middle = 0},
	["UIToolHeCheng"]             = {center = 0, middle = 0},
	["UIConsigmentMain"]             = {center = 0, middle = 0},	
	['UIMainPlayerLevelUp']		 = {center = 0, middle = 80},
	["UILevelUpEffect"]          = {center = 0, middle = -280},
	["UIFashionsMainView"]       = {center = 0, middle = 0},
	["UIBag"]                    = {center = 0,  middle = 0},
	["UIShopCarryOn"]            = {center = -358, middle = 39},
	["UIShoppingMall"]           = {center = 85, middle = 0},
	["UIStorage"]                = {center = -475, middle = 15},
	["UIMainRolePKPanel"]        = {left = 20, top = 110},
	["UIChat"]                   = {left = 0, bottom = 7},
	["UIInterServiceChat"]       = {left = 0, bottom = 2},
	["UIMainQuest"]              = {right = 0, top = 188},
	["UIMainLvQuestTitle"]       = {right = 0, top = 466},
	["UITargetBoss"]             = {top = 140, left = 0.18},
	["UITargetMonster"]          = {top = 140, left = 0.18},
	["UITargetPlayer"]           = {top = 140, left = 0.18},
	["UIFloat"]                  = {top = 0, center=0},
	["UIFloatBottom"]			 = {top = 0, left = 0},
	["UIChatPrivateNotice"]      = {left=310,bottom=77},
	["UIChatGuildNotice"]      	 = {left=345,bottom=77},
	["MainSpiritsUI"]            = {center =0, middle = 0},
	["UIMultiCutEffect"]         = {left = 280, top =280},
	["UIChatPrivateMin"]         = {bottom=85,left=350},
	["UIMainSkill"]              = {bottom=0,center=0},
	["UIFullExp"]                = {bottom=0,center=0},
	["UIFriend"]                 = {center = 0, middle = 0},
	["UIDungeonStory"]           = {right = 0, top = 150},
	["UITaoFaInfo"]              = {right = 0, top = 300},
	["UIInterServicePvpStoryView"]= {right = 0, top = 300},
	["UIDungeonEvent"]           = {right = 0, top = 585},
	["UIUnionHellScene"]         = {right = 0, top = 238},
	["UIStory"]                  = {right = 0, left = 0},
	["StorySpeedUpEffect"]       = {right = 0, left = 0},
	["UIRemind"]                 = {top=0,left=0 },
	["UIDeal"]                   = {center = -359, middle = 0},
	["UIUpgradeStoneNotice"]     = {bottom=120,right=-30},
	["UIStartBalckDialog"]               = {left = 0, top = 0},
	["UIMainFightFly"]           = {top=0,left=0},
	["UIAutoBattleIndicator"]    = {center = 80, bottom = 100},
	["UIAutoRunIndicator"]       = {center = 180, bottom = 135},
	["UIAutoBuyDrug"]            = {bottom=100,right=10},
	["UIToolsCameraMain"]        = {left = 0, middle = 0},
	["UIToolsCamera"]            = {right = 0, middle = 0},
	["UIHallowsBG"]              = {center = 680, middle = 0},
	["UIMainFunc"]               = {left=0,top=0},
	["UIFuncRightOpen"]               = {left=0,top=0},
	["UIMainYunYingFunc"]        = {left=0,top=0},
	["UIFly"]                    = {left=0,top=0},
	["UIMainTeammate"]           = {left=0,top=165},
	["UISit"]                    = {center=6,bottom=140},
	["UIMount"]                  = {center =0, middle =0},
	-- ["UIRealmMainView"]          = {center =45, bottom=180},
    ["UISystemBasic"]             = {center =0, middle =0},
    ["UILovelyPetMainView"]             = {center =0, middle =0},	
	-- ["UIXingtu"]             = {center = 0, middle = 0},
	["MainWingUI"]             = {center = 0, middle = 0},	
	["UILovelyPetHeadView"]      = {left = 0, top = 0},
	["UIBeatenAnimation"]        = {left = 0, top = 0},
	["UIDungeonSingleResult"]    = {right = 0, middle = 0},
	["UIDungeonTeamResult"]      = {right = 0, middle = 0},
	["UIDungeonCountDown"]       = {left = 0, top = 170},
	["UIDungeonTeamDamage"]      = {left = 0, top = 340},
	["UIAutoBattle"]             = {center = 0, middle = 0},
	["UIWorldBossHurt"]          = {right = 0, top = 288},
	["UIMainLianXuDaJiProgress"] = {bottom = 120, center=0 },
	["UIMainXuLiProgress"]       = {bottom = 70, center=0 },
	["UIMainColletProgress"]     = {bottom = 220, center=0 },
	["UIMainZhuanshengProgress"] = {bottom = 120, center=0 },
	["UILianxuSpPfx"]            = {left = 0, top = 0},
	["UIRegisterAward"]          = {center = 0, middle = 0},
	["UIZhanChang"]              = {right = 0, top = 238},
	["UIMapName"]                = {left = 325, top = 175},
	["UIArenahp"]                = {center=0,top=0},
	["UIArenaVsAn"]              = {left=0,top=0},
	["UIXianYuanCaveInfo"]       = {right=0, top = 255},
	["UIBingNuMainView"]         = {right = 0, middle = 0},
	["UIBingNuFloat"]            = {top = 0, center=0},
	["UIMainAttr"]               = {bottom=200,center=70},
	["UIKillValue"]              = {left=0,top=300},
	["UIUnionRight"]             = {right = 0, top = 238},
	["UIBabelLayerInfo"]         = {right=0,top=255},
	["UITimerDungeonInfo"]       = {right=0,top=255},
	["UIPersonalBossInfo"]       = {right=0,top=255},
	["UIDropValue"]              = {left=325,top=0},
	["UIMainPKCaution"]          = {bottom=130,center=0},
	["UIMainPKSuspend"]          = {bottom=280,center=0},
	["UILog"]                    = {bottom=320,left=0},
	["UIFuncGuide"]              = {left=0,top=0},
	["UIActivityNotice"]         = {right=242,top=200},
	["UIExDungeonInfo"]          = {right=0, top = 255},
	["UIExDungeonMMTip"]         = {bottom=100, right = 0},
	["UIJingJieMainView"]        = {center = -260, middle = -15},
	["UIRealmBreakBossView"]     = {right = 0, top = 300},
	["UIDungeonNpcChat"]         = {left=30,bottom=250},
	["UIUnionWarCityRight"]      = {right = 0, top = 238},
	["UIskillMainPanel"]      	 = {center = 0, top = 138},
	["UITitleGetTips"]      	 = {center = 0, top = 300},
	["UISkillNewTips"]			 = {center = 0, bottom = 220},
	["UIBeicangjieInfo"]		 = {right=0,top=255},
	["UIBeicangjieBossInfo"]	 = {right=0,top=255},
	["UIUnionAcitvity"]          = {right = 240, top = 468},
	["UITimeTopSec"]          	 = {center = 0, top = 200},
	["UIMainEquipNewTips"]       = {bottom=65,right=0},
	["UIMainRelicNewTips"]       = {bottom=65,right=0},
	["UIMainWingNewTips"]       = {bottom=65,right=0},
	["UIItemGuide"]				 = {bottom=65,right=0},
	["UIItemGuideUse"]			 = {bottom=65,right=0},
	["UISafe"]			 		 = {center=0,top=200},
	["UIImportantNotice"]		 = {center=0,top=0},
	["UIStoryDialog"]			 = {left=300,bottom=0},
	-- ["UIZhimingjishaPfx"]		 = {left = 450, bottom = -30},
	["UIZhanChErjiView"]         = {right = 0, top = 238},
	["UIZhchUpFlag"]      		 = {right = 350, top = 450},
	["UIUnionWarNpcWin"]      	 = {right = 0, top = 238},
	["UIActivityBeicangjieIntegal"] = {center = 0, bottom = 238},
	["UIDominateRouteInfo"] 	 = {right = 0, top = 238},
	["UIWuhunSwitch"] 			 = {center = -280, bottom = 20},
	["UIDominateRouteMopupInfo"] = {center = 0, bottom = 238},
	["UIFuncOpenModel"]			 = {center =0, bottom = 200},
	["UIFengYaoConfirmView"] 	 = {left = 297, top = 393},
	["UIFengYao"] 	 			 = {center = 0, middle = -30},
	["UIMagicSkillBasic"] 	 	 = {center = 0, middle = 0},
	["UIFriendReward"]			 = {right = 10, bottom = 100},
	["UIMainKillRecord"] 	 	 = {left = 0, top = 393},
	["UILingShouMuDiChallView"]  = {right = 0, middle = 0},
	["UIExtremitChallengeInfo"]  = {right=0,top=255},
	["UIWaterDungeonProgress"]   = {right = 0, middle = 0},
	["UISitAreaIndicator"]       = { center = 0, top = 200 },
	["UILingShouMuDiMainView"]   = {center = 0, middle = 0},
	["UIAchievementTip"]  		 = {center = 0, bottom = 250},
	["UIWingRightOpen"]			 = {bottom = 130, center=-310},
	["UIWingOpenTips"]			 = {bottom = -520, center=-10},
	["UIWingPreview"]			 = {center =0, bottom = 200},
	["UIWingOpen"]               = {center =-605, bottom = 550},
	["UIWingGet"]               = {center =-605, bottom = 550},
	["UIWuqiOpen"]               = {center =-605, bottom = 550},
	["UIYuanbaoOpen"]               = {center =-605, bottom = 550},
	["UIMascotComeInfo"]         = {right =0, top = 238},
	["UILevelAwardOpen"]		 = {center = -50, middle = -150},
	["UIRedPacketRemindView"]	 = {center = 250, middle = 170},
	["UIRedPacketRemindMarry"]	 = {center = 170, middle = 170},
	["UIRandomDungeonGuide"]	 = {right = 0, middle = 0},
	["UIStoryChapter"]           = {left=0,top=0},
	["UIWelcome"]				 = {center=0,middle=-100},
	["UIRandomDungeonPrompt"]    = {center = 0, top = 200},
	["UICaveBossTip"]   		 = {right = 220, top = 356},
	["UIAutoBattleTip"]   		 = {center = 0, bottom = 200},
	["UIParticle"]   		     = {center = 0, middle = -60},
	["UIMonsterSiegeInfo"]   	 = {right = 0, top = 238},
	["UIUnionBossWindow"]		 = {right = -10, top = 238},
	["UIWeekSign"]		 		 = {center = 0, middle = 0},
	["UILingLiGet"]		 		 = {right = 0, bottom = 200},
	["UIQiZhanDungeonInfo"]		 = {right = 0, top = 238},
	["UIDekaronDungeonInfo"]		 = {right = 0, top = 238},
	["UIZhuanWindow"]		 	 = {right = 0, top = 238},
	["UIMoscotComeNotice"]		 = {left = 150, bottom = 200},
	["AchievementBtnView"]		 = {top = 210, right = 0},
	["UIZhuanshOpen"]			 = {bottom = 140, center=-240},
	["UIBingHunShow"]			 = {center =0, bottom = 200},
	["UIInterServiceMinPanel"]	 = {left=0,bottom=420},
	["UIOperTips"]				 = {right=450,top=200},
	["UIJewellPanel"]            = {center = 0, middle = 0},
	["UIXiuweiEffectView"]        = {top=59,left=485},
	["UIPersonalBossAutoBtn"]	 = {right = 0, top = 638},
	["UIUnionDiGongZhuiZongView"]= {right = 0, top = 238},
	["UISWYJRight"]              = {right = 0, top = 288},
	["UIInterServiceBossStory1"]           = {right = 0, top = 300},
	["UIInterServiceBossStory2"]           = {right = 0, top = 300},
	["UIInterServiceBossStory4"]           = {right = 0, top = 300},
	["UIInterServiceBossAddBlood"]         = {bottom = 75, center=240},
	["UIArenaSkip"]           	 = {bottom = 75, right=75},
	["UIInterContestStory"]      = {right = 0, top = 300},
	["UIInterContestPreStory"]   = {right = 0, top = 300},
	["UIMarryCopy"]              = {right = 0, top = 50},
	["UIMarrySendMoneyView"]	 = {center = 0, middle = 170},
	["UIMarrySuifengzi"]		 = {center = 0, middle = 170},
	["UIFabaoSwitch"]			 = {bottom = 250, center=200},
	["UIGoal"]				 	= {left = -30, bottom = 330},
	["UIMainXiuweiPool"]		= {left = 400, top = 9},
	["UIGoldenBossInfoPanel"]   = {right = 0, middle = -100},
	["UIArena"]					= {center =0, middle=0},
	["UITianShenView"]					= {center =0, middle=0},	
	["UIUpdateNoticeView"]       = {center =-500, middle=-200},
	["UIInterSSRight"]    		 = {right = -13, top = 238},
	["UIInterSerSceneMainPage"]           = {left=0,top=165},
	["UIWarPrintHouse"]           = {left=790,top=240},
	["UIWarPrintExchange"]        = {left=630,top=180},
	["UILunchInfo"]		          = {right=0,top=256},
	["UIRobBoxInfo"]		      = {right=0,top=256},
	["UIRemindFuncView"]			= {bottom=65,right=0},
	["UIRemindFuncTipsView"]		= {left=0, top=0},
	["UICurrencyFlyView"]			= {left=0, top=0},
	["UIMail"]				 = {center = 0, middle = 0},
	["UIGodDynastyInfo"]         = {right=0,top=255},
	["UIMakinobattleInfo"]          = {right=0,top=255},
	["UIExpBuffUseView"]			= {bottom=65,right=0},
	["UISmallEye"]			= {top=24,right=0},
}

--[[\
组位置
组位置也可以支持水平方向的对齐方式了，注意！只是支持水平，不支持垂直levelup[
key表示对齐方式: 水平方向left, center, right;
]]
_G.PanelPosGroup = {
	[1] = {panels={"UIRole","UIBag"},gap=0 , center = 10},
	[2] = {panels={"UIStorage","UIBag"},gap=20},
	[3] = {panels={"UIShopCarryOn","UIBag"},gap=-13},
	[4] = {panels={"UIDeal","UIBag"},gap=-31},
	[5] = {panels={"UIRedPacketListMarry","UIRedPacketListView"},gap=20},
	[6] = {panels={"UIWarPrintHouse","UIWarPrintExchange"},gap=-5, center=-100},
	[7] = {panels={"UIBag", "UITianshenBag"}, gap = 0},
}