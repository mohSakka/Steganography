function [N,edges] = getHistOffDif(stegno)
kernel = [-1 -1 -1;-1 8 -1;-1 -1 -1];
conv = conv2(double(kernel),double(stegno));
[N,edges] = histcounts(conv, 'Normalization','pdf');
end
