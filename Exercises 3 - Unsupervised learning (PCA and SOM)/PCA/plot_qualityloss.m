load threes -ascii;

C = cov(threes);
[~,d] = eig(C);
eigenvalues = flipud(diag(d));
eig_cumsum = cumsum(eigenvalues) / sum(eigenvalues);
plot(1 - eig_cumsum);
xlabel('q');
ylabel('quality loss');
xlim([0 255]);
ylim([0 1]);
 
sizex = 20;
sizey = 8;
set(gcf, 'PaperPosition', [0 0 sizex sizey]);
set(gcf, 'PaperSize', [sizex sizey]);
saveas(gcf, 'ThreesQualityLoss', 'pdf');