repeat = 1000;
nums = zeros(repeat, 10);
for i=1:repeat
   nums(i,:) = hopdigit_v2(4, 500);
end

cat_nums = categorical(nums);
histogram(cat_nums(:,8+1));
ylim([0 30]);
xlabel('Detected digit')
ylabel('Count')
sizex = 20;
sizey = 12;
set(gcf, 'PaperPosition', [0 0 sizex sizey]);
set(gcf, 'PaperSize', [sizex sizey]);
saveas(gcf, 'Detect8', 'pdf');