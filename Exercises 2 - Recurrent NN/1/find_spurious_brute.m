load digits;
X = 2*X-1;

index_dig = 1:20:181;
num_dig = size(index_dig, 2);
T = X(index_dig, :)';
num_iter = 1000;

net = newhop(T);
targets = {};
spurs = {};

for i=1:1000
    target = randn(size(T(:, 1)));
    [Yn,~,~] = sim(net,{1 num_iter},{},target);
    digit = Yn{1,end}';
    num = detect_num(T, digit');
    if num < 0
        disp('Spurious!');
        targets{end+1} = target;
        spurs{end+1} = digit';
    end
end

%filter out duplicate rows
m = cell2mat(spurs)';
tol = 0.0001;
[~, ii] = sortrows(m);
ii_unique = ii(logical([1; any(diff(m(ii,:))>tol,2)]));
uniques = m(sort(ii_unique),:)';

n = size(uniques, 2);
for col=1:n
    subplot(1, n, col);
	imshow(reshape(uniques(:,col),15,16)');
end

sizex = 30;
sizey = 20;
set(gcf, 'PaperPosition', [0 0 sizex sizey]);
set(gcf, 'PaperSize', [sizex sizey]);
saveas(gcf, 'Spurious', 'pdf');