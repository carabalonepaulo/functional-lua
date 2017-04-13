--
-- table.__basefs
--
-- Método de inicialização do processo
--
-- t    tabela
-- e    expressão
-- s    recursos de outro escopo
-- return var, result, v, f, ov, rt
--
function table.__basefs(t, e, s)
    local var, result, v = e:match('^(%w+)%s?'), {}, nil
    local f = loadstring(e:gsub(var..'%s?[-=]>', 'return'))
    local ov, rt = rawget(_G, var), {}
    if s then
        for k, v in pairs(s) do
            rawset(rt, k, rawget(_G, k))
            rawset(_G, k, v)
        end
    end
    return var, result, v, f, ov, rt
end

--
-- table.__basefe
--
-- Método de finalização do processo
--
-- var  nome da variável da expressão
-- ov   valores antigos globais
-- s    funções e recursos utilizados de outro escopo
-- rt   tablea de valores antigos globais para funções
--
function table.__basefe(var, ov, s, rt)
    if s then
        for k, v in ipairs(s) do
            rawset(_G, k, rawget(rt, k))
        end
    end
    rawset(_G, var, ov)
end

--
-- table.select
--
-- Itera sobre a table e filtra seus itens com a expressão definida.
--
-- t    table
-- e    expressão
-- return table
--
function table.where(t, e, s)
    local var, result, v, f, ov, rt = table.__basefs(t, e, s)
    for i = 1, #t do
        v = rawget(t, i)
        rawset(_G, var, v)
        if f() then rawset(result, #result + 1, v) end
    end
    table.__basefe(var, ov, s, rt)
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
function table.map(t, e, s)
    local var, result, v, f, ov, rt = table.__basefs(t, e, s)
    for i = 1, #t do
        rawset(_G, var, rawget(t, i))
        rawset(result, #result + 1, f())
    end
    table.__basefe(var, ov, s, rt)
    return result
end
