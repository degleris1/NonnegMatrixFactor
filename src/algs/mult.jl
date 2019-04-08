module Mult


# Imports
using LinearAlgebra
include("../core.jl")  # Core


function update!(data, W, H, meta; kwargs...)
    if (meta == nothing)
        meta = Meta(data, W, H)
    end

    W .*= _mult_rule(data, W, H)
    H .*= _mult_rule(data', H', W')'
    
    # Cache resids
    meta.resids = data - W * H

    return norm(meta.resids) / meta.data_norm, meta
end


"""
Private
"""


mutable struct Meta
    resids
    data_norm
    function Meta(data, W, H)
        resids = data - W * H
        data_norm = norm(data)
        return new(resids, data_norm)
    end
end


function _mult_rule(X, W, H)
    return (X * H') ./ (W * H * H' .+ Core.EPSILON)
end


end  # module
