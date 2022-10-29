using InteractiveUtils
versioninfo()
flush(stdout)  # So it actually gets logged on the cluster

GC.enable_logging(true)

# Uncomment these lines if running in a Docker container
# using Pkg
# Pkg.instantiate()

using OrdinaryDiffEq, SciMLSensitivity, Zygote

function rhs(u, p, t)
    θ, ω = u
    return [ω, -p[1] * sin(θ)]
end

u0 = ones(2)
tspan = (0.0, 0.1)
p = ones(10000)  # Dummy params

prob = ODEProblem(rhs, u0, tspan, p)

iter = 0
while true
    global iter += 1

    gradients = Zygote.gradient(Zygote.Params([p])) do
        sol = solve(prob, Tsit5())
        return sol[1][1]
    end

    if (iter % 1000) == 0
        @info "Free memory" Sys.free_memory() / 2^30
        @info "Free physical memory" Sys.free_physical_memory() / 2^30
        flush(stderr)
    end
end
