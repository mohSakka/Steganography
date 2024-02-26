%% initialization
clear;
clc;
%close all;
%% select dataset
% 1-brain 2-chest 3-rentina
dsNumber = 3;
datasets = {'brain images','Our Data','healthy'};
%% select image number from 1->2 
imNum = 1; 
%% select seed from 1-->5
seed = 5;
%% loading results
resultsNames = {'results message length x3','results message length x3 Chest',...
    'results-codeOcean-eye'};
imName1 = num2str(imNum);
imName = num2str(imNum);
if dsNumber==1
    imCoverData = load([cd '/../data/brain images/' imName1]);
    imCover = imCoverData.cjdata.image;
elseif dsNumber==2
    imCover = imread([cd '/../data/Our Data/' imName1 '.jpeg']);
else
    imCover = imread([cd '/../data/healthy/' imName1 '.jpg']);
end
imCover = preprocess(imCover);
sd = num2str(seed);
bench = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark\' imName '_seed ' sd]);
bench2 = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark_Decomposed2\' imName '_seed ' sd]);
bench3 = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark_Decomposed3\' imName '_seed ' sd]);
bench4 = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark_Decomposed4\' imName '_seed ' sd]);
bench5 = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark_Decomposed5\' imName '_seed ' sd]);
bench6 = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark_Decomposed6\' imName '_seed ' sd]);
bench7 = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark_Decomposed7\' imName '_seed ' sd]);
bench8 = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark_Decomposed8\' imName '_seed ' sd]);
bench9 = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark_Decomposed9\' imName '_seed ' sd]);
bench10 = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark_Decomposed10\' imName '_seed ' sd]);

%% plot the histograms
figure;
kernel = [-1 -1 -1;-1 8 -1;-1 -1 -1];
%% imCover
lineWidth = 1.5;
conv = conv2(double(kernel),double(imCover));
[N,edges] = histcounts(conv, 'Normalization','pdf');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N,'linewidth',lineWidth);

hold on
%% benchMark
stegno = bench.stego;
conv = conv2(double(kernel),double(stegno));
[N,edges] = histcounts(conv, 'Normalization','pdf');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N,'r--','linewidth',lineWidth);
%% decomposed2
stegno = bench2.stego;
conv = conv2(double(kernel),double(stegno));
[N,edges] = histcounts(conv, 'Normalization','pdf');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N,'g--','linewidth',lineWidth);
%% decomposed3
stegno = bench3.stego;
conv = conv2(double(kernel),double(stegno));
[N,edges] = histcounts(conv, 'Normalization','pdf');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N,'c--','linewidth',lineWidth);
%% decomposed4
stegno = bench4.stego;
conv = conv2(double(kernel),double(stegno));
[N,edges] = histcounts(conv, 'Normalization','pdf');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N,'y--','linewidth',lineWidth);
%% decomposed5
stegno = bench5.stego;
conv = conv2(double(kernel),double(stegno));
[N,edges] = histcounts(conv, 'Normalization','pdf');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N,'m--','linewidth',lineWidth);
%% decomposed6
stegno = bench6.stego;
conv = conv2(double(kernel),double(stegno));
[N,edges] = histcounts(conv, 'Normalization','pdf');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N,'--','linewidth',lineWidth,'color',[1 0.7843 0]);
%% decomposed7
stegno = bench7.stego;
conv = conv2(double(kernel),double(stegno));
[N,edges] = histcounts(conv, 'Normalization','pdf');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N,'--','linewidth',lineWidth,'color',[0.52 0 1]);
%% decomposed68
stegno = bench8.stego;
conv = conv2(double(kernel),double(stegno));
[N,edges] = histcounts(conv, 'Normalization','pdf');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N,'--','linewidth',lineWidth,'color',[0.43 0.13 0.06]);
%% decomposed9
stegno = bench9.stego;
conv = conv2(double(kernel),double(stegno));
[N,edges] = histcounts(conv, 'Normalization','pdf');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N,'--','linewidth',lineWidth,'color',[0.58 0.56 0.21]);
%% decomposed10
stegno = bench10.stego;
conv = conv2(double(kernel),double(stegno));
[N,edges] = histcounts(conv, 'Normalization','pdf');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N,'--','linewidth',lineWidth,'color',[0.21 0.58 0.45]);
%% put legends
legends = {'imCover','BenchMark','Decomposed2','Decomposed3','Decomposed4',...
    'Decomposed5','Decomposed6','Decomposed7','Decomposed8','Decomposed9','Decomposed10'};
legend(legends);
%% put labels
title('Histogram of Difference');
xlabel('difference');
ylabel('accurance rate');
xlim([-10 10]);
set(gca,'Fontsize',14)