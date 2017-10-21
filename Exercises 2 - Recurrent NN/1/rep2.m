T = [1 1; -1 -1; 1 -1]';
net = newhop(T);
steps = 50;
n=10;

a=rands(2,n);
a(:,1) = [0 0];
a(:,2) = [1 0];
a(:,3) = [0 1];
a(:,4) = [0 -0.5];
[y,Pf,Af] = sim(net,{n steps},{},{a});
record = [{a} y];
m = cell2mat(record);
xs = reshape(m(1,:), 10, [])';
ys = reshape(m(2,:), 10, [])';

plot(a(1,:),a(2,:),'bx');
hold on;
plot(xs, ys)
plot(xs(end,:), ys(end,:),'gO');
title('Time evolution in the phase space of 2D Hopfield model');