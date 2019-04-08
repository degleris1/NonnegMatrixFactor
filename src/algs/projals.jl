module ProjALS


# Imports
include("../core.jl")


function update!(data, W, H, meta)
    H[:, :] = max.(0, W \ data)
    W[:, :] = max.(0, H' \ data')'

    return Core.compute_loss(data, W, H), meta    
end


end  # module
