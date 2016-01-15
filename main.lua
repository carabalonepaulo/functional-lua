function table.where(t, e)
    local var, f, result, v = e:sub(1, 1), loadstring('return '..e), {}, nil
    for i = 1, #t do
        v = rawget(t, i)
        rawset(_G, var, v)
        if f() then rawset(result, #result + 1, v) end
    end
    rawset(_G, var, nil)
    return result
end

function table.select(t, e)
    local var, f, result = e:sub(1, 1), loadstring('return '..e), {}
    for i = 1, #t do
        rawset(_G, var, rawget(t, i))
        rawset(result, #result + 1, f())
    end
    rawset(_G, var, nil)
    return result
end

local tabl = {1, 2, 3, 4, 5, 6, 7, 8, 9}
local t = table.where(tabl, 'x >= 5')
local x = table.select(tabl, 'x + 1')

for _, i in pairs(t) do print(i) end
