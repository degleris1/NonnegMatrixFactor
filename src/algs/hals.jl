module HALS


# Imports
using LinearAlgebra: norm
include("../core.jl")  # Core


function update!(data, W, H, meta; kwargs...)
    if (meta == nothing)
        meta = Meta(data, W, H)
    end

    _update_block!(data, W, H, meta.resids)  # Update W
    _update_block!(data', H', W', meta.resids')  # Update H
    
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

    
function _update_block!(data, W, H, resids)
    M, K = size(W) 
    
    for k = 1:K
        resids .+= W[:, k] * H[k, :]'
        W[:, k] = max.(0, (resids * H[k, :]) ./ (norm(H[k, :])^2 + Core.EPSILON))
        resids .-= W[:, k] * H[k, :]'
    end
end



end  # module


