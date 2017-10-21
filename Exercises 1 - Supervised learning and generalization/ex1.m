P = [2 1 -2 -1; 2 -2 2 1];
T = [0 1 0 1];
TF = 'hardlim';
LF = 'learnp'; %learnpn

net = newp(P,T,TF,LF);
net = init(net);
net.trainParam.epochs = 20;
[net,tr_descr] = train(net,P,T);

net.IW{1,1}
net.b{1,1}

Pnew = [1;-0.3];
sim(net,Pnew)

%classification with 2d input perceptron
%https://nl.mathworks.com/help/nnet/examples/classification-with-a-2-input-perceptron.html?s_tid=gn_loc_drop

%classification with outlier (2d input)
%https://nl.mathworks.com/help/nnet/examples/outlier-input-vectors.html

%classification with outlier using normalized perceptron learning rule (2d input)
%https://nl.mathworks.com/help/nnet/examples/normalized-perceptron-rule.html

%linearly non-separable input vectors (2d input)
%https://nl.mathworks.com/help/nnet/examples/linearly-non-separable-vectors.html

%CNN: https://www.youtube.com/watch?v=FmpDIaiMIeA&list=LLoyD7vXkP56-wnw6rR18S6w&index=1