load choles_all
X = p;
q = 10;
avg = mean(mean(p));
X_norm = X - avg;
[E, d_cumquality] = mypca(X_norm, q);
bar(d_cumquality);
F = E;
quality = d_cumquality(q);
Z_norm = E'*X_norm;
X_hat = F*Z_norm + avg;
rmse = sqrt(mean(mean((X-X_hat).^2)));

[X_std, std_settings] = mapstd(X);
maxfrac = 0.001;
[Z_std, pca_settings] = processpca(X_std, maxfrac);
X_std_hat = processpca('reverse', Z_std, pca_settings);
X_hat = mapstd('reverse', X_std_hat, std_settings);
ootb_rmse = sqrt(mean(mean((X-X_hat).^2)));