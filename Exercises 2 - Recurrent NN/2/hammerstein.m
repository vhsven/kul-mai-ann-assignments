function [R, mserror] = hammerstein(num_train_val, num_test, num_neurons, num_samples, num_epochs, perc_training)

    u = zeros(1, num_samples);
    x = zeros(1, num_samples);
    y = zeros(1, num_samples);

    u(1)=randn; 
    x(1)=rand+sin(u(1));
    y(1)=.6*x(1);

    for i=2:num_samples
        u(i)=randn;
        x(i)=.6*x(i-1)+sin(u(i));
        y(i)=x(i);
    end

    X_train=num2cell(u(1:num_train_val)); 
    T_train=num2cell(y(1:num_train_val));

    X_test=num2cell(u(end-num_test:end));
    T_test=num2cell(y(end-num_test:end)); 

    net = newelm(X_train,T_train,num_neurons);
    net.trainParam.epochs = num_epochs;
    net.trainParam.showWindow = false;
    net.divideParam.testRatio = 0;
    net.divideParam.valRatio = 1-perc_training;
    net.divideParam.trainRatio = perc_training;

    net = train(net,X_train,T_train);
    T_test_sim = sim(net,X_test);
    
    plot(cell2mat(X_test),'r');
    hold on;
    plot(cell2mat(T_test_sim),'b');

    R = corrcoef(cell2mat(T_test),cell2mat(T_test_sim));
    R = R(1,2);
    mserror = mse(cell2mat(T_test)-cell2mat(T_test_sim));
end

