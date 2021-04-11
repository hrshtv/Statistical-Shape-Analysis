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

function plotWithMode(aligned_pointsets, mu, V, L, mode, segments, PATH_RES)

    [D, N] = size(mu);
    
    v = reshape(V(:, end - mode + 1), D, N);
    l = L(end - mode + 1);
    
    plus  = mu + 2.5*sqrt(l)*v;
    minus = mu - 2.5*sqrt(l)*v;
    
    % Plus
    figure;
    % Plot the pointsets as a scatter plot
    M = size(aligned_pointsets, 3);
    for i = 1:M
        % This automatically ensures a unique colour for each pointset
        plot(aligned_pointsets(1, :, i), aligned_pointsets(2, :, i), ".", "MarkerSize", 2); % 'plot' is faster than 'scatter'
        if i == 1
            hold on; 
        end
    end
    hold on;
    for sno = unique(segments)
        mask = segments == sno;
        plus_1 = plus(1, mask);
        plus_2 = plus(2, mask);
        fig_plus = plot(plus_1, plus_2, 'Color', [0 0 1], 'LineWidth', 2.5);
    end
    title("\mu + 2.5\sigma");
    xlabel("x");
    ylabel("y");
    save_path = sprintf("%smode_%d_plus.jpg", PATH_RES, mode);
    axis off; % comment to show the axis as well
    axis equal;
    saveas(gcf, save_path, "jpg")
    hold off;
    
    % Minus
    figure;
    % Plot the pointsets as a scatter plot
    M = size(aligned_pointsets, 3);
    for i = 1:M
        % This automatically ensures a unique colour for each pointset
        plot(aligned_pointsets(1, :, i), aligned_pointsets(2, :, i), ".", "MarkerSize", 2); % 'plot' is faster than 'scatter'
        if i == 1
            hold on; 
        end
    end
    hold on;
    for sno = unique(segments)
        mask = segments == sno;
        minus_1 = minus(1, mask);
        minus_2 = minus(2, mask);
        fig_minus = plot(minus_1, minus_2, 'Color', [0 1 0], 'LineWidth', 2.5);
    end
    title("\mu - 2.5\sigma");
    xlabel("x");
    ylabel("y");
    hold off;
    save_path = sprintf("%smode_%d_minus.jpg", PATH_RES, mode);
    axis off; % comment to show the axis as well
    axis equal;
    saveas(gcf, save_path, "jpg")
    
end

