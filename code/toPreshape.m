%{
    Description: Standardizes the pointset to pre-shape space
    
    Inputs:
        p   [DxN] or [DxNxM] : Pointset(s)
    
    Outputs:
        aligned [DxN] or [DxNxM] : Standardized pointset(s)
%}

function p = toPreshape(p)

    N = size(p, 2);
    % Shift
    centroids = sum(p, 2) ./ N; % Dx1xM or Dx1
    p = p - centroids;
    % Scale
    temp = p .^ 2; % DxNxM or DxN
    scale = sqrt(sum(sum(temp, 1), 2)); % 1x1xM or 1xM
    p = p ./ scale;
    
end

