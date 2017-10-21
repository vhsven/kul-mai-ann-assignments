repeat = 10;
sigmas = 0:4:20;
iterations = 10.^(0:3); %100:100:1000;

expected = repmat(0:9, repeat, 1);
failures = -1 * ones(repeat, 10);
total_correct = ones(size(sigmas, 2), size(iterations, 2));
total_failed = ones(size(sigmas, 2), size(iterations, 2));

for i=1:size(sigmas, 2)
    sigma = sigmas(i);
    for j=1:size(iterations, 2)
        num_iterations = iterations(j);
        nums = zeros(repeat, 10);
        for k=1:repeat
           nums(k,:) = hopdigit_v2(sigma, num_iterations);
        end

        match_correct = nums == expected;
        count_correct = sum(match_correct);
        total_correct(i,j) = sum(count_correct);

        match_failed = nums == failures;
        count_failed = sum(match_failed);
        total_failed(i,j) = sum(count_failed);
    end
end

subplot(2, 1, 1);
surf(sigmas, iterations, total_correct');
colorbar;
xlabel('\sigma');
ylabel('Iterations');
zlabel('Success count');
set(gca,'YScale','log');
subplot(2, 1, 2);
surf(sigmas, iterations, total_failed');
colorbar;
xlabel('\sigma');
ylabel('Iterations');
zlabel('Failure count');
set(gca,'YScale','log');

sizex = 20;
sizey = 20;
set(gcf, 'PaperPosition', [0 0 sizex sizey]);
set(gcf, 'PaperSize', [sizex sizey]);
saveas(gcf, 'EffectSigmaIterations', 'pdf');