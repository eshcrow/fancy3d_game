--[[
本地配置管理
lizhuangzhuang
2014年8月25日12:06:59
]]
_G.classlist['ConfigManager'] = 'ConfigManager'
_G.ConfigManager = {};
_G.ConfigManager.objName = 'ConfigManager'

ConfigManager.config = nil;
ConfigManager.roleConfig = nil;

--加载全局配置
function ConfigManager:convert( chars, dist, inv )
	return string.char( ( string.byte( chars ) - 32 + ( inv and -dist or dist ) ) % 95 + 32 )
end

function ConfigManager:crypt(str,k,inv)
	local enc= "";
	for i=1,#str do
		if(#str-k[5] >= i or not inv)then
			for inc=0,3 do
				if(i%4 == inc)then
					enc = enc .. self:convert(string.sub(str,i,i),k[inc+1],inv);
					break;
				end
			end
		end
	end
	if(not inv)then
		for i=1,k[5] do
			enc = enc .. string.char(math.random(32,126));
		end
	end
	return enc;
end

function ConfigManager:Load()
	local configStr = _sys:readConfig('usercfg\\config.cfg');
	if configStr == "" then
		self.config = {};
	else
		--self.config = json.decode(configStr);
				-- ThemGai-Design Fix Login
		local enc1 = {5, 7, 4, 6, 10};
		local str = tostring(configStr);
		local crypted = self:crypt(str,enc1,true);
		self.config = json.decode(configStr);
		 file = _File.new();
		 name = "usercfg\\configUnpack.cfg";
		 file:create(name,'utf8');
		 file:write(tostring(configStr));
		 file:close();
	end
end

--保存配置
function ConfigManager:Save()
	local configStr = json.encode(self.config);
	_sys:writeConfig('usercfg\\config.cfg',configStr);
	--
	local roleConfigName = string.md5(tostring(MainPlayerModel.mainRoleID));
	local url = "usercfg\\"..roleConfigName..".cfg";
	local roleCfgStr = json.encode(self.roleConfig);
	_sys:writeConfig(url,roleCfgStr);
end

--获取全局配置
function ConfigManager:GetCfg()
	if not self.config then
		self:Load();
	end
	return self.config;
end

--加载玩家配置
function ConfigManager:LoadRoleCfg()
	local roleConfigName = string.md5(tostring(MainPlayerModel.mainRoleID));
	local url = "usercfg\\"..roleConfigName..".cfg";
	local configStr = _sys:readConfig(url);
	if configStr == "" then
		self.roleConfig = {};
	else
		self.roleConfig = json.decode(configStr);
	end
end

--获取玩家的配置
--@params key 不传取玩家所有配置
function ConfigManager:GetRoleCfg(key)
	if not self.roleConfig then
		self:LoadRoleCfg();
	end
	if key then
		return self.roleConfig[key];
	else
		return self.roleConfig;
	end
end