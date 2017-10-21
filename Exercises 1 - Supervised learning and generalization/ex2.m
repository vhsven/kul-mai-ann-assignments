%clear;
steps = 10.^(-3:-1);
stdevs = 0:0.1:0.4;
hiddens = [5,10,15,20,100]; %5:5:20;
repeat_count = 10;
trainAlgs = {'traingd', 'traingda', 'traincgf', 'traincgp', 'trainbfg', 'trainlm', 'trainbr'};
data = cell(size(steps, 2) * size(stdevs, 2) * size(hiddens, 2) * repeat_count * size(trainAlgs, 2), 7);
counter = 1;

for step=steps
    x=0:step:4*pi;
    y=sin(x);
    for stdev=stdevs
        ynoisy = y + stdev*randn(size(x));

        %plot(x, y);
        %hold on;
        %plot(x, ynoisy, '*');
        
        for hidden_count=hiddens
            firstnet = feedforwardnet(hidden_count, 'traingd');
            for trainAlg=trainAlgs
                trainFc = char(trainAlg);
                for j=1:repeat_count
                    net = feedforwardnet(hidden_count, trainFc);
                    net.iw{1,1}=firstnet.iw{1,1};  %set the same weights and biases for the networks 
                    net.lw{2,1}=firstnet.lw{2,1};
                    net.b{1}=firstnet.b{1};
                    net.b{2}=firstnet.b{2};
                    net.trainParam.showWindow = false;
                    %net.trainParam.goal = 0.001;
                    tic;
                    [net, tr] = train(net, x, ynoisy);
                    time = toc;
                    yresult = sim(net, x);
                    %plot(x2, yresult, '--');
                    %figure;
                    [m,b,r] = postreg(yresult,ynoisy);

                    data{counter,1} = trainFc;
                    data{counter,2} = r;
                    data{counter,3} = tr.epoch(end);
                    data{counter,4} = time; %sum(tr.time);
                    data{counter,5} = size(x, 2);
                    data{counter,6} = stdev;
                    data{counter,7} = hidden_count;
                    counter = counter + 1;
                    %fprintf('%-10s\t%2.3f\t%4i\t%8.3f\t%2.3f\t%2.3f\t%3i\n', trainFc, r, tr.epoch(end), time, size(x, 2), stdev, hidden_count);
                end
            end
        end
    end
end

tbl = cell2table(data, 'VariableNames', {'trainFc', 'R', 'Epochs', 'Time', 'NumSamples', 'NoiseStd', 'HiddenCount'});
writetable(tbl, 'tbl.xlsx')
stats = grpstats(tbl, {'NumSamples', 'NoiseStd', 'HiddenCount', 'trainFc'}, {'min', 'median', 'max', 'std'});
disp(stats)

% s = grpstats(tbl, {'NoiseStd'}, {'median'}, 'DataVars', {'R', 'Epochs', 'Time'});
% x = s{:,1};
% y_r = s{:,3};
% y_epochs = s{:,4};
% y_time = s{:,5};
% subplot(311);
% plot(x, y_r);
% subplot(312);
% plot(x, y_epochs);
% subplot(313);
% plot(x, y_time);
% 
% s = grpstats(tbl, {'NumSamples'}, {'median'}, 'DataVars', {'R', 'Epochs', 'Time'});
% x = s{:,1};
% y_r = s{:,3};
% y_epochs = s{:,4};
% y_time = s{:,5};
% subplot(311);
% semilogx(x, y_r);
% subplot(312);
% semilogx(x, y_epochs);
% subplot(313);
% semilogx(x, y_time);