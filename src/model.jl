module NMF


# Exports
export fit_nmf


# Imports
using LinearAlgebra
include("./core.jl")  # Core
include("./algs/mult.jl")  # Mult
include("./algs/hals.jl")  # HALS


ALGORITHMS = Dict(
    :mult => Mult,
    :hals => HALS,
)


struct NMFresults
    data
    W
    H
    time_hist
    loss_hist
    function NMFresults(data, W, H, time_hist, loss_hist)
        return new(data, W, H, time_hist, loss_hist)
    end
end


function fit_nmf(data; K=3, alg=:mult,
                 max_itr=100, max_time=Inf,
                 kwargs...)
    # Initialize
    W, H = init_rand(data, K)
    W = get(kwargs, :initW, W)
    H = get(kwargs, :initH, H)

    meta = nothing

    # Set up optimization history
    loss_hist = [Core.compute_loss(data, W, H)]
    time_hist = [0.0]

    # Update
    itr = 1
    while (itr <= max_itr) && (time_hist[end] <= max_time)
        itr += 1

        # Update and time
        t0 = time()
        loss, meta = ALGORITHMS[alg].update!(data, W, H, meta; kwargs...)
        dur = time() - t0

        # Record time and loss
        push!(time_hist, time_hist[end] + dur)
        push!(loss_hist, loss)
    end

    return NMFresults(data, W, H, time_hist, loss_hist)
end


function init_rand(data, K)
    N, M = size(data)

    W = rand(N, K)
    H = rand(K, M)

    est = W * H
    alpha = (reshape(data, N*M)' * reshape(est, N*M)) / norm(est)^2
    W *= sqrt(alpha)
    H *= sqrt(alpha)

    return W, H
end


end  # module
