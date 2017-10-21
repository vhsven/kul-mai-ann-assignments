nums_neurons = [1,2,3,4,5,10,15,20,25]; %50
nums_samples = [100, 1000, 10000];
nums_epochs = [10, 100, 1000];
percs_train_val = 0.1:0.1:0.8; %300
perc_training = 0.7;
perc_test = 0.2; %200
repeat = 10;

results = [];
for perc_train_val=percs_train_val
    for num_neurons=nums_neurons
        for num_samples=nums_samples
            for num_epochs=nums_epochs
                for i=1:repeat
                    tic;
                    num_train_val = floor(perc_train_val*num_samples);
                    num_test = floor(perc_test*num_samples);
                    [R, mserror] = hammerstein(num_train_val, num_test, num_neurons, num_samples, num_epochs, perc_training);
                    time = toc;
                    results(end+1, :) = [num_train_val, num_neurons, num_epochs, num_samples, R, mserror, time];
                end
            end
        end
    end
end

disp(results);

tbl = array2table(results, 'VariableNames', {'TrainValPercent', 'Neurons', 'Epochs', 'Samples', 'R', 'MSE', 'Time'});
writetable(tbl, 'ex2b.xlsx')
%stats = grpstats(tbl, {'NumSamples', 'NoiseStd', 'HiddenCount', 'trainFc'}, {'min', 'median', 'max', 'std'});
%disp(stats)

%grpstats(tbl, {'TrainValPercent', 'Neurons', 'Epochs', 'Samples'}, {'min', 'median', 'max', 'std'})
grpstats(tbl, {'Samples', 'TrainValPercent'}, {'median'}, 'DataVars', {'R', 'MSE', 'Time'})
grpstats(tbl, {'Samples', 'Neurons'}, {'median'}, 'DataVars', {'R', 'MSE', 'Time'})
grpstats(tbl, {'Epochs'}, {'median'}, 'DataVars', {'R', 'MSE', 'Time'})
grpstats(tbl, {'Samples'}, {'median'}, 'DataVars', {'R', 'MSE', 'Time'})