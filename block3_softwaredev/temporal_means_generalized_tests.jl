include("temporal_means_generalized.jl")
using Dates
using Test

# This file tests only `monthlyagg`.
# Of course, many more tests should be written for aggregating
# over different time spans!

@testset "monthly means" begin
    @testset "API" begin
        t2 = [Date(2003, 3, 15), Date(2001, 11, 2)]
        @test_throws AssertionError monthlyagg(t2, rand(2))
        t = [Date(2003, 3, 15), Date(2004, 11, 2)]
        w, y = monthlymeans(t, x)
        w2, y2 = monthlyagg(t, x)
        @test w == w2
        @test y == y2
    end
    @testset "standard ranges" begin
        # hourly
        t = DateTime(2000, 3, 1):Hour(1):DateTime(2001, 4, 15)
        x = [month(a) for a in t]
        w, y = monthlyagg(t, x)
        @test length(y) == length(w) == 14
        # all output midpoints must have day in 14, 15, 16
        # irrespectively of month, because of how dates work.
        # However, last month has half the days!
        for i in 1:length(w)-1
            @test 14 ≤ day(w[i]) ≤ 16
        end
        @test 7 ≤ day(w[end]) ≤ 8
        @test y == month.(w)
        # daily
        t = Date(2001, 3, 1):Day(1):Date(2002, 1, 31)
        x = [month(a) for a in t]
        w, y = monthlyagg(t, x)
        @test length(y) == length(w) == 11
        # Mid point day depends on whether month has 30 or 31 days
        # (no leap years on this span)
        mids = [isodd(daysinmonth(a)) ? 16 : 15 for a in w]
        @test day.(w) == mids
        @test y == month.(w)
    end
    @testset "already monthly" begin
        t1 = Date(2000, 3, 15):Month(1):Date(2005, 3, 31)
        t2 = [Date(2003, 3, 15), Date(2004, 11, 2)]
        for t in (t1, t2)
            x = ones(length(t))
            w, y = monthlyagg(t, x)
            @test all(isequal(1), y)
            @test w == t
        end
    end
    @testset "actual averaging" begin
        t = [Date(2001, 3, 1), Date(2001, 3, 2), Date(2001, 4, 1), Date(2001, 4, 2)]
        x = [1, 2, 1, 2]
        # output must have 2 months, each with the average of 1, 2, i.e., 1.5
        w, y = monthlyagg(t, x)
        @test length(y) == length(w) == 2
        @test y[1] == y[2] == 1.5
    end
    @testset "different aggregations" begin
        t = [Date(2001, 3, 1), Date(2001, 3, 2), Date(2001, 4, 1), Date(2001, 4, 2)]
        x = [1, 3, 1, 3]
        s2 = sqrt(2)
        # std
        w, y = monthlyagg(t, x; agg = std)
        @test y[1] == y[2] == s2
        # length
        w, y = monthlyagg(t, x; agg = length)
        @test y[1] == y[2] == 2
        # negative fractions
        x = [0.5, -0.5, 0.25, 0.1]
        neg_fracts(vals) = count(v -> v < 0, vals)/length(vals)
        w, y = monthlyagg(t, x; agg = neg_fracs)
        @test y[1] == 0.5
        @test y[2] == 0
    end
end
