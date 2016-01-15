require 'main'

function incr(a)
    return a + 1
end

local x = setmetatable({1, 2, 3, 4, 5, 6, 7, 8, 9}, {__index = table})
local t = x:where 'exp -> exp >= 5'
local z = x:select('x -> incr(x)', {incr = incr})

for _, i in ipairs(t) do print(i) end
