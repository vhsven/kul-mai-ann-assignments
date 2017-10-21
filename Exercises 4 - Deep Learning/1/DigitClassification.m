%% Setup
%rng('default')
load digittrain_dataset;
load digittest_dataset;

imageWidth = 28;
imageHeight = 28;
inputSize = imageWidth*imageHeight;
   
xTrain = zeros(inputSize,numel(xTrainImages));
for i = 1:numel(xTrainImages)
    xTrain(:,i) = xTrainImages{i}(:);
end

xTest = zeros(inputSize,numel(xTestImages));
for i = 1:numel(xTestImages)
    xTest(:,i) = xTestImages{i}(:);
end

%% Tests 3 layers
data3 = {};
max_epochs = [100 4 40 60 ; 
               25 1 10 15 ;
              100 4 40 60];
hiddensizes = [40 100 200 ;
               20  50 100];
repeat = 2;

for hiddensize=hiddensizes
    for max_epoch=max_epochs
        disp(max_epoch);
        for i=1:repeat
            tic;
            autoenc1 = trainAutoencoder(xTrainImages,hiddensize(1), ...
                'MaxEpochs',max_epoch(1), ...
                'L2WeightRegularization',0.004, ...
                'SparsityRegularization',4, ...
                'SparsityProportion',0.15, ...
                'ShowProgressWindow', false, ...
                'ScaleData', false);
            feat1 = encode(autoenc1,xTrainImages);
            autoenc2 = trainAutoencoder(feat1,hiddensize(2), ...
                'MaxEpochs',max_epoch(2), ...
                'L2WeightRegularization',0.002, ...
                'SparsityRegularization',4, ...
                'SparsityProportion',0.1, ...
                'ShowProgressWindow', false, ...
                'ScaleData', false);
            feat2 = encode(autoenc2,feat1);
            softnet = trainSoftmaxLayer(feat2,tTrain,...
                'MaxEpochs',max_epochs(3), ...
                'ShowProgressWindow', false);
            deepnet = stack(autoenc1,autoenc2,softnet);
            deepnet.trainParam.showWindow = false;
            deepnet = train(deepnet,xTrain,tTrain);
            time = toc;

            %figure;
            %plotWeights(autoenc1);

            y = deepnet(xTest);
            %figure;
            %plotconfusion(tTest,y);
            classAcc=100*(1-confusion(tTest,y))
            %view(deepnet)

            data3{end+1, 1} = hiddensize(1);
            data3{end, 2} = hiddensize(2);
            data3{end, 3} = max_epoch(1);
            data3{end, 4} = max_epoch(2);
            data3{end, 5} = max_epoch(3);
            data3{end, 6} = time;
            data3{end, 7} = classAcc;
        end
    end
end
disp('Done');

%% Tests 4 layers
data4 = {};
max_epochs = [100 4 40 60 ;
               50 2 20 30 ;
               25 1 10 15 ;
              100 4 40 60];
hiddensizes = [40 100 200 ;
               30  75 150 ;
               20  50 100];
repeat = 2;

for hiddensize=hiddensizes
    for max_epoch=max_epochs
        for i=1:repeat
            tic;
            autoenc1 = trainAutoencoder(xTrainImages,hiddensize(1), ...
                'MaxEpochs',max_epoch(1), ...
                'L2WeightRegularization',0.004, ...
                'SparsityRegularization',4, ...
                'SparsityProportion',0.15, ...
                'ShowProgressWindow', false, ...
                'ScaleData', false);
            feat1 = encode(autoenc1,xTrainImages);
            autoenc2 = trainAutoencoder(feat1,hiddensize(2), ...
                'MaxEpochs',max_epoch(2), ...
                'L2WeightRegularization',0.002, ...
                'SparsityRegularization',4, ...
                'SparsityProportion',0.1, ...
                'ShowProgressWindow', false, ...
                'ScaleData', false);
            feat2 = encode(autoenc2,feat1);
            autoenc3 = trainAutoencoder(feat2,hiddensize(3), ...
                'MaxEpochs',max_epoch(3), ...
                'L2WeightRegularization',0.002, ...
                'SparsityRegularization',4, ...
                'SparsityProportion',0.1, ...
                'ShowProgressWindow', false, ...
                'ScaleData', false);
            feat3 = encode(autoenc3,feat2);
            softnet = trainSoftmaxLayer(feat3,tTrain,...
                'MaxEpochs',max_epochs(4), ...
                'ShowProgressWindow', false);
            deepnet = stack(autoenc1,autoenc2,autoenc3,softnet);
            deepnet.trainParam.showWindow = false;
            deepnet = train(deepnet,xTrain,tTrain);
            time = toc;

            %figure;
            %plotWeights(autoenc1);

            y = deepnet(xTest);
            %figure;
            %plotconfusion(tTest,y);
            classAcc=100*(1-confusion(tTest,y));
            %view(deepnet)

            data4{end+1, 1} = hiddensize(1);
            data4{end, 2} = hiddensize(2);
            data4{end, 3} = hiddensize(3);
            data4{end, 4} = max_epoch(1);
            data4{end, 5} = max_epoch(2);
            data4{end, 6} = max_epoch(3);
            data4{end, 7} = max_epoch(4);
            data4{end, 8} = time;
            data4{end, 9} = classAcc;
        end
    end
end
disp('Done');

%% Compare with normal neural network (1 hidden layers)
repeat = 10;
pattern2data = {};
for i=1:repeat
    net = patternnet(100);
    tic;
    net=train(net,xTrain,tTrain);
    time = toc;
    y=net(xTest);
    %plotconfusion(tTest,y);
    classAcc=100*(1-confusion(tTest,y));
    pattern2data{end+1, 1} = time;
    pattern2data{end, 2} = classAcc;
end

%% Compare with normal neural network (2 hidden layers)
pattern3data = {};
for i=1:repeat
    net = patternnet([100 50]);
    tic;
    net=train(net,xTrain,tTrain);
    time = toc;
    y=net(xTest);
    %plotconfusion(tTest,y);
    classAcc=100*(1-confusion(tTest,y));
    pattern3data{end+1, 1} = time;
    pattern3data{end, 2} = classAcc;
end