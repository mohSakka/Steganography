%% initialization
clear;
clc;
close all;
global imCover
%% adding required paths
addpath([cd '/../codes/Decomposed Benchmark code (Image hiding using GA)/' ...
    'Benchmark code (Image hiding using GA)']);
%% select the mod
mod = 1; % possible value 1,2 , if 1 then the visualization will be only for the
% Chest data set and for only 2 images, so the dsNumber also must be 2 , and
% the algorithm GA-TS results will considered.
% if mod=2 then the visualization will not contain GA-TS algorithm, but the
% 2 datasets will be available and the comparison will done for 5 images
%% select dataset
% 1-brain 2-chest
dsNumber = 2;
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
%% start
%% get the message and decompose it
message = bench.imSecEx;
stepsNum = 100;
n = 32;
step = round(length(message)/stepsNum);
lastGaMetaIdx = 1;
subMsgCount = 1;
for subMsgStep=1:step:length(message)
    %%%%%%%%
    try
        subMsg = message(1:subMsgStep+step-1);
    catch
        subMsg = message(1:end);
    end
    binSubMsg = dec2bin(subMsg,8);
    binSubMsg = binSubMsg';
    binSubMsg = binSubMsg(:)';
    %%%%%%%% 
    %% benchMark embidding
    rmpath([cd '/../codes/proposed method']);
    chrom = bench.chrom;
    oldChromPixels = [];
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
    
    stegoBench = EmbeddingTheMessage(reqBitSeq,chromBitSeq,bitPlanes,...
        bpDir,imCover,messPixelSeq,chromPixelSeq);
    %% decomposed2
    finalChrom = bench2.finalChrom;
    stegoBench2 = imCover;
    idx = 1;
    prevInd = 1;
    numberOfSubMsgs = 2;
    for sbmsg=1:numberOfSubMsgs
        try
        subMsgs{sbmsg} = subMsg(prevInd:prevInd + floor(length(subMsg)/numberOfSubMsgs));
        catch
            subMsgs{sbmsg} = subMsg(prevInd:end);
        end
        prevInd = prevInd+ceil(length(subMsg)/numberOfSubMsgs) + 1;
    end
    for ch=1:2
    chrom = finalChrom(idx:idx+6);
    idx = idx + 7;
    oldChromPixels = [];
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
    reqBitSeq=ChooseRightSecretSeq2(subMsgs{ch},sbPole,sbDir);
    messageLength=length(reqBitSeq(:));    % 27 is the length of chromosome
    % Chrom bit sequence
    chromBitSeq=ConvertChromToBitSeq(chrom);
    chromLength=length(chromBitSeq);
    
    [messReq,chromReq,status]=DetermineRequiredNumberOfPixels...
        (messageLength,chromLength,numOfUsedBits,length(imCover(:)));
    
    [messPixelSeq,chromPixelSeq]=CreateHostPixelSeq...
        (oldChromPixels,xOff,yOff,direction,messReq,chromReq);
    
    stegoBench2 = EmbeddingTheMessage(reqBitSeq,chromBitSeq,bitPlanes,...
        bpDir,stegoBench2,messPixelSeq,chromPixelSeq);
    oldChromPixels = [oldChromPixels chromPixelSeq];
    end
    %% decomposed3
    finalChrom = bench3.finalChrom;
    stegoBench3 = imCover;
    idx = 1;
     prevInd = 1;
     numberOfSubMsgs = 3;
    for sbmsg=1:numberOfSubMsgs
        try
        subMsgs{sbmsg} = subMsg(prevInd:prevInd + floor(length(subMsg)/numberOfSubMsgs));
        catch
            subMsgs{sbmsg} = subMsg(prevInd:end);
        end
        prevInd = prevInd+ceil(length(subMsg)/numberOfSubMsgs) + 1;
    end
    for ch=1:3
    chrom = finalChrom(idx:idx+6);
    idx = idx + 7;
    oldChromPixels = [];
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
    reqBitSeq=ChooseRightSecretSeq2(subMsgs{ch},sbPole,sbDir);
    messageLength=length(reqBitSeq(:));    % 27 is the length of chromosome
    % Chrom bit sequence
    chromBitSeq=ConvertChromToBitSeq(chrom);
    chromLength=length(chromBitSeq);
    
    [messReq,chromReq,status]=DetermineRequiredNumberOfPixels...
        (messageLength,chromLength,numOfUsedBits,length(imCover(:)));
    
    [messPixelSeq,chromPixelSeq]=CreateHostPixelSeq...
        (oldChromPixels,xOff,yOff,direction,messReq,chromReq);
    
    stegoBench3 = EmbeddingTheMessage(reqBitSeq,chromBitSeq,bitPlanes,...
        bpDir,stegoBench3,messPixelSeq,chromPixelSeq);
    oldChromPixels = [oldChromPixels chromPixelSeq];
    end
    %% metameric GA
    addpath([cd '/../codes/proposed method']);
    chrom = prop.bestChrom.chrom;
    metamericEmbidding
    stegoMetaGa = stegno;
   %% metameric TS
    chrom = ts.bestChrom.chrom;
    metamericEmbidding
    stegnoMetaTs = stegno;
    %% metameric GATS
if mod==1
chrom = gats.bestChrom.chrom;
metamericEmbidding
stegnoMetaGaTs = stegno;
end
%% calc the RS analysis parameters
% benchMark
[Rm_b(subMsgCount),Sm_b(subMsgCount),R_m_b(subMsgCount),...
    S_m_b(subMsgCount)] = find_RS(stegoBench,n);
