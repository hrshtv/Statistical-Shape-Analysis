%{
    Description: Plots the set of pointsets as a scatter plot, each
    pointset in a different color
    
    Inputs:
        pointsets [DxNxM] : The set of pointsets
        title_str [string] : The plot title
        mode [string] : "with_mean" or "without_mean" specifies whether to
        plot the mean shape on top of the pointsets or not
        mu [DxN] : The mean shape
%}

function plotPointsets(pointsets, title_str, mode, mu)
        
    M = size(pointsets, 3);
    for i = 1:M
        % This automatically ensures a unique colour for each pointset
        plot(pointsets(1, :, i), pointsets(2, :, i), ".", "MarkerSize", 2); % 'plot' is faster than 'scatter'
        if i == 1
            hold on; 
        end
    end
    
    title(title_str);
    xlabel("x");
    ylabel("y");

    rng(10);
    if mode == "with_mean"
        color = rand(1, 3);  
        fig_mu = patch(mu(1, :), mu(2, :), [0 0 0], 'FaceColor', 'None', 'EdgeColor', color, 'LineWidth', 2.5);
        legend(fig_mu, "\mu", "Location", "best");
    end

    hold off;
    
end

