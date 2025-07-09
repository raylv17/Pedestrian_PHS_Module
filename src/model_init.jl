function model_init()
    begin
        seed = 42
        properties = Dict(
            :λ => 2, :A => 5, :B => 0.3, :dt => 0.01, :sigma => 0.05,
            :no_disp_H => 0.0, :hamiltonian => 0.0, :dH => 0.0, :stoch_dH => 0.0,
            :alignment => 0.0
        )
        number_of_peds = 0
        x_len, y_len = 11, 5
        num_solver = leapfrog_step # leapfrog_step is not effected by sigma
        # num_solver = stochastic_ode_step
        model = initialize(number_of_peds, x_len, y_len, num_solver, properties; seed)
    end

    begin
        rng = Agents.abmrng(model)
        number_of_peds = 19
        for i in 1:number_of_peds
            Agents.add_agent!(model;
                # pos = Agents.normalize_position(SVector{2}([i,i]),model),
                pos = [rand(rng)*x_len, rand(rng)*y_len],  # Initial position
                vel = [0.0,0.0], # Initial velocity
                # uᵢ = mod(i,4) == 0 ? [1,0] : mod(i,4) == 1 ? [-1,0] : mod(i,4) == 2 ? [0, 1] : [0, -1], # custom
                # uᵢ = mod(i,3) == 0 ? [1,0] : mod(i,3) == 1 ? [-1,0] : [1,1], # custom
                # uᵢ = mod(i,2) == 0 ? [1,0] : [-1,0] # counter_flow
                uᵢ = mod(i,2) == 0 ? [0,1] : [1,0] # cross
                # uᵢ = [1.0,0.0] # uni flow
                # uᵢ = [0,0]
            )
        end
    end
    return model
end