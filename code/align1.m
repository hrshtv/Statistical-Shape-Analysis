%{
    Description: Align two given pointsets of equal cardinality via similarity 
    transformations assuming that the pointset representations are standardized
    to pre-shape space.
    
    Inputs:
        ref [DxN] : The standardized pointset that serves as the alignment 
              reference
        p   [DxN] : The standardized pointset being aligned to ref
    
    Outputs:
        aligned [DxN] : p after being aligned to ref via rotation
%}

function aligned = align1(ref, p)
    
    [D, N] = size(ref);
    
    W = eye(N); % Assume weights to be identity
    
    XWY = p * W * ref'; % DxD
    
    [U, ~, V] = svd(XWY);
    
    R = V * U'; % DxD
    
    % If det is -1, follow the results obtained by [S Umeyama 1991 IEEE, Kanatani 1994 IEEE TPAMI]
    if det(R) < 0 % In theory, it should be det(R) == -1, but <0 is used to ensure numerical stability
        corner = eye(D);
        corner(D, D) = -1;
        R = V * corner * U';
    end
    
    aligned = R*p;
    
end

