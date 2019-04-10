module KLMult


# Imports
using LinearAlgebra: norm


function update!(data, W, H, meta; kwargs...)

    W .*= _mult_rule(data', H', W')'
    H .*= _mult_rule(data, W, H)
    
    return kl_loss(data, W, H), meta
end


function _mult_rule(X, W, H)
    return (W' * (X ./ (W * H))) ./ (W' * ones(size(X)))
end


function kl_loss(X, W, H)
    return norm(X .* log.(X ./ (W * H)) - X + W * H)
end



end  # module
