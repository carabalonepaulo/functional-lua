--
-- table.select
--
-- Itera sobre a table e filtra seus itens com a expressão definida.
--
-- t    table
-- e    expressão
-- return table
--
function table.where(t, e)
    local var, result, v = e:match('^(%w+)%s?'), {}, nil
    local f = loadstring(e:gsub(var..'%s?[-=]>', 'return'))
    local ov = rawget(_G, var)
    for i = 1, #t do
        v = rawget(t, i)
        rawset(_G, var, v)
        if f() then rawset(result, #result + 1, v) end
    end
    rawset(_G, var, ov)
    return result
end

--
-- table.select
--
-- Itera sobre a table e obtém o resultado da expressão em uma nova table
--
-- t    table
-- e    expressão
-- return table
--
function table.select(t, e)
    local var, result, v = e:match('^(%w+)%s?'), {}, nil
    local f = loadstring(e:gsub(var..'%s?[-=]>', 'return'))
    local ov = rawget(_G, var)
    for i = 1, #t do
        rawset(_G, var, rawget(t, i))
        rawset(result, #result + 1, f())
    end
    rawset(_G, var, ov)
    return result
end
