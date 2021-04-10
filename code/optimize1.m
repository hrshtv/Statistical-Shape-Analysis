%{
    Description: Runs the algorithm in the pre-shape space and uses
    align1.m
    
    Inputs:
        pointsets [DxNxM] : The set of pointsets
        mu_init [DxN] : The initial estimate for the mean
        eps [1x1] : The threshold value at which we stop the iterations
        N_max [1x1] : The max. number of iterations to go on
    
    Outputs:
        mu [DxN] : The final estimate for the mean
        pointsets [DxNxM] : The final set of aligned pointsets
%}

function [mu, aligned_pointsets] = optimize1(pointsets, mu_init, eps, N_max)
    
    [~, N, M] = size(pointsets);
    mu_prev = mu_init;
    aligned_pointsets = pointsets;
    
    i_iter = 0;
    while true
        
        % Stop if too many iterations
        if i_iter >= N_max
            break;
        end
        
        % (i) Align pointsets to the mean
        aligned_pointsets = toPreshape(aligned_pointsets); % sanity check
        for i = 1:M
            aligned_pointsets(:, :, i) = align1(mu_prev, aligned_pointsets(:, :, i));
        end
        
        % (ii) Update the mean
        mu = updateMean(aligned_pointsets, true);
        
        i_iter = i_iter + 1;
        
        % Check convergence
        rel_change = (mu - mu_prev).^2;
        rel_change = sum(rel_change(:)) / N;
        if rel_change <= eps
            break;
        end
        
        mu_prev = mu;
        
    end
    
    fprintf("Ran for %d steps\n", i_iter);

end

