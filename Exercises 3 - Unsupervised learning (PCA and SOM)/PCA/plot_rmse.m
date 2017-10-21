load threes -ascii;

N = size(threes, 2);
qualities = zeros(1, N);
rmserrors = zeros(1, N);
for k=1:N
    [quality, rmse, threes_hat] = pca_test(threes, k);
    qualities(k) = quality;
    rmserrors(k) = rmse;
end

plot(1-qualities);
hold on;
plot(rmserrors);
xlabel('q');
legend('Quality loss', 'RMSE');
xlim([0 N-1]);
ylim([0 1]);

sizex = 20;
sizey = 8;
set(gcf, 'PaperPosition', [0 0 sizex sizey]);
set(gcf, 'PaperSize', [sizex sizey]);
saveas(gcf, 'ThreesError', 'pdf');