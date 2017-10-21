step = 0.03;
stdev = 0.1;
x=0:step:2;
y=sin(2*pi*x);
%plot(x, y);
hold on;
ynoisy = y + stdev*randn(size(x));
plot(x, ynoisy, '*');

net = feedforwardnet(7, 'trainbr');
net = train(net, x, ynoisy);
x2 = 0:step:2;
yresult = sim(net, x2);
plot(x2, yresult, '--');
hold off;

errors = yresult - ynoisy;
%perf = perform(net, yresult, ynoisy)

%compare with ex2 (other training functions)
%compare test errors
%test overparametrized: many neurons
%speed
%overfitting
%generalization