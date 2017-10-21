function nums = hopdigit_v2(noiselevel,num_iter)
load digits;
[N, dim]=size(X);
maxx=max(max(X));

X(X==0)=-1;

index_dig = [1,21,41,61,81,101,121,141,161,181];
num_dig = size(index_dig, 2);
T = X(index_dig, :)';
net = newhop(T);

%Check if digits are attractors
[Y,~,~] = sim(net,num_dig,[],T);
Y = Y';

%figure;
% subplot(num_dig,3,1);
% for i = 1:num_dig
%     digit = Y(i,:);
%     digit = reshape(digit,15,16)'; 
% 
%     subplot(num_dig,3,((i-1)*3)+1);
%     imshow(digit)
%     if i == 1
%         title('Attractors')
%     end
%     hold on
% end

% Add noise to the digit maps
noise = noiselevel*maxx; % sd for Gaussian noise

Xn = X; 
for i=1:N
  Xn(i,:) = X(i,:) + noise*randn(1, dim);
end

%Show noisy digits:
% subplot(num_dig,3,2);
% 
% for i = 1:num_dig
%     digit = Xn(index_dig(i),:);
%     digit = reshape(digit,15,16)';
%     subplot(num_dig,3,((i-1)*3)+2);
%     imshow(digit)
%     if i == 1
%         title('Noisy digits')
%     end
%     hold on
% end

%See if the network can correct the corrupted digits 
Xn = Xn';
Tn = {Xn(:,index_dig)};
[Yn,~,~] = sim(net,{num_dig num_iter},{},Tn);
Yn = Yn{1,end}';
nums = zeros(1, num_dig);

%subplot(num_dig,3,3);
for i = 1:num_dig
    digit = Yn(i,:);
    nums(i) = detect_num(T, digit');
    %digit = reshape(digit,15,16)';
    %subplot(num_dig,3,((i-1)*3)+3);
    %imshow(digit)
    %if i == 1
    %    title('Reconstructed noisy digits')
    %end
    %hold on
end