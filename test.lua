require 'main'

local x = setmetatable({1, 2, 3, 4, 5, 6, 7, 8, 9}, {__index = table})
local t = x:where 'exp -> exp >= 5'
local z = x:select 'x -> x + 0'

for _, i in ipairs(z) do print(i) end
