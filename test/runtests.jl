using Test
include("../src/TupleBuilder.jl")
import Main.TupleBuilder: Tupler, build

@testset "simple tuple build" begin
    t = Tupler()
    push!(t, 12)
    push!(t, 34)
    push!(t, 56)
    tpl = build(t)

    @test length(tpl) == 3
    @test tpl[1] == 12
    @test tpl[2] == 34
    @test tpl[3] == 56
end


@testset "named tuple build" begin
    t = Tupler()
    push!(t, :a, 12)
    push!(t, "b", 34)
    push!(t, "c", 56)
    tpl = build(t)

    @test length(tpl) == 3
    @test tpl.a == 12
    @test tpl.b == 34
    @test tpl.c == 56
end

@testset "constructor apguments" begin
    t = Tupler(12)
    push!(t, 34)

    tpl = build(t)
    @test tpl[1] == 12

    tn = Tupler(:a, 12)

    tpln = build(tn)
    @test tpln.a == 12
end

@testset "a multi-builded Tupler" begin
    t = Tupler(12)
    push!(t, 34)
    tpl1 = build(t)
    push!(t, 56)
    push!(t, 78)
    tpl2 = build(t)

    @test length(tpl1) == 2
    @test length(tpl2) == 4
end
