load digits;
X = 2*X-1;

index_dig = 1:20:181;
num_dig = size(index_dig, 2);
T = X(index_dig, :)';
num_iter = 1000;

d1 = T(:, 8+1);
d2 = T(:, 9+1);
avg = (d1 + d2) / 2;
inverse = -d1;
null = zeros(size(d1));
unit = ones(size(d1));
random = randn(size(d1));
target = random;

subplot(221);
imshow(reshape(d1,15,16)');
subplot(222);
imshow(reshape(d2,15,16)');
subplot(223);
imshow(reshape(target,15,16)');

net = newhop(T);
[Yn,~,~] = sim(net,{1 num_iter},{},target);

subplot(224);
digit = Yn{1,end}';
imshow(reshape(digit,15,16)')

detect_num(T, digit')

