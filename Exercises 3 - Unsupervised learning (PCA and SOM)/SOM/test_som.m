function [] = test_som(X, dims, topoFc, distFc, epochs)
    net = newsom(X, dims, topoFc, distFc); 
    
    figure;
    subplot(121);
    plot3(X(1,:),X(2,:),X(3,:),'.g','markersize',10);
    hold on
    plotsom(net.iw{1},net.layers{1}.distances)
    axis([-2 2 -2 2]);
    hold off

    net.trainParam.epochs = epochs;
    %net.trainParam.showWindow = 0;
    net = train(net,X);
    
    subplot(122);
    plot3(X(1,:),X(2,:),X(3,:),'.g','markersize',10);
    hold on
    plotsom(net.iw{1},net.layers{1}.distances)
    axis([-2 2 -2 2]);
    hold off
    
    %classes = vec2ind(net(X));
    
    %outputs = sim(net,X);
    %[~,assignment]  =  max(outputs);
    %ARI=RandIndex(assignment,true_labels);
end

