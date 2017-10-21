X=2*(rand(5000,3)-.5); %[-1, 1[
r2_xy = X(:,1).^2 + X(:,2).^2;
r2_zy = X(:,2).^2 + X(:,3).^2;
r2_xyz = X(:,1).^2 + X(:,2).^2 + X(:,3).^2;
hollow_cylinder=X((r2_xy < 0.6) & (r2_xy > 0.1), :)';
hollow_sphere=X((r2_xyz < 0.6) & (r2_xyz > 0.1), :)';
hollow_box=X((abs(X(:,1)) > 0.8) | (abs(X(:,2)) > 0.8) | (abs(X(:,3)) > 0.8), :)';
toroid=X((0.8 - sqrt(X(:,1).^2 + X(:,2).^2)).^2 + X(:,3).^2 < 0.2^2, :)';
cone=X((r2_xy < 0.15 ./ X(:,3)), :)';

topoFuncs = {'hextop', 'gridtop', 'randtop'};
distFuncs = {'linkdist', 'dist', 'mandist', 'boxdist'};
epochs = [10 100 1000];
repeat = 1;

%sqrt(5 * sqrt(size(hollow_cylinder, 2)))
test_som(hollow_cylinder, [6 6 6], 'hextop', 'linkdist', 100);

% counter = 1;
% results = {};
% for topoFc=topoFuncs
%     for distFc=distFuncs
%         for epoch=epochs
%             for i=1:repeat
%                 tic;
%                 test_som(hollow_cylinder, char(topoFc), char(distFc), epoch);
%                 time = toc;
%                 results{counter} = {topoFc, distFc, epoch, time};
%                 counter = counter + 1;
%             end
%         end
%     end
% end