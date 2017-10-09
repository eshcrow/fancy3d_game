--[[
��ʯ��Ƭ�����仯
����:��ⱳ����ʯ��Ƭ��û�дﵽĳ����ʯ��������
wangshuai
]]


ItemNumCScriptCfg:Add(
{
	name = "gemdebrischang",
	execute = function(bag,pos,tid)
		local curRoleLvl = MainPlayerModel.humanDetailInfo.eaLevel -- ��ǰ����ȼ�
		local gemlist = {}
		local gemid = 0;
		for i,info in pairs(t_equipgem) do
			for i=1,3 do 
				local lvl = info["lv"..i];
				if lvl  <= curRoleLvl then 
					table.push(gemlist,info["slot"..i]);
				end;
			end;
		end;
		for i,info in ipairs(gemlist) do 
			local cfg = t_gemgroup[info];
			local gem = EquipModel:GetGemServerinfo(info)
			if gem then -- ��ǰ״̬�б�ʯ
				if gemid == 0 then gemid = gem.id end;
				local curgem = EquipModel:GetGemServerinfo(gemid)
				if curgem.lvl > gem.lvl then 
					gemid = gem.id;
				end;
			else -- û��ʯ
				gemid = info;
				break;
			end;
		end;
		local endcfg = EquipModel:GetGemServerinfo(gemid)
		if not endcfg then 
			endcfg = t_gemgroup[gemid];
			if not endcfg then return end;
			endcfg["lvl"] = 0;
		end;
		if not endcfg then return end;
		local num = endcfg.lvl + 1;
		if num > 10 then num = 10 end;
		local debirsNum = t_gemcost[num];
		if not debirsNum then return end;
		if debirsNum.num >= t_gemcost[10].num then print("all gem max lvl") return end; --����������ȼ�������
		if BagModel:GetItemNumInBag(tid) >= debirsNum.num then
			UIItemGuide:Open(3);
		end
	end
}
);