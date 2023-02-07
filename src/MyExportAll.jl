module MyExportAll
# include("old.jl")
function is_module_function(m, n)
    isdefined(m,n) &&
    (length(methods(getproperty(m, n))) > 0) &&
        n != :eval &&
        n != :include
end

function module_functions(m)
    ns = names(m; all=true, imported=true)
    unique!(filter!(n -> is_module_function(m, n), ns))
end

function exportall(m)
    Expr(:export, module_functions(m)...)
end

macro exportall()
    exportall(__module__)
end

function exportall2(mod)
    for n in names(mod, all = true)
        if Base.isidentifier(n) && n ∉ (Symbol(mod), :eval)
            @eval mod export $n
        end
    end
end

"effectively imports everything by using the module eval to export everything"
function importall!(m)
    m.eval(exportall(m))
end

"effectively imports everything by using the module eval to export everything"
function importall!(evalm, m)
    evalm.eval(exportall(m))
end

function importall!()
    m = @__MODULE__
    m.eval(exportall(m))
end

export module_functions, exportall, @exportall, importall!, exportall2# , exportAll, @exportAll

end