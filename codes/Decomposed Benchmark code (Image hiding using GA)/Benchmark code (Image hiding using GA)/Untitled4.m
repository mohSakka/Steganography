%% initialization
clear;
clc;
close all;
%% adding required paths
addpath([cd '/../codes/Copy_of_Benchmark code (Image hiding using GA)/' ...
    'Benchmark code (Image hiding using GA)']);
%% select the mod
mod = 2; % possible value 1,2 , if 1 then the visualization will be only for the
% Chest data set and for only 2 images, so the dsNumber also must be 2 , and
% the algorithm GA-TS results will considered.
% if mod=2 then the visualization will not contain GA-TS algorithm, but the
% 2 datasets will be available and the comparison will done for 5 images
%% select dataset
% 1-chest 2-brain
dsNum = 1;
datasets = {'brain images','Our Data'};
%% select image number from 1->5 in brain case, 1->4 and 6 in chest case
imNum = 1;
%% select seed from 1-->5
seed = 1;
%% loading results
resultsNames = {'results-codeOcean-Brain','results-codeOcean-Chest'};
imName1 = num2str(imNum);
imName = num2str(imNum);
if dsNum==1
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
%% start
%% get the message and decompose it
message = bench.imSecEx;
stepsNum = 100;
step = round(length(message)/stepsNum);
for subMsgStep=1:step:length(message)
    %%%%%%%%
    try
        subMsg = message(subMsgStep:subMsgStep+step-1);
    catch
        subMsg = message(subMsgStep:end);
    end
    %%%%%%%% 
    %% benchMark embidding
    chrom = bench.chrom;
    % Chromosome parts
    direction=chrom(1);
    xOff=chrom(2);
    yOff=chrom(3);
    bitPlanes=mappingBitPlanes(chrom(4));bitPlanes=dec2bin(bitPlanes,4);
    numOfUsedBits=length(find(bitPlanes=='1'));
    sbPole=chrom(5);
    sbDir=chrom(6);
    bpDir=chrom(7);
    
    % Message bit sequence
    reqBitSeq=ChooseRightSecretSeq2(subMsg,sbPole,sbDir);
    messageLength=length(reqBitSeq(:));    % 27 is the length of chromosome
    % Chrom bit sequence
    chromBitSeq=ConvertChromToBitSeq(chrom);
    chromLength=length(chromBitSeq);
    
    [messReq,chromReq,status]=DetermineRequiredNumberOfPixels...
        (messageLength,chromLength,numOfUsedBits,length(imCover(:)));
    
    [messPixelSeq,chromPixelSeq]=CreateHostPixelSeq...
        (oldChromPixels,xOff,yOff,direction,messReq,chromReq);
    
    stego = EmbeddingTheMessage(reqBitSeq,chromBitSeq,bitPlanes,...
        bpDir,imCover,messPixelSeq,chromPixelSeq);
    
    
end

