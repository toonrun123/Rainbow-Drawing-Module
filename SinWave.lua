--[[
SIN CALCULATE:
x = wave ตัวแปลคลื่น
a = height wave ความสูงคลื่น
h = wave position จุดเริ่มคลื่น
b = wave noise คลื่นความถี่
k = wave Position Y คลื่นเวกเตอร์ Y
]]
local sine = {}

export type sinself = {x:number,a:number,h:number,b:number,k:number}

function sine:wave()
	local s = self
	if s["x"] and s["a"] and s["h"] and s["b"] and s["k"] then
		return s["a"]*math.sin((s["x"]-s["h"])/s["b"])+s["k"]
	end
end

function sine:new(x,a,h,b,k):sinself
	local s = self
	s["x"] = x or 0
	s["a"] = a or 2
	s["h"] = h or 0
	s["b"] = b or 50
	s["k"] = k or 0
	return s
end

return sine
