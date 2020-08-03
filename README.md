# TupleBuilder.jl

A tiny library for creating tuples incrementally.

In order to use it:

* Create a Tupler object `t = Tupler()`
* Append elements by calling well known Base.push! function, such as `push!(t, 123)`, or `push!(t, :a, 123)`, or `push!(t, (t, "a", 123))`
* Then build your tuple `mytuple = build(t)`.
