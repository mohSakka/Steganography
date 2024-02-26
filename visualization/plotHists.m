%% initialization
clear;
clc;
close all;
%% select dataset
% 1-brain 2-chest 3-rentina
dsNumber = 2;
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
%% imCover
sb = subplot(2,4,1);
imshow( (imCover));
title('image cover');
subplot(2,4,2);
imhist( (imCover));
title('histogram of image cover');
%% benchMark
stegno = bench.stego;
subplot(2,4,3);
imshow( (stegno));
title('stegno-benchmark');
subplot(2,4,4);
imhist( (stegno));
title('histogram of stegno-benchmark');
%% decomposed2
stegno = bench2.stego;
subplot(2,4,5);
imshow( (stegno));
title('stegno-d2');
subplot(2,4,6);
imhist( (stegno));
title('histogram of stegno-d2');
%% decomposed3
stegno = bench3.stego;
subplot(2,4,7);
imshow( (stegno));
title('stegno-d3');
subplot(2,4,8);
imhist( (stegno));
title('histogram of stegno-d3');
%% decomposed4
figure;
%% imCover
sb = subplot(2,4,1);
imshow( (imCover));
title('image cover');
subplot(2,4,2);
imhist( (imCover));
title('histogram of image cover');
%% decomposed4
stegno = bench4.stego;
subplot(2,4,3);
imshow( (stegno));
title('stegno-d4');
subplot(2,4,4);
imhist( (stegno));
title('histogram of stegno-d4');
%% decomposed5
stegno = bench5.stego;
subplot(2,4,5);
imshow( (stegno));
title('stegno-d5');
subplot(2,4,6);
imhist( (stegno));
title('histogram of stegno-d5');
%% decomposed6
stegno = bench6.stego;
subplot(2,4,7);
imshow( (stegno));
title('stegno-d6');
subplot(2,4,8);
imhist( (stegno));
title('histogram of stegno-d6');
%% decomposed7
figure;
%% imCover
sb = subplot(3,4,1);
imshow( (imCover));
title('image cover');
subplot(3,4,2);
imhist( (imCover));
title('histogram of image cover');
%% decomposed7
stegno = bench7.stego;
subplot(3,4,3);
imshow( (stegno));
title('stegno-d7');
subplot(3,4,4);
imhist( (stegno));
title('histogram of stegno-d7');
%% decomposed8
stegno = bench8.stego;
subplot(3,4,5);
imshow( (stegno));
title('stegno-d8');
subplot(3,4,6);
imhist( (stegno));
title('histogram of stegno-d8');
%% decomposed9
stegno = bench9.stego;
subplot(3,4,7);
imshow( (stegno));
title('stegno-d9');
subplot(3,4,8);
imhist( (stegno));
title('histogram of stegno-d9');
%% decomposed10
stegno = bench10.stego;
subplot(3,4,9);
imshow( (stegno));
title('stegno-d10');
subplot(3,4,10);
imhist( (stegno));
title('histogram of stegno-d10');
%% put labels
%suptitle('Histogram of Difference');