%{
    Description: Plots the set of pointsets as a scatter plot, each
    pointset in a different color
    
    Inputs:
        aligned_pointsets [DxNxM] : The set of aligned pointsets
        V [DN x DN] : The eigenvectors of the covariance matrix
        L [DN] : The eigenvalues of the covariance matrix
        mode [1x1] : The mode of variation to use (eg: 1, 2, 3, etc)
        mu [DxN] : The mean shape
%}

function plotWithMode(aligned_pointsets, mu, V, L, mode)

    [D, N] = size(mu);
    
    v = reshape(V(:, end - mode + 1), D, N);
    l = L(end - mode + 1);
    
    plus  = mu + 2*sqrt(l)*v;
    minus = mu - 2*sqrt(l)*v;
    
    % Plot the pointsets as a scatter plot
    M = size(aligned_pointsets, 3);
    for i = 1:M
        % This automatically ensures a unique colour for each pointset
        plot(aligned_pointsets(1, :, i), aligned_pointsets(2, :, i), ".", "MarkerSize", 2); % 'plot' is faster than 'scatter'
        if i == 1
            hold on; 
        end
    end
    
    % Plot the three shapes as polygons
    rng(10);
    % Mu
    color = rand(1, 3);  
    fig_mu = patch(mu(1, :), mu(2, :), [0 0 0], 'FaceColor', 'None', 'EdgeColor', color, 'LineWidth', 2.5);
    % Plus
    color = rand(1, 3);  
    fig_plus = patch(plus(1, :), plus(2, :), [0 0 0], 'FaceColor', 'None', 'EdgeColor', color, 'LineWidth', 2.5);
    % Minus
    color = rand(1, 3);  
    fig_minus = patch(minus(1, :), minus(2, :), [0 0 0], 'FaceColor', 'None', 'EdgeColor', color, 'LineWidth', 2.5);

    handle = [fig_mu; fig_plus; fig_minus];
    legend(handle, "\mu", "\mu + 2\sigma", "\mu - 2\sigma", "Location", "best");
    
    title(sprintf("Mode of Variation: %d", mode));
    xlabel("x");
    ylabel("y");
    
    hold off;
    
end

