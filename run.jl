using InteractiveUtils
versioninfo()
flush(stdout)

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

while true
    gradients = Zygote.gradient(Zygote.Params([p])) do
        sol = solve(prob, Tsit5())
        return sol[1][1]
    end
end
