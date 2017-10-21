function group_plots(tbl, param, n, sizex, sizey)
    s = grpstats(tbl, {'trainFc', param}, {'median'}, 'DataVars', {'Time', 'MSE_test', 'MSE_train'});
    categories = categorical(s{1:n:end, 1});

    subplot(311);
    bar(categories, reshape(s.median_Time, n, [])')
    xlabel('trainFc');
    ylabel('Time (s)');
    %ylim([0, 4]);
    h = legend(num2str(s{1:n, 2}), 'Location', 'northwest');
    set(get(h,'title'),'string',param);

    subplot(312);
    bar(categories, reshape(s.median_MSE_test, n, [])')
    xlabel('trainFc');
    ylabel('MSE (test)');
    set(gca,'YScale','log');
    %ylim([1E0 1E3]);
    
    subplot(313);
    bar(categories, reshape(s.median_MSE_train, n, [])')
    xlabel('trainFc');
    ylabel('MSE (train)');
    set(gca,'YScale','log');
    %ylim([1E0 1E3]);

    set(gcf, 'PaperPosition', [0 0 sizex sizey]);
    set(gcf, 'PaperSize', [sizex sizey]);
    saveas(gcf, param, 'pdf');
end