-- title:  game title
-- author: game developer
-- desc:   short description
-- script: lua

function stir_up(p)
  p.dy = -p.speed
  p.dx = 0
end

function stir_down(p)
  p.dy = p.speed
  p.dx = 0
end

function stir_left(p)
  p.dx = -p.speed
  p.dy = 0
end

function stir_right(p)
  p.dx = p.speed
  p.dy = 0
end

players = {
  bolek={
    name="Bolek";
    x=0, y=0, dx=0, dy=0, speed=1;
    controls={
      [58]=stir_up,
      [59]=stir_down,
      [60]=stir_left,
      [61]=stir_right
      -- 63 is ctrl, 50 is return
    },
    state="walking",
    animations={
      idle={273},
      walking={257,273,289}
    }
  },
  lolek={
    name="Lolek",
    x=32, y=32, dx=0, dy=0, speed=1;
    controls={
      [23]=stir_up,   -- W
      [19]=stir_down, -- S
      [1]=stir_left,  -- A
      [4]=stir_right  -- D
      -- 49 is tab
    },
    state="idle",
    animations={
      idle={274},
      walking={258,274,290}
    }
  }
}

level = {
  offset={x=8*6, y=0}
}

function mod(a,b)
  return math.floor(math.fmod(a,b))
end

function draw_element(p)
  local anim = p.animations[p.state]
  local t = math.floor(time() / 150)
  debug(t)
  local frame = 1
  if #anim > 1 then
    frame = 1 + mod(t, #anim)
  end
  local sprite = anim[frame]
  spr(sprite, p.x + level.offset.x, p.y + level.offset.y, 8)
end

function control_player(p)
  local pressed = false
  for key_id, fun in pairs(p.controls) do
    if key(key_id) then
      fun(p)
      pressed = true
      p.state = "walking"
    end
  end
  if not pressed then
    p.dx = 0
    p.dy = 0
    p.state = "idle"
  end
end

function update_player(p)
  p.x = p.x + p.dx
  p.y = p.y + p.dy
end

function debug(x)
  print(x, 20, 19, 0, false, 1, true)
  print(x, 20, 21, 0, false, 1, true)
  print(x, 19, 20, 0, false, 1, true)
  print(x, 21, 20, 0, false, 1, true)

  print(x, 20, 20, 10, false, 1, true)
end

function TIC()
  control_player(players.bolek)
  control_player(players.lolek)

  update_player(players.bolek)
  update_player(players.lolek)

  cls()
  map(0,0,30,17,0,0)
  --rectb(0,0,240,136,3)
  draw_element(players.bolek)
  draw_element(players.lolek)
end

-- <TILES>
-- 001:6666666666666666676666666666667666666666666766666666666666666666
-- 002:fccccccccddddddecddddddeceeeeeeeccccfcccdddecddddddecdddeeeeceee
-- 003:cccccccccddddddecddddddecddddddecddddddecddddddecddddddeeeeeeeee
-- </TILES>

-- <SPRITES>
-- 000:88888888888883588880de88880d008880ce000880d000088800008888700778
-- 001:8888888888000088809b99088099990888000088809999088000000880888808
-- 002:8888888888000088802322088022220888000088802222088000000880888808
-- 003:8888888888000088806566088066660888000088806666088000000880888808
-- 004:888888888800008880dcdd0880dddd088800008880dddd088000000880888808
-- 016:88888888888885388880de88880d008880ce000880d000088800008888700778
-- 017:8888888888000088809b99088099990888000088809999088000000888088088
-- 018:8888888888000088802322088022220888000088802222088000000888088088
-- 019:8888888888000088806566088066660888000088806666088000000888088088
-- 020:888888888800008880dcdd0880dddd088800008880dddd088000000888088088
-- 033:8888888888000088809b99088099990888000088809999088000000888800888
-- 034:8888888888000088802322088022220888000088802222088000000888800888
-- 035:8888888888000088806566088066660888000088806666088000000888800888
-- 036:888888888800008880dcdd0880dddd088800008880dddd088000000888800888
-- 049:8888888888000088809b99088099990888000088809999088000000888888088
-- 050:8888888888000088802322088022220888000088802222088000000888888088
-- 051:8888888888000088806566088066660888000088806666088000000888888088
-- 052:888888888800008880dcdd0880dddd088800008880dddd088000000888888088
-- 065:8888888888000088809b99088099990888000088809999088000000888088888
-- 066:8888888888000088802322088022220888000088802222088000000888088888
-- 067:8888888888000088806566088066660888000088806666088000000888088888
-- 068:888888888800008880dcdd0880dddd088800008880dddd088000000888088888
-- </SPRITES>

-- <MAP>
-- 000:000000000000101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 001:000000000000103020301030203010302030103020301000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 002:000000000000102020201020202010202020102020201000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 003:000000000000103020301030203010302030103020301000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 004:000000000000101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 005:000000000000103020301030203010302030103020301000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 006:000000000000102020201020202010202020102020201000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 007:000000000000103020301030203010302030103020301000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 008:000000000000101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 009:000000000000103020301030203010302030103020301000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 010:000000000000102020201020202010202020102020201000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 011:000000000000103020301030203010302030103020301000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 012:000000000000101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 013:000000000000103020301030203010302030103020301000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 014:000000000000102020201020202010202020102020201000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 015:000000000000103020301030203010302030103020301000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 016:000000000000101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </MAP>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- 004:f5d8edb9543444556aabbba999889aa8
-- </WAVES>

-- <SFX>
-- 000:040004000400040004000400040004000400040004000400040004000400040004000400040004000400040004000400040004000400040004000400534000000000
-- </SFX>

-- <FLAGS>
-- 000:10001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 001:10000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </FLAGS>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b7642c717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

