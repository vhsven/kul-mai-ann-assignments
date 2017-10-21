[X,T] = iris_dataset;
true_labels = vec2ind(T);

% tic;
% net = newsom(X, [1 3], 'hextop', 'linkdist');
% net.trainParam.epochs = 200;
% net = train(net,X);
% time = toc;
% outputs = sim(net,X);
% [~,assignment] = max(outputs);
% ARI = RandIndex(assignment,true_labels)

topoFuncs = {'hextop', 'gridtop', 'randtop'};
distFuncs = {'linkdist', 'dist', 'mandist', 'boxdist'};
epochs = [50 100 200 500];
repeat = 10;

counter = 1;
results = {};
for topoFc=topoFuncs
    for distFc=distFuncs
        for epoch=epochs
            for i=1:repeat
                tic;
                net = newsom(X, [2 3], char(topoFc), char(distFc));
                net.trainParam.epochs = epoch;
                net.trainParam.showWindow = 0;
                net = train(net,X);
                time = toc;
                outputs = sim(net,X);
                [~,assignment] = max(outputs);
                ARI = RandIndex(assignment,true_labels);
                
                results{counter, 1} = topoFc;
                results{counter, 2} = distFc;
                results{counter, 3} = epoch;
                results{counter, 4} = time;
                results{counter, 5} = ARI;
                counter = counter + 1;
            end
        end
    end
end

%%
tbl = cell2table(results, 'VariableNames', {'TopologyFc', 'DistanceFc', 'Epochs', 'Time', 'ARI'});
grpstats(tbl, {'Epochs'}, {'median' }, 'DataVars', {'Time', 'ARI'})
