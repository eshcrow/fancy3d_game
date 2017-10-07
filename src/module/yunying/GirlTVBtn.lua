--[[
美女直播按钮
lizhuangzhuang
2015年12月22日13:48:32
]]

_G.GirlTVBtn = BaseYunYingBtn:new();

YunYingBtnManager:RegisterBtnClass(YunYingConsts.BT_GirlTV,GirlTVBtn);

function GirlTVBtn:GetStageBtnName()
	return "ButtonGirlShow";
end

function GirlTVBtn:IsShow()
	return true;
end

function GirlTVBtn:OnBtnClick()
	local cfg = ConfigManager:GetCfg();
	local name = "";
	if cfg.accountName then
		name = cfg.accountName;
	end
    if name == "" then
        UIConfirm:Open("Vui lòng đăng nhập lại game và thử lại nhận AlphaTest!");
        return
    end
	_sys:browse("http://id.daithanhvan.com/qua-alpha/"..name);
end