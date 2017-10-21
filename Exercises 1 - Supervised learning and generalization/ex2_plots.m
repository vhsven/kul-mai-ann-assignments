function ex2_plots(tbl, param, n, sizex, sizey)
    s = grpstats(tbl, {'trainFc', param}, {'median'}, 'DataVars', {'R', 'Epochs', 'Time'});
    categories = categorical(s{1:n:end, 1});

    subplot(311);
    bar(categories, reshape(s{:,6}, n, [])')
    xlabel('trainFc');
    ylabel('Time (s)');
    ylim([0, 4]);
    h = legend(num2str(s{1:n, 2}), 'Location', 'northwest');
    set(get(h,'title'),'string',param);

    subplot(312);
    bar(categories, reshape(s{:,5}, n, [])')
    xlabel('trainFc');
    ylabel('Epochs');
    set(gca,'YScale','log');
    ylim([1E0 1E3]);

    subplot(313);
    bar(categories, reshape(s{:,4}, n, [])')
    xlabel('trainFc');
    ylabel('R');
    ylim([0.8, 1.0]);

    set(gcf, 'PaperPosition', [0 0 sizex sizey]);
    set(gcf, 'PaperSize', [sizex sizey]);
    saveas(gcf, param, 'pdf');
end

