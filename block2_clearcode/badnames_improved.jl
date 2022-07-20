# # Case 1
function trajectory(ds::DiscreteDynamicalSystem, total_time::Int, state = ds.u0; kwargs...)
    integ = integrator(ds, state)
    trajectory_discrete(integ, total_time; kwargs...)
end

# Notice how we can use `integrator` inside the function!
# It is a local name, and we don't use the existing `DynamicalSystems.integrator`
# function, so it is valid to use. There is no name conflict.
# However, generally speaking, I would not advice using established
# library names (like `integrator` here) as variables, as it could lead to
# confusion. In actual package code I would use `integ` instead of `integrator``
function trajectory_discrete(integrator, total_time;
        time_step::Int = 1, transient_time::Int = 0
    )
    t0 = current_time(integrator)
    timevec = (t0+transient_time):time_step:(t0+total_time+transient_time)
    transient_time ≠ 0 && step!(integrator, transient_time)
    traj = [get_state(integrator)]
    for i in 2:length(timevec)
        step!(integrator, time_step)
        push!(traj, get_state(integrator))
    end
    return timevec, traj
end



# Case 2
function saturation_pressure(temperatures)
    satur_press_water = equilibrium_vapor_pressure_water.(temperatures)
    satur_press_ice = equilibrium_vapor_pressure_ice.(temperatures)
    is_only_water = temperatures .> constants.triple_point_h2o
    is_only_ice = temperatures .< (constants.triple_point_h2o - 23.0)

    satur_press = @. (
        satur_press_ice
        + (satur_press_water - satur_press_ice)
        * ((temperatures - constants.triple_point_h2o + 23) / 23) ^ 2
    )
    satur_press[is_only_ice] = satur_press_ice[is_only_ice]
    satur_press[is_only_water] = satur_press_water[is_only_water]
    return satur_press
end