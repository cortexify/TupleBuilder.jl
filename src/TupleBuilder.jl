baremodule TupleBuilder

using Base #: Core, push!

eval(x) = Core.eval(TupleBuilder, x)
const eq = Symbol("=")
struct Tupler
    tuple::Expr
    Tupler() = new(Expr(:tuple))
    Tupler(val) = push!(Tupler(), val)
    Tupler(name::Symbol, val) = push!(Tupler(), name, val)
    Tupler(same::String, val) = push!(Tupler(), name, val)
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
