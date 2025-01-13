----------------------------------------------
------------MOD CODE -------------------------


sendDebugMessage("Loading Thai Language Pack")
SMODS.Atlas { key = "blind_chips", path = "BlindChips.png", px = 34, py = 34, prefix_config = { key = false }, atlas_table = 'ANIMATION_ATLAS', frames = 21 }

SMODS.Language({
    key = "th_TH",
    label = "ไทย",
    font = {
        file = "ThemPixels9x16mix.ttf",
        render_scale = G.TILESIZE*10, 
        TEXT_HEIGHT_SCALE = 0.4, 
        TEXT_OFFSET = {x=10,y=-140}, 
        FONTSCALE = 0.125, 
        squish = 1, 
        DESCSCALE = 1
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
