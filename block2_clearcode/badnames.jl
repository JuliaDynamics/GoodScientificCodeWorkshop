# # Case 1
function traj(ds::DiscreteDynamicalSystem, t::Int, u = ds.u0; kwargs...)
    i = integrator(ds, u)
    trajdiscr(i, t; kwargs...)
end

function trajdiscr(i, t; dt::Int = 1, ttr::Int = 0)
    t0 = current_time(i)
    tv = (t0+ttr):dt:(t0+total_time+ttr)
    ttr ≠ 0 && step!(i, ttr)
    data = Vector{typeof((get_state(i))}(undef, L)
    data = [get_state(i)]
    for i in 2:length(timevec)
        step!(i, dt)
        push!(data, get_state(i))
    end
    return timevec, data
end

# Case 2
function sat_pres(t)
    e_eq_w_t = e_eq_water_mk.(t)
    e_eq_i_t = e_eq_ice_mk.(t)
    water = t .> constants.Ttr
    ice = t .< (constants.Ttr - 23.0)

    e_eq = @. (
        e_eq_i_t
        + (e_eq_w_t - e_eq_i_t)
        * ((t - constants.Ttr + 23) / 23) ^ 2
    )
    e_eq[ice] = e_eq_i_t[water]
    e_eq[water] = e_eq_w_t[water]
    return e_eq
end