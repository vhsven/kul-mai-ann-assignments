sizex = 20;
sizey = 30;

% n = size(steps, 2);
% s = grpstats(tbl, {'trainFc', 'NumSamples'}, {'median'}, 'DataVars', {'R', 'Epochs', 'Time'});
% categories = categorical(s{1:n:end, 1});
% bar(categories, reshape(s{:,6}, n, [])')
% title('Time vs NumSamples per trainFc');
% xlabel('trainFc');
% ylabel('Time (s)');
% h = legend(int2str(s{1:n, 2}));
% set(get(h,'title'),'string','NumSamples');

ex2_plots(tbl, 'NoiseStd', size(stdevs, 2), sizex, sizey);
ex2_plots(tbl, 'NumSamples', size(steps, 2), sizex, sizey);
ex2_plots(tbl, 'HiddenCount', size(hiddens, 2), sizex, sizey);