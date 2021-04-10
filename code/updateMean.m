%{
    Description: Finds the optimal shape mean given the aligned pointsets
    
    Inputs:
        aligned_pointsets [DxNxM] : The pointsets aligned using optimize1.m or optimize2.m 
        normalize [boolean] : Specifies whether to normalize the mean or
        not. If we work in the preshape space, this is required, but it's
        not needed in the second approach

    Outputs:
        mu [DxN] : The mean pointset
%}

function mu = updateMean(aligned_pointsets, normalize)

    % Shape mean is just the average of the aligned pointsets
    mu = mean(aligned_pointsets, 3); % DxN
    
    % Projection on the constraint set (unit norm)
    if normalize
        temp = mu .^ 2;
        scale = sqrt(sum(temp(:)));
        mu = mu / scale;
    end
    
end

