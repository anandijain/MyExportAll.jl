module Foo
    using MyExportAll
    x = 1
    y = y->y
    foo() = 5
    struct A x end
    @exportall
end

module Bar
    a = 1
    z = y->y
    bar() = 5
    struct B x end
    struct C a; b; c end
    C(x) = C(1,x,3)
end

module Baz
    module Buz 
        using MyExportAll
        buz() = 1
        # @exportall
    end
    using MyExportAll, .Buz

    b = 1
    c = y->y
    baz() = 5
    struct D x end
    # @exportall
    export Buz
end
