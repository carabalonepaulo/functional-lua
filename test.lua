require 'main'

local x = setmetatable({1, 2, 3, 4, 5, 6, 7, 8, 9}, {__index = table})
local t = x:where 'exp >= 5'
local x = x:select 'x + 1'

for _, i in pairs(t) do print(i) end
