%% initialization
clear;
clc;
%close all;
global imCover
%% adding required paths
addpath([cd '/../codes/Decomposed Benchmark code (Image hiding using GA)/' ...
    'Benchmark code (Image hiding using GA)']);
%% select dataset
% 1-brain 2-chest 3-rentina
dsNumber = 3;
datasets = {'brain images','Our Data','healthy'};
%% select image number from 1->2
imNum = 2;
%% select seed from 1-->5
seed = 1;
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
%% start
%% get the message and decompose it
message = bench.imSecEx;
stepsNum = 25;
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
    stegoBench = imCover;
    idx = 1;
    prevInd = 1;
    numberOfSubMsgs = 2;
    embed_deco;
    stegoBench2 = stegoBench;
    %% decomposed3
    finalChrom = bench3.finalChrom;
    stegoBench = imCover;
    idx = 1;
     prevInd = 1;
     numberOfSubMsgs = 3;
    embed_deco;
    stegoBench3 = stegoBench;
     %% decomposed4
    finalChrom = bench4.finalChrom;
    stegoBench = imCover;
    idx = 1;
     prevInd = 1;
     numberOfSubMsgs = 4;
   embed_deco;
    stegoBench4 = stegoBench;
     %% decomposed5
    finalChrom = bench5.finalChrom;
    stegoBench = imCover;
    idx = 1;
     prevInd = 1;
     numberOfSubMsgs = 5;
   embed_deco;
    stegoBench5 = stegoBench;
    %% decomposed6
    finalChrom = bench6.finalChrom;
    stegoBench = imCover;
    idx = 1;
     prevInd = 1;
     numberOfSubMsgs = 6;
     embed_deco;
    stegoBench6 = stegoBench;
     %% decomposed7
    finalChrom = bench7.finalChrom;
    stegoBench = imCover;
    idx = 1;
     prevInd = 1;
     numberOfSubMsgs = 7;
   embed_deco;
    stegoBench7 = stegoBench;
     %% decomposed8
    finalChrom = bench8.finalChrom;
    stegoBench = imCover;
    idx = 1;
     prevInd = 1;
     numberOfSubMsgs = 8;
   embed_deco;
    stegoBench8 = stegoBench;
     %% decomposed9
    finalChrom = bench9.finalChrom;
    stegoBench = imCover;
    idx = 1;
     prevInd = 1;
     numberOfSubMsgs = 9;
     embed_deco;
    stegoBench9 = stegoBench;
     %% decomposed5
    finalChrom = bench10.finalChrom;
    stegoBench = imCover;
    idx = 1;
     prevInd = 1;
     numberOfSubMsgs = 10;
     embed_deco;
    stegoBench10 = stegoBench;
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
% decomposed4
[Rm_b4(subMsgCount),Sm_b4(subMsgCount),R_m_b4(subMsgCount)...
    ,S_m_b4(subMsgCount)] = find_RS(stegoBench4,n);
% decomposed5
[Rm_b5(subMsgCount),Sm_b5(subMsgCount),R_m_b5(subMsgCount)...
    ,S_m_b5(subMsgCount)] = find_RS(stegoBench5,n);
% decomposed6
[Rm_b6(subMsgCount),Sm_b6(subMsgCount),R_m_b6(subMsgCount)...
    ,S_m_b6(subMsgCount)] = find_RS(stegoBench6,n);
% decomposed7
[Rm_b7(subMsgCount),Sm_b7(subMsgCount),R_m_b7(subMsgCount)...
    ,S_m_b7(subMsgCount)] = find_RS(stegoBench7,n);
% decomposed8
[Rm_b8(subMsgCount),Sm_b8(subMsgCount),R_m_b8(subMsgCount)...
    ,S_m_b8(subMsgCount)] = find_RS(stegoBench8,n);
% decomposed9
[Rm_b9(subMsgCount),Sm_b9(subMsgCount),R_m_b9(subMsgCount)...
    ,S_m_b9(subMsgCount)] = find_RS(stegoBench9,n);
% decomposed10
[Rm_b10(subMsgCount),Sm_b10(subMsgCount),R_m_b10(subMsgCount)...
    ,S_m_b10(subMsgCount)] = find_RS(stegoBench10,n);
subMsgCount = subMsgCount+1
end
%% plotting
figure;
x = ((1:length(Rm_b))./length(Rm_b)).*100;
legends = {'Rm','R-m','Sm','S-m'};
%% benchMark
subplot 251
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
set(gca,'Fontsize',10,'linewidth',1.5)
%% decomposed2
subplot 252
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
set(gca,'Fontsize',10,'linewidth',1.5)
%% decomposed3
subplot 253
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
set(gca,'Fontsize',10,'linewidth',1.5)
%% decomposed4
subplot 254
hold on;
plot(x,Rm_b4,'-');
plot(x,R_m_b4,'--');
plot(x,Sm_b4,'-');
plot(x,S_m_b4,'--');
ylim([0 1]);
title('benchMark decomposed4');
legend(legends);
xlabel('hiding capacity [%]');
ylabel('measure value');
set(gca,'Fontsize',10,'linewidth',1.5)
%% decomposed5
subplot 255
hold on;
plot(x,Rm_b5,'-');
plot(x,R_m_b5,'--');
plot(x,Sm_b5,'-');
plot(x,S_m_b5,'--');
ylim([0 1]);
title('benchMark decomposed5');
legend(legends);
xlabel('hiding capacity [%]');
ylabel('measure value');
set(gca,'Fontsize',10,'linewidth',1.5)
%% decomposed6
subplot 256
hold on;
plot(x,Rm_b6,'-');
plot(x,R_m_b6,'--');
plot(x,Sm_b6,'-');
plot(x,S_m_b6,'--');
ylim([0 1]);
title('benchMark decomposed6');
legend(legends);
xlabel('hiding capacity [%]');
ylabel('measure value');
set(gca,'Fontsize',10,'linewidth',1.5)
%% decomposed3
subplot 257
hold on;
plot(x,Rm_b7,'-');
plot(x,R_m_b7,'--');
plot(x,Sm_b7,'-');
plot(x,S_m_b7,'--');
ylim([0 1]);
title('benchMark decomposed7');
legend(legends);
xlabel('hiding capacity [%]');
ylabel('measure value');
set(gca,'Fontsize',10,'linewidth',1.5)
%% decomposed8
subplot 258
hold on;
plot(x,Rm_b8,'-');
plot(x,R_m_b8,'--');
plot(x,Sm_b8,'-');
plot(x,S_m_b8,'--');
ylim([0 1]);
title('benchMark decomposed8');
legend(legends);
xlabel('hiding capacity [%]');
ylabel('measure value');
set(gca,'Fontsize',10,'linewidth',1.5)
%% decomposed3
subplot 259
hold on;
plot(x,Rm_b9,'-');
plot(x,R_m_b9,'--');
plot(x,Sm_b9,'-');
plot(x,S_m_b9,'--');
ylim([0 1]);
title('benchMark decomposed9');
legend(legends);
xlabel('hiding capacity [%]');
ylabel('measure value');
set(gca,'Fontsize',10,'linewidth',1.5)
%% decomposed3
subplot (2,5,10)
hold on;
plot(x,Rm_b10,'-');
plot(x,R_m_b10,'--');
plot(x,Sm_b10,'-');
plot(x,S_m_b10,'--');
ylim([0 1]);
title('benchMark decomposed10');
legend(legends);
xlabel('hiding capacity [%]');
ylabel('measure value');
set(gca,'Fontsize',10,'linewidth',1.5)
%% end