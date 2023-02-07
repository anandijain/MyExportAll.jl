using Test, MyExportAll, BenchmarkTools
include("mod.jl")
using .Foo, .Bar, .Baz
@test !@isdefined(x)
@test @isdefined(A)
@test foo() == 5
@test y(1) == 1
@test names(Foo) == [:A, :Foo, :foo, :y]

importall!(Bar)
@test names(Bar) == [:B, :Bar, :C, :bar, :z]

# not e
# @btime exportAll(Baz) # 435.417 μs (2294 allocations: 156.95 KiB)
@btime exportall(Baz) # 35.500 μs (260 allocations: 11.95 KiB)
# importall!(Baz)


names(Baz)