--[[
	2015��8��22��, PM 01:20:32
	wangyawnei
]]
_G.WeekSignModel = Module:new();

WeekSignModel.weekSignData = {};

function WeekSignModel:UpData(result,login,reward)
	if result ~= 0 then
		return
	end
	self:OnSetData(login,reward);
end

function WeekSignModel:OnSetData(login,reward)
	self.weekSignData = {};
	for i = 1 , #t_sevenday do
		self.weekSignData[i] = {};
		if i <= login then
			self.weekSignData[i].id = i;
		end
        self.weekSignData[i].login=login;
		if bit.band(reward,math.pow(2,i)) == math.pow(2,i) then
			self.weekSignData[i].state = 1;	--����ȡ
		else
			self.weekSignData[i].state = 0;	--������ȡ
		end
	end
    
end

function WeekSignModel:OnGetWeekSingData()
	return self.weekSignData;
end

--�Ƿ��н�������ȡ  ��һ��
function WeekSignModel:OnIsReward()
	if not WeekSignController.inData then
		return false
	end
	local allData = self:OnGetWeekSingData();
	for i , v in ipairs(allData) do
		if i <= 7 and v.state == 1 then
			return true;
		end
	end
	return false;
end

--�ڶ����Ƿ��н�������ȡ
function WeekSignModel:GetDoubleWeekIsReward()
	if not WeekSignController.inData then
		return false
	end
	local allData = self:OnGetWeekSingData();
	for i , v in ipairs(allData) do
		if i > 7 and v.state == 1 then
			return true;
		end
	end
	return false;
end

--���һ��Ŀ���ȡ���ս���
function WeekSignModel:OnGetRewardIndex()
	if not WeekSignController.inData then
		return 1
	end
	local allData = self:OnGetWeekSingData();
	for i , v in ipairs(allData) do
		if v.state == 1 then  --����ȡ
			return i;
		end
	end
	local index ;
	for i , v in ipairs(allData) do
		if v.state == 0 and v.id then  --������ȡ
			index = i;
		end
	end
	if index < 1 then
		return 1
	else
		if index == 7 then return 1 end
		return index
	end
	return #allData;
end

function WeekSignModel:GetProReward()
	local allData = self:OnGetWeekSingData();
	for i=#allData,1,-1 do
		if allData[i] and allData[i].id then 
		   if allData[i].state~=1 then 

		   	    return i
		   end
		end
	end
    return 1
end
--�� index �������Ƿ����ȡ����
function WeekSignModel:GetIndexIsReward(index)
	if not WeekSignController.inData then
		return false
	end
	local allData = self:OnGetWeekSingData();
	for i , v in ipairs(allData) do
		if v.id == index then  --����ȡ
			-- return i;
			if v.state == 1 then
				return true
			else
				return false
			end
		end
	end
	return false
end

--���ս������Ƿ�ȫ����ȡ���  ��һ��  ��true ȫ����ȡ��
function WeekSignModel:GetWeekInReward()
	local allData = self:OnGetWeekSingData();
	local weekSign = false;
	if #allData < 1 then return false end
	--���û�е����� ֱ�ӷ���false
	for i , v in ipairs(allData) do
		if v then
			if v.id == 7 then
				weekSign = true;
			end
		end
	end
	if not weekSign then return false; end
	
	local rewardNum = 0;
	for i , v in ipairs(allData) do
		if v and v.id and i <= 7 then
			if v.state == 0 then
				rewardNum = rewardNum + 1;
			end
		end
	end
	return rewardNum >= 7;
end

--�ڶ��ܽ����Ƿ�ȫ����ȡ���
function WeekSignModel:GetDoubleWeekReward()
	local allData = self:OnGetWeekSingData();
	if #allData < 1 then return false end
	local weekSign = false;
	for i , v in ipairs(allData) do
		if v and i <= 7 then
			if v.state ~= 0 then
				weekSign = true;
			end
		end
	end
	if weekSign then return false end
	local num = 0;
	for i , v in ipairs(allData) do
		if i > 7 then
			if v and v.id and v.state == 0 then
				num = num + 1;
			end
		end
	end
	if num >= 7 then
		return true
	end
	return false;
end

--�����û�п�����ȡ�Ľ���
function WeekSignModel:CheckCanGetReward( )
	local isDoubleWeek = self:GetWeekInReward();
	local canGetNum1 = 0;   --������ȡ�Ľ������� 
	local canGetNum2 = 0;
	-- for i = 1 , 7 do 
	-- 	if isDoubleWeek then
	-- 		local isReward = self:GetIndexIsReward(i + 7);
	-- 		if not isReward then
	-- 			break;
	-- 		else
	-- 			canGetNum1 = canGetNum1 +1
	-- 			return true,canGetNum1
	-- 		end
	-- 	end
	-- end
	local result = false;
	for i = 1, 7 do
		if not isDoubleWeek then
			local isReward = self:GetIndexIsReward(i);
			if not isReward then
				-- break;
			else
				canGetNum2 = canGetNum2 +1
				result = true;
			end
		end
	end
	if result then
		return result,canGetNum2
	end
	return result,0
end