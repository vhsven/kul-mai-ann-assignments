%% Load data
load('Data_Problem1_regression.mat');
X = [X1 X2]';
T = (9*T1' + 4*T2' + 4*T3' + T4') / 18; %s0190440

%% Plot base functions
subplot(231)
plot3(X1, X2, T1, '.')
xlabel('X_1');
ylabel('X_2');
title('f_1');
subplot(232)
plot3(X1, X2, T2, '.')
xlabel('X_1');
ylabel('X_2');
title('f_2');
subplot(233)
plot3(X1, X2, T3, '.')
xlabel('X_1');
ylabel('X_2');
title('f_3');
subplot(234)
plot3(X1, X2, T4, '.')
xlabel('X_1');
ylabel('X_2');
title('f_4');
subplot(235)
plot3(X1, X2, T5, '.')
xlabel('X_1');
ylabel('X_2');
title('f_5');
subplot(236)
plot3(X1, X2, T, '.')
xlabel('X_1');
ylabel('X_2');
title('f');

sizex = 30;
sizey = 20;
set(gcf, 'PaperPosition', [0 0 sizex sizey]);
set(gcf, 'PaperSize', [sizex sizey]);
saveas(gcf, 'BaseFunctions', 'pdf');

%% Plot result only
plot3(X1, X2, T, '.')
xlabel('X_1');
ylabel('X_2');
title('f');

sizex = 30;
sizey = 20;
set(gcf, 'PaperPosition', [0 0 sizex sizey]);
set(gcf, 'PaperSize', [sizex sizey]);
saveas(gcf, 'Regression_AllSamples', 'pdf');