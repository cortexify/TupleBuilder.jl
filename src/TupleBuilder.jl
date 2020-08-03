"""
A tiny library for creating tuples incrementally.

In order to use it:

* Create a Tupler object `t = Tupler()`
* Append elements by calling well known Base.push! function, such as `push!(t, 123)`, or `push!(t, :a, 123)`, or `push!(t, (t, "a", 123))`
* Then build your tuple `mytuple = build(t)`.
"""
baremodule TupleBuilder

using Base #: Core, push!

eval(x) = Core.eval(TupleBuilder, x)
const eq = Symbol("=")

"The data holder for builder"
struct Tupler
    tuple::Expr
    "Create an empty Tupler"
    Tupler() = new(Expr(:tuple))
    "Creates a Tupler to build a simple tuple, and `val` will be the first element"
    Tupler(val) = push!(Tupler(), val)
    "Creates a Tupler to build a named tuple, and `name=val` will be the first element"
    Tupler(name::Symbol, val) = push!(Tupler(), name, val)
    "Creates a Tupler to build a named tuple, and `name=val` will be the first element"
    Tupler(name::String, val) = push!(Tupler(), name, val)
end

function Base.push!(t::Tupler, it)
    push!(t.tuple.args, it)
    t
end

function Base.push!(t::Tupler, name::Symbol, val)
    ex = Expr(eq, name, val)
    push!(t.tuple.args, ex)
    t
end

Base.push!(t::Tupler, name::String, val) = push!(t, Symbol(name), val)

build(t::Tupler) = eval(t.tuple)

export Tupler, build
end # module
