function [E, d_cumquality] = mypca(X_norm, q)
    C = cov(X_norm');
    [~,d] = eig(C);
    d_sorted = flipud(diag(d));
    d_cumsum = cumsum(d_sorted);
    d_sum = sum(d_sorted);
    d_cumquality = d_cumsum / d_sum;
    %plot(d_cumquality);
    [E,~] = eigs(C, q);
end

