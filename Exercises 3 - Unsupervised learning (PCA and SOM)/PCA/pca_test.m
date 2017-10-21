function [quality, rmse, X_hat] = pca_test(X, q)
    avg = mean(mean(X));
    X_norm = X - avg;
    [E, d_cumquality] = mypca(X_norm, q);
    F = E;
    quality = d_cumquality(q);
    Z_norm = E'*X_norm;
    X_hat = F*Z_norm + avg;
    rmse = sqrt(mean(mean((X-X_hat).^2)));
end

