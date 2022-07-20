# name comparison

function get_them(b)
    list = []
    for x in b
        if x.status == 4
            push!(list, x)
        end
    end
    return list
end

function flaggedcells(gameboard)
    flagged = []
    for cell in gameboard
        if cell.status == FLAGGED
            push!(flagged, cell)
        end
    end
    return flagged
end

# intention revealing names
a, b, c = 1, 2, 3
# versus
speed = 3
days_since_creation = 1

# magical constant
function add_nucleotide_matrices(m1, m2)
    L = size(m1)[1]
    out = zeros(L, 4)
    for i in 1:L
        for j in 1:4
            out[i, j] = m1[i, j] + m2[i, j]
        end
    end
    return out
end

# Verbosity
for left_index in 1:10
    for right_index in 1:10
        m[left_index, right_index] = rand()
    end
end
# versus
for i in 1:10
    for j in 1:10
        m[i, j] = rand()
    end
end

# unicode
cross(psi1, psi2)
ψ₁ ⊗ ψ₂

∇ρ = gradient(ρ)
⟨ε★⟩ = Γ * mean(ε★) / λ

F↑ = upwards_solar_radiation(data)
F↓ = downwards_solar_radiation(data)
α = F↑/F↓ # surface albedo

const ℜ = Real



# Functional programming
function load_sequence(id)
    # first find a suitable download location
    download_repo = nothing
    for repo in ALL_REPOS
        if id in repo.index
            download_repo = repo
            break
        end
    end
    isnothing(download_repo) && error("No download")

    # actually download the sequence
    validate(download_repo.connection, id)
    protein_sq = download_sq(id, download_repo)

    # Check sequence
    for aacid in "BXZJOU"
        if aacid in protein_sq
            error("Invalid sequence")
        end
    end

    return protein_sq
end

function load_sequence(id)
    repo = find_repo(id)
    protein_sq = download_sq(repo, id)
    validate(protein_sq)
    return protein_sq
end

function load_sequence(id)
    seq = download_seq(id)

    # calculate the complement; exchange C-G, A-T
    complement_map = Dict(
        'A' => 'T', 'T' => 'A',
        'C' => 'G', 'G' => 'C'
    )
    complement = copy(seq)
    not_recognized = 'N'
    for i in 1:length(complement)
        n = seq[i]
        complement[i] = get(complement_map, n, not_recognized)
    end

    cleaned_seq = remove_flaning_n(complement)
    return cleaned_seq
end

# unwanted side effect
function check_authentification(username, password)
    user = get_user(username)
    encoded = encode(password)
    if user.encoded_pass == encoded
        initialize_user_session()
        return true
    else
        return false
    end
end


# %% Keyword propagation
function plot_field_cor(X, Y; kwargs...)
    z = spatial_cor(X, Y)
    color = maximum(z) > 10.0 ? "C0" : "C1"
    plot_field(z; color, kwargs...)
end

function plot_field(X; color = "C0", marker = "o")
    # do the actual plotting
end

# main function
function load_sequence(id)
    seq = download_seq(id)
    validate(seq)
    return seq
end

function download_seq(id)
    # implementation
end

function validate(seq)
    # implementation
end



# Bad comments:
# validate protein sequence
valid = validate_sequence(protein_seq)

# return true if all aminoacids are valid
!valid && error("Invalid")

toks = split(line)
# toks[5] contains the raw p-value, toks[6] the test number
adj_pval = calculate_adj_pval(float(toks[5]), float(toks[6]))

# versus:
raw_pval = toks[5]; testno = toks[6]
adj_pval = calculate_adj_pval(raw_pval, testno)

# Good comments
# this test requires ~1h on local machine; can't run on CI
@test crazy = longtest(val)

# matches genomic regions in the format <id>:<start>-<end>
genomic_regex = r"([^:]+):(\d+)-(\d+)$"

# TODO: Generalize to higher dims
for i in 1:5
    stuff...
end

# Perform eqs. (19) and (20) from Datseris et al., 2019
x = 5y^2 + 2

B = 5 # magnetic field (in Tesla)
V = 2.5 # potential (in eV)

# good value for peak detection
const PEAK = 7


# spacing
b*b-4*a*c         # no
b * b - 4 * a * c # no
b*b - 4*a*c       # yes!

a = b && (x .< y)/(z^2) # no!
a=b&&(x.<y)/(z ^ 2)     # yes

f(x,y;z=3)     # no!
f(x, y; z = 3) # yes!
f(x, y; z=3)   # debatable!

# Floats:
# Yes:     # No:
0.1        .1
2.0        2.
3.0f0      3.f0


# unicode
⊗ = crossproduct
ψ₁ = gaussianstate(x, y)
ψ₂ = gaussianstate(x, y+0.1)
prod = ψ₁ ⊗ ψ₂



# Metrics implementation
module Metrics

abstract type PreMetric end
abstract type SemiMetric <: PreMetric end
abstract type Metric <: SemiMetric end

"""
    distance(x, y, m::Metric)
Calculate the distance between `x, y` according to the
metric space defined by `m`, which can be any
subtype of `Metric`.
"""
function distance(x, y, metric::Metric)
    error("Distance not implemented for $(typeof(metric))")
end

struct Chebyshev <: Metric end
function distance(x, y, ::Chebyshev)
    s = zero(eltype(x))
    for i in eachindex(x)
        s += abs(x[i] - y[i])
    end
    return s
end

function pairwise(metric::PreMetric, a, b = a)
    r = zeros(length(a), length(b))
    @inbounds for (j, bj) in enumerate(b)
        for (i, ai) in enumerate(a)
            r[i, j] = metric(ai, bj)
        end
    end
    return r
end



export Metric, Chebyshev, distance, pairwise
end # module Metrics


# Extension
using Metrics
struct RandomMetric <: Metric end
function Metrics.distance(x, y, ::RandomMetric)
    return rand()
end

# now this works:
x = y = [rand(100) for _ in 1:10]
pairwise(x, y, RandomMetric())





# Testing code
using Test # module from Standard Library

@testset "MyPackageTests" begin
    @testset "arithmetic" begin include("math_tests.jl") end
    @testset "trigonometric" begin include("trig_tests.jl") end
end

# e.g., "math_tests.jl" has:
@test 1 + 1 == 2
@test 1 - 1 == 0
