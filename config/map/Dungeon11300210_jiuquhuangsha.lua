CurrentSceneScript = {}
CurrentSceneScript.Humans = {}
CurrentSceneScript.Scene = nil

CurrentSceneScript.killNum = 0
-----------------------------------------------------------

function CurrentSceneScript:Startup()
  self.SModDungeon = self.Scene:GetModDungeon()
  _RegSceneEventHandler(SceneEvents.HumanEnterWorld,"OnHumanEnter")
  _RegSceneEventHandler(SceneEvents.HumanLeaveWorld,"OnHumanLeave")
  _RegSceneEventHandler(SceneEvents.DungeonRandomEvent,"OnDungeonRandomEvent")
  _RegSceneEventHandler(SceneEvents.MonsterKilled,"OnMonsterKilled")
  _RegSceneEventHandler(SceneEvents.MonsterKilled,"OnBossKilled",{param1 = 10201022})
  _RegSceneEventHandler(SceneEvents.MonsterKilled,"OnBossKilled",{param2 = 10201025})
	_RegSceneEventHandler(SceneEvents.HumanStoryStep,"OnHumanStoryStep")
end

function CurrentSceneScript:Cleanup() 
	
end

function CurrentSceneScript:OnHumanEnter(human)
   self.SModDungeon:LaunchStory(human)
end

function CurrentSceneScript:OnHumanLeave(human)  
	
end

function CurrentSceneScript:GetDropBloodPer(id)
   return 0
end

function CurrentSceneScript:GetRandomEvent(stepid)
   return 0
end

function CurrentSceneScript:OnDungeonRandomEvent(param)  
end

function CurrentSceneScript:OnMonsterKilled(monster,killer,id)
--第一波小怪被杀
  if id == 10201021 then
    self.killNum = self.killNum + 1

    if self.killNum >= 10 then
       --self:OnHumanStoryStep(3701002)
       self.killNum = 0
    end
  end
  
  --第二波小怪被杀
  if id == 10201023 then
    self.killNum = self.killNum + 1

    if self.killNum >= 10 then
       --self:OnHumanStoryStep(3701004)
       self.killNum = 0
    end
  end
  
  
  --第三波小怪被杀
  if id == 10201024 then
    self.killNum = self.killNum + 1

    if self.killNum >= 20 then
	   self.SModDungeon:DungeonBlock("block004",0,false)
	   self.SModDungeon:GetNextStory(701006)
       self:SpawnMuDianZhu()
       self.killNum = 0
    end
  end
end

function CurrentSceneScript:OnBossKilled(boss,killer,id)
--第一波boss被杀
    if id == 10201022 then
	   
    end
--最终大boss
	if id == 10201025 then
      self.SModDungeon:SendHideFallStar(id)
    end
    
end

function CurrentSceneScript:OnHumanStoryStep(id)
	-- 对话Npc后   刷第一波怪
   if id == 3701021 then
	  local data = {}
      local params = 1

      data[1] = "10201021"  --怪物id  或者boss id
      data[2] = "5,5"		--随机数量
      data[3] = "503,368,100,0.0"	--怪物方向
      self.Scene:GetModScript():SpawnMonsterRandom(data,params)
      self.SModDungeon:GetNextStory(701002)
   end
   
	--第一波小怪被杀  打开第一个空气墙  刷第一波boss
   if id == 3701022 then
	  self.SModDungeon:DungeonBlock("block001",0,false)
      self.SModDungeon:GetNextStory(701003)
      local data = {}
      local params = 1

      data[1] = "10201022"
      data[2] = "1"
      data[3] = "-7,560,0,0.4"
      self.Scene:GetModScript():SpawnMonsterRandom(data,params)
   end
   
   --第一波boss 被杀  打开第二个空气墙后 刷第二波怪
   if id == 3701023 then
      self.SModDungeon:DungeonBlock("block002",0,false)
	  self.SModDungeon:GetNextStory(701004)
	  local data = {}
      local params = 1

      data[1] = "10201023"  --怪物id  或者boss id
      data[2] = "5,5"		--随机数量
      data[3] = "-405,263,50,0.0"	--怪物方向
      self.Scene:GetModScript():SpawnMonsterRandom(data,params)
   end
   
   --第二波怪 被杀  打开第三个空气墙后 刷第三波怪
   if id == 3701024 then
      self.SModDungeon:DungeonBlock("block003",0,false)
	  self.SModDungeon:GetNextStory(701005)
	  local data = {}
      local params = 1

      data[1] = "10201024"  --怪物id  或者boss id
      data[2] = "10,10"		--随机数量
      data[3] = "-110,-163,50,0.0"	--怪物方向
      self.Scene:GetModScript():SpawnMonsterRandom(data,params)
   end

end

function CurrentSceneScript:SpawnMuDianZhu()
  --击杀木殿主
  local bossid = 10201025
  local xpos = -473
  local ypos = -531
  self.Scene:GetModSpawn():Spawn(bossid, xpos, ypos, 2.2)
end