function exportall(mod)
    for n in names(mod, all = true)
        if Base.isidentifier(n) && n ∉ (Symbol(mod), :eval)
            @eval mod export $n
        end
    end
end

function exportAll(m)
    inI = []
    out = []
    res = []

    for name in Base.names(m, all=true)
        push!(out, :(export $(name)))
    end

    for name in Base.names(m, all=false, imported=true)
        push!(inI, :(export $(name)))
    end

    for name in Base.names(Main.Base, all=false, imported=true)
        push!(inI, :(export $(name)))
    end

    for name in Base.names(Main.Core, all=false, imported=true)
        push!(inI, :(export $(name)))
    end

    for e in out
        if e in inI || e == :(export include) || '#' in string(e)
            continue
        end
        push!(res, :($(e)))
    end
    #= Do not export things that we already have =#
    Expr(:block, res...)
end

macro exportAll()
    exportAll(__module__)
end
