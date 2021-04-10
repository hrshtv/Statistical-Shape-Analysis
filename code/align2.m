%{
    Description: Align two given pointsets of equal cardinality via similarity 
    transformations using the formulation suggested in [Cootes et al. 1995 CVIU] 
    where they solve for the scale, translation, and rotation jointly.
    
    Inputs:
        x1 [DxN] : The standardized pointset that serves as the alignment 
              reference
        x2 [DxN] : The standardized pointset being aligned to x1
    
    Outputs:
        aligned [DxN] : x2 after being aligned to x1 via the estimated 
        scaling, translation, and rotation.
%}

function aligned = align2(x1, x2)
   
    N = size(x1, 2); 
    
    % Pre-processing, all Nx1
    x1_x = x1(1, :);
    x1_y = x1(2, :);
    x2_x = x2(1, :);
    x2_y = x2(2, :);
    
    % All 1x1, variables defined as specified in the paper
    X1 = sum(x1_x(:)); 
    X2 = sum(x2_x(:));
    Y1 = sum(x1_y(:));
    Y2 = sum(x2_y(:));
    
    Z = sum(x2_x.^2 + x2_y.^2);
    
    C1 = sum( (x1_x .* x2_x) + (x1_y .* x2_y) );
    C2 = sum( (x1_y .* x2_x) - (x1_x .* x2_y) );
    
    W = N; % This is sum_{k} w_k of the weights which in this case we have assumed to be all 1
    
    % Solving the linear equations:
    A = [X2 -Y2 W 0; Y2 X2 0 W; Z 0 X2 Y2; 0 Z -Y2 X2]; % 4x4
    b = [X1; Y1; C1; C2]; % 4x1
    parameters = pinv(A) * b; % 4x1
    
    ax = parameters(1);
    ay = parameters(2);
    tx = parameters(3);
    ty = parameters(4);
    
    sR = [ax -ay; ay ax]; % The scaling+rotation matrix
    T  = [tx; ty]; % The shift
    
    % Return the aligned shape
    aligned = sR*x2 + T;
    
end