% decomposed2
[Rm_b2(subMsgCount),Sm_b2(subMsgCount),R_m_b2(subMsgCount),...
    S_m_b2(subMsgCount)] = find_RS(stegoBench2,n);
% decomposed3
[Rm_b3(subMsgCount),Sm_b3(subMsgCount),R_m_b3(subMsgCount)...
    ,S_m_b3(subMsgCount)] = find_RS(stegoBench3,n);
% metameric Ga
[Rm_mga(subMsgCount),Sm_mga(subMsgCount),R_m_mga(subMsgCount)...
    ,S_m_mga(subMsgCount)] = find_RS(stegoMetaGa,n);
% metameric TS
[Rm_ts(subMsgCount),Sm_ts(subMsgCount),R_m_ts(subMsgCount)...
    ,S_m_ts(subMsgCount)] = find_RS(stegnoMetaTs,n);
% metameric GaTS
if mod==1
[Rm_gts(subMsgCount),Sm_gts(subMsgCount),R_m_gts(subMsgCount)...
    ,S_m_gts(subMsgCount)] = find_RS(stegnoMetaGaTs,n);
end
subMsgCount = subMsgCount+1
end
%% plotting
figure;
x = (1/stepsNum:1/stepsNum:1).*100;
legends = {'Rm','R-m','Sm','S-m'};
%% benchMark
subplot 231
hold on;
plot(x,Rm_b,'-');
plot(x,R_m_b,'--');
plot(x,Sm_b,'-');
plot(x,S_m_b,'--');
ylim([0 1]);
title('benchMark');
legend(legends);
xlabel('hiding capacity [%]');
ylabel('measure value');
%% decomposed2
subplot 232
hold on;
plot(x,Rm_b2,'-');
plot(x,R_m_b2,'--');
plot(x,Sm_b2,'-');
plot(x,S_m_b2,'--');
ylim([0 1]);
title('benchMark decomposed2');
legend(legends);
xlabel('hiding capacity [%]');
ylabel('measure value');
%% decomposed2
subplot 233
hold on;
plot(x,Rm_b3,'-');
plot(x,R_m_b3,'--');
plot(x,Sm_b3,'-');
plot(x,S_m_b3,'--');
ylim([0 1]);
title('benchMark decomposed3');
legend(legends);
xlabel('hiding capacity [%]');
ylabel('measure value');
%% metameric ga
subplot 234
hold on;
plot(x,Rm_mga,'-');
plot(x,R_m_mga,'--');
plot(x,Sm_mga,'-');
plot(x,S_m_mga,'--');
ylim([0 1]);
title('metameric ga');
legend(legends);
xlabel('hiding capacity [%]');
ylabel('measure value');
%% metameric ts
subplot 235
hold on;
plot(x,Rm_ts,'-');
plot(x,R_m_ts,'--');
plot(x,Sm_ts,'-');
plot(x,S_m_ts,'--');
ylim([0 1]);
title('metameric ts');
legend(legends);
xlabel('hiding capacity [%]');
ylabel('measure value');
%% metameric gats
if mod==1
subplot 236
hold on;
plot(x,Rm_gts,'-');
plot(x,R_m_gts,'--');
plot(x,Sm_gts,'-');
plot(x,S_m_gts,'--');
ylim([0 1]);
title('metameric gts');
legend(legends);
xlabel('hiding capacity [%]');
ylabel('measure value');
end
%% find the smoothness of each stegno image and cover image
format long;
%% imCover
[dx,dy] = gradient(double(imCover));
grad =  mean(mean((dy+dx).^2)/255);
smoothCover = 1-grad;
%% BenchMark
[dx,dy] = gradient(double(stegoBench));
grad =  mean(mean((dy+dx).^2)/255);
smoothBench = 1-grad;
%% Decomposed2
[dx,dy] = gradient(double(stegoBench2));
grad =  mean(mean((dy+dx).^2)/255);
smoothBench2 = 1-grad;
%% Decomposed3
[dx,dy] = gradient(double(stegoBench3));
grad =  mean(mean((dy+dx).^2)/255);
smoothBench3 = 1-grad;
%% MetaGa
[dx,dy] = gradient(double(stegoMetaGa));
grad =  mean(mean((dy+dx).^2)/255);
smoothMetaGa = 1-grad;
%% MetaTs
[dx,dy] = gradient(double(stegnoMetaTs));
grad =  mean(mean((dy+dx).^2)/255);
smoothMetaTs = 1-grad;
%% MetaGaTs
[dx,dy] = gradient(double(stegnoMetaGaTs));
grad =  mean(mean((dy+dx).^2)/255);
smoothMetaGaTs = 1-grad;
%% bar plot
if mod==1
bdata = [smoothCover,smoothBench,smoothBench2,smoothBench3,...
    smoothMetaGa,smoothMetaTs,smoothMetaGaTs];
lgnd = {'imCover','BenchMark','Decomposed2','Decomposed3',...
    'MetaGa','MetaTS','MetaGaTs'};
else
    bdata = [smoothCover,smoothBench,smoothBench2,smoothBench3,...
    smoothMetaGa,smoothMetaTs];
lgnd = {'imCover','BenchMark','Decomposed2','Decomposed3',...
    'MetaGa','MetaTS'};
end
xLabl = 'algorithm';
yLabl = 'smoothness';
Titl = 'Comparison of Smoothness';
styledBar(bdata,xLabl,yLabl,Titl,lgnd);
%% end