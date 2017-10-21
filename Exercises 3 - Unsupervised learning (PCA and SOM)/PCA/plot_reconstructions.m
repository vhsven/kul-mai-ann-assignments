load threes -ascii;

i = 10;
qs = [1 5 10 20 50, 256];
N = size(qs, 2);
for j=1:N
    [quality, rmse, threes_hat] = pca_test(threes, qs(j));
    subplot(1,N,j);
    %mean3_hat = mean(threes_hat, 1);
    %imshow(reshape(mean3_hat,16,16));
    imshow(reshape(threes_hat(i,:),16,16));
    %title(sprintf('q=%d\nqualityloss=%0.2f\nrmse=%0.2f', qs(j), 1-quality, rmse));
    title(sprintf('q=%d', qs(j)));
end