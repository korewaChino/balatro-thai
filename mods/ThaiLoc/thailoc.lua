----------------------------------------------
------------MOD CODE -------------------------


sendDebugMessage("Loading Thai Language Pack")
SMODS.Atlas { key = "blind_chips", path = "BlindChips.png", px = 34, py = 34, prefix_config = { key = false }, atlas_table = 'ANIMATION_ATLAS', frames = 21 }

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
    SMODS.Atlas { key = "blind_chips", path = "textures/BlindChips.png", px = 34, py = 34, prefix_config = { key = false }, atlas_table = 'ANIMATION_ATLAS', frames = 21 }
end


----------------------------------------------
------------MOD CODE END----------------------
