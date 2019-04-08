module Core


# Imports
using LinearAlgebra


# Constants
EPSILON = eps()

function compute_loss(data, W, H)
    return norm(data - W * H) / norm(data)
end

end  # module
