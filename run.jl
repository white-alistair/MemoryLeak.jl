using OrdinaryDiffEq, Zygote, SciMLSensitivity

GC.enable_logging(true)

function rhs(u, p, t)
    x, y, z = u
    σ, β, ρ = p[1:3]
    return [σ * (y - x), x * (ρ - z) - y, x * y - β * z]
end

u0 = rand(3)
tspan = (0.0, 0.1)
p = rand(10000)
p[1:3] = [10.0, 8 / 3, 28.0]

prob = ODEProblem(rhs, u0, tspan, p)

while true
    gradients = Zygote.gradient(Zygote.Params([p])) do
        sol = solve(prob, Tsit5())
        return sol[1][1]
    end
end
