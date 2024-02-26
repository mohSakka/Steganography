%% initialization
clear;
clc;
%close all;
%% select the mod
mod = 1; % possible value 1,2 , if 1 then the visualization will be only for the
% Chest data set and for only 2 images, so the dsNumber also must be 2 , and
% the algorithm GA-TS results will considered.
% if mod=2 then the visualization will not contain GA-TS algorithm, but the
% 2 datasets will be available and the comparison will done for 5 images
%% select dataset
% 1-brain 2-chest
dsNumber = 1;
datasets = {'brain images','Our Data'};
%% select image number from 1->5 in brain case, 1->4 and 6 in chest case
imNum = 2;
%% select seed from 1-->5
seed = 1;
%% loading results
resultsNames = {'results-codeOcean-Brain','results-codeOcean-Chest'};
imName1 = num2str(imNum);
imName = num2str(imNum);
if dsNumber==1
    imCoverData = load([cd '/../data/brain images/' imName1]);
    imCover = imCoverData.cjdata.image;
else
    imCover = imread([cd '/../data/Our Data/' imName1 '.jpeg']);
end
imCover = preprocess(imCover);
sd = num2str(seed);
prop = load([cd '\..\' [resultsNames{dsNumber}] '\proposed\' imName '_seed ' sd]);
bench = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark\' imName '_seed ' sd]);
ts = load([cd '\..\' [resultsNames{dsNumber}] '\TS\' imName '_seed ' sd]);
if mod==1
    gats =load([cd '\..\' [resultsNames{dsNumber}] '\GATS\' imName '_seed ' sd]);
end
bench2 = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark_Decomposed2\' imName '_seed ' sd]);
bench3 = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark_Decomposed3\' imName '_seed ' sd]);
%% plot the histograms
figure;
kernel = [-1 -1 -1;-1 8 -1;-1 -1 -1];
%% imCover
lineWidth = 1;
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
plot(edges, N,'y--','linewidth',lineWidth);
%% metameric ga
stegno = prop.bestChrom.stegno;
conv = conv2(double(kernel),double(stegno));
[N,edges] = histcounts(conv, 'Normalization','pdf');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N,'k--','linewidth',lineWidth);
%% metameric ts
stegno = ts.bestChrom.stegno;
conv = conv2(double(kernel),double(stegno));
[N,edges] = histcounts(conv, 'Normalization','pdf');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N,'m--','linewidth',lineWidth);
%% metameric gats
if mod==1
stegno = ts.bestChrom.stegno;
conv = conv2(double(kernel),double(stegno));
[N,edges] = histcounts(conv, 'Normalization','pdf');
edges = edges(2:end) - (edges(2)-edges(1))/2;
plot(edges, N,'c--','linewidth',lineWidth);
end
%% put legends
if mod==1
    legends = {'imCover','BenchMark','Decomposed2','Decomposed3','metamericGa',...
        'metamericTs','metamericGaTs'};
else
    legends = {'imCover','BenchMark','Decomposed2','Decomposed3','metamericGa',...
        'metamericTs'};
end
legend(legends);
%% put labels
title('Histogram of Difference');
xlabel('difference');
ylabel('accurance rate');