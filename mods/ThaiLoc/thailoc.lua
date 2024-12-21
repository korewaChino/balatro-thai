--- STEAMODDED HEADER
--- MOD_NAME: Thai Balatro: Soberized Edition
--- MOD_ID: THLocale
--- MOD_AUTHOR: [Aikoyori, korewaChino]
--- MOD_DESCRIPTION: A Thai localization mod for Balatro, uses 2005_iannnnnAMD
--- PRIORITY: 9999999999
--- DISPLAY_NAME: Thai Balatro: Soberized Edition
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-1217c]

----------------------------------------------
------------MOD CODE -------------------------
SMODS.Language({
    key = "th_TH",
    label = "ไทย",
    font = {
        file = "2005_iannnnnAMD.ttf",
        render_scale = G.TILESIZE * 16,
        TEXT_HEIGHT_SCALE = 0.65,
        TEXT_OFFSET = { x = 10, y = -40 },
        FONTSCALE = 0.13,
        squish = 1,
        DESCSCALE = 1,
    },
    beta = true,
    button = "ข้อเสนอแนะ",
    warning = { 'ภาษานี้ยังอยู่ในช่วงทดสอบ เพื่อช่วยเรา', 'ปรับปรุงโปรดคลิกที่ปุ่มข้อเสนอแนะ', 'คลิกอีกครั้งเพื่อยืนยัน' },
    path = "th_TH.lua",
})
if SMODS.Atlas then
    SMODS.Atlas({
        key = "modicon",
        path = "icon.png",
        px = 32,
        py = 32
    })
end

----------------------------------------------
------------MOD CODE END----------------------
