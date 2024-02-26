%% modify "mod" and "dsNumber" as you need 
%% initialization
clear;
clc;
close all;
%% adding required paths
addpath([cd '/../codes/Benchmark code (Image hiding using GA)/' ...
    'Benchmark code (Image hiding using GA)']);
addpath([cd '/../codes/Copy_of_Benchmark code (Image hiding using GA)/' ...
    'Benchmark code (Image hiding using GA)']);
addpath([cd '/../codes/proposed method']);
% format short
%% loading propsed method results
mod = 3; % possible value 1,2 , if 1 then the visualization will be only for the
% Chest data set and for only 2 images, so the dsNumber also must be 2 , and 
% the algorithm GA-TS results will considered.
% if mod=2 then the visualization will not contain GA-TS algorithm, but the
% 2 datasets will be available and the comparison will done for 5 images 
% if mod=3 then the GA-TS will not be included, and the possible datasets
% numbers are 3,4,5 and new 2 configurations will be considered 
counter = 0;
dsNumber = 5; % select dataset number 1-Brain, 2-Chest ,3-brain but with 
                                                         % long message
%                            4-chest but with long message
%                            5-Rentina with long message
datasets = {'brain images','Our Data','healthy'};
resultsNames = {'results-codeOcean-Brain','results-codeOcean-Chest',...
    'results message length x3','results message length x3 Chest' ,...
    'results-codeOcean-eye'};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numOfImgs = 2*(mod==1) + 5*(mod==2); 
if ismember(dsNumber,[3 4 5]) 
    numOfImgs=2;
end
imArr = 1:numOfImgs;
if dsNumber==2 && mod==2
    imArr(end)=6;
end
for imNum = imArr
    imName1 = num2str(imNum);
    imName = num2str(imNum);
    if dsNumber==1 || dsNumber==3
        imCoverData = load([cd '/../data/brain images/' imName1]);
        imCover = imCoverData.cjdata.image;
    elseif dsNumber==5 || dsNumber==6 || dsNumber==7
        imCover = imread([cd '/../data/healthy/' imName1 '.jpg']);
    else
        imCover = imread([cd '/../data/Our Data/' imName1 '.jpeg']);
    end
    imCover = preprocess(imCover);
    for seed = 1:5
        sd = num2str(seed);
        prop = load([cd '\..\' [resultsNames{dsNumber}] '\proposed\' imName '_seed ' sd]);
        bench = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark\' imName '_seed ' sd]);
        ts = load([cd '\..\' [resultsNames{dsNumber}] '\TS\' imName '_seed ' sd]);
        if mod==1
        gats =load([cd '\..\' [resultsNames{dsNumber}] '\GATS\' imName '_seed ' sd]);
        end
        bench2 = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark_Decomposed2\' imName '_seed ' sd]);
        bench3 = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark_Decomposed3\' imName '_seed ' sd]);
        if mod==3
            bench4 = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark_Decomposed4\' imName '_seed ' sd]);
            bench5 = load([cd '\..\' [resultsNames{dsNumber}] '\BenchMark_Decomposed5\' imName '_seed ' sd]);
        end
            counter = counter + 1;
        % propsosed
        chromProp = prop.bestChrom;
        stegoProp = chromProp.stegno;
        stegoPropVector = stegoProp;
        stegoPropImage = stegoPropVector;
        %ts
        chromTS = ts.bestChrom;
        stegoTS = chromTS.stegno;
        stegoTSVector = stegoTS;
        stegoTSImage = stegoTSVector;
        %gats
        if mod==1
        chromGATS = gats.bestChrom;
        stegoGATS = chromGATS.stegno;
        stegoGATSVector = stegoGATS;
        stegoGATSImage = stegoGATSVector;
        end
        % benchmark
        stegoBench = bench.stego;
        % sg = dec2bin(stegoBench,8);
        stegoBenchVector = stegoBench;
        stegoBenchImage = stegoBenchVector;
        % benchmark decomposed2
        stegoBench2 = bench2.stego;
        % sg = dec2bin(stegoBench,8);
        stegoBenchVector2 = stegoBench2;
        stegoBenchImage2 = stegoBenchVector2;
        % benchmark decomposed3
        stegoBench3 = bench3.stego;
        % sg = dec2bin(stegoBench,8);
        stegoBenchVector3 = stegoBench3;
        stegoBenchImage3 = stegoBenchVector3;
        stegoBenchImage3 = uint8(stegoBenchImage3);
        if mod==3
        % benchmark decomposed4
        stegoBench4 = bench4.stego;
        stegoBenchVector4 = stegoBench4;
        stegoBenchImage4 = stegoBenchVector4;
        stegoBenchImage4 = uint8(stegoBenchImage4);
        % benchmark decomposed5
        stegoBench5 = bench5.stego;
        stegoBenchVector5 = stegoBench5;
        stegoBenchImage5 = stegoBenchVector5;
        stegoBenchImage5 = uint8(stegoBenchImage5);
        end
        %% computing the measures
        % MSE & PSNR
        [PSNRTS(counter),MSETS(counter)] = measerr(imCover,stegoTSVector);
        if mod==1
        [PSNRGATS(counter),MSEGATS(counter)] = measerr(imCover,stegoGATSVector);
        end
        [PSNRprop(counter),MSEprop(counter)] = measerr(imCover,stegoPropVector);
        [PSNRbench(counter),MSEbench(counter)] = measerr(imCover,stegoBenchVector);
        [PSNRbench2(counter),MSEbench2(counter)] = measerr(imCover,stegoBenchVector2);
        [PSNRbench3(counter),MSEbench3(counter)] = measerr(imCover,stegoBenchVector3);
        if mod==3
            [PSNRbench4(counter),MSEbench4(counter)] = measerr(imCover,stegoBenchVector4);
            [PSNRbench5(counter),MSEbench5(counter)] = measerr(imCover,stegoBenchVector5);
        end
        % correlation
        correlationTS(counter) = corr(double(stegoTSVector(:)),double(imCover(:)));
        if mod==1
        correlationGATS(counter) = corr(double(stegoGATSVector(:)),double(imCover(:)));
        end
        correlationProp(counter) = corr(double(stegoPropVector(:)),double(imCover(:)));
        correlationBench(counter) = corr(double(stegoBenchVector(:)),double(imCover(:)));
        correlationBench2(counter) = corr(double(stegoBenchVector2(:)),double(imCover(:)));
        correlationBench3(counter) = corr(double(stegoBenchVector3(:)),double(imCover(:)));
        if mod==3
            correlationBench4(counter) = corr(double(stegoBenchVector4(:)),double(imCover(:)));
            correlationBench5(counter) = corr(double(stegoBenchVector5(:)),double(imCover(:)));
        end
        % Structural Similarity Index
        stegoTSImage1 = uint8(stegoTSImage);
        if mod==1
        stegoGATSImage1 = uint8(stegoGATSImage);
        end
        stegoPropImage1 = uint8(stegoPropImage);
        
        stegoBenchImage1 = uint8(stegoBenchImage);
        stegoBenchImage2 = uint8(stegoBenchImage2);
        stegoBenchImage3 = uint8(stegoBenchImage3);
        if mod==3
            stegoBenchImage4 = uint8(stegoBenchImage4);
            stegoBenchImage5 = uint8(stegoBenchImage5);
        end
        imCover1 = uint8(imCover);
        ssimvalTS(counter) = ssim(stegoTSImage1,imCover1);
        if mod==1
        ssimvalGATS(counter) = ssim(stegoGATSImage1,imCover1);
        end
        ssimvalProp(counter) = ssim(stegoPropImage1,imCover1);
        ssimvalBench(counter) = ssim(stegoBenchImage1,imCover1);
        ssimvalBench2(counter) = ssim(stegoBenchImage2,imCover1);
        ssimvalBench3(counter) = ssim(stegoBenchImage2,imCover1);
        if mod==3
            ssimvalBench4(counter) = ssim(stegoBenchImage4,imCover1);
            ssimvalBench5(counter) = ssim(stegoBenchImage5,imCover1);
        end
        % fused measures
        % format short
        fusedMeasure1TS(counter) = correlationTS(counter)*ssimvalTS(counter);
        if mod==1
        fusedMeasure1GATS(counter) = correlationGATS(counter)*ssimvalGATS(counter);
        end
        fusedMeasure1Prop(counter) = correlationProp(counter)*ssimvalProp(counter);
        fusedMeasure2TS(counter) = fusedMeasure1TS(counter)/MSETS(counter);
        
        if mod==1
        fusedMeasure2GATS(counter) = fusedMeasure1GATS(counter)/MSEGATS(counter);
        end
        fusedMeasure2Prop(counter) = fusedMeasure1Prop(counter)/MSEprop(counter);
        fusedMeasure1Bench(counter) = correlationBench(counter)*ssimvalBench(counter);
        fusedMeasure1Bench2(counter) = correlationBench2(counter)*ssimvalBench2(counter);
        fusedMeasure1Bench3(counter) = correlationBench3(counter)*ssimvalBench3(counter);
        if mod==3
        fusedMeasure1Bench4(counter) = correlationBench4(counter)*ssimvalBench4(counter);
        fusedMeasure1Bench5(counter) = correlationBench5(counter)*ssimvalBench5(counter);
        fusedMeasure2Bench4(counter) = fusedMeasure1Bench4(counter)/MSEbench4(counter);
        fusedMeasure2Bench5(counter) = fusedMeasure1Bench5(counter)/MSEbench5(counter);
        end
        fusedMeasure2Bench(counter) = fusedMeasure1Bench(counter)/MSEbench(counter);
        fusedMeasure2Bench2(counter) = fusedMeasure1Bench2(counter)/MSEbench2(counter);
        fusedMeasure2Bench3(counter) = fusedMeasure1Bench3(counter)/MSEbench3(counter);
        % HistOfDiff & smoothness
        if mod==1
            % imCover
            [N_cover,edges_cover] = getHistOffDif(imCover);
            smoothCover(counter) = calcSmoothness(imCover);
            % benchMark
            [N_bench,edges_bench] = getHistOffDif(stegoBenchImage1);
            smoothBench(counter) = calcSmoothness(stegoBenchImage1);
            % deco 2 
            [N_bench2,edges_bench2] = getHistOffDif(stegoBenchImage2);
            smoothBench2(counter) = calcSmoothness(stegoBenchImage2);
            % deco 3 
            [N_bench3,edges_bench3] = getHistOffDif(stegoBenchImage3);
            smoothBench3(counter) = calcSmoothness(stegoBenchImage3);
%             if mod==3
%                 % deco 4 
%             [N_bench4,edges_bench4] = getHistOffDif(stegoBenchImage4);
%             
%             smoothBench4(counter) = calcSmoothness(stegoBenchImage4);
%             % deco5
%             [N_bench5,edges_bench5] = getHistOffDif(stegoBenchImage5);
%             
%             smoothBench5(counter) = calcSmoothness(stegoBenchImage5);
%             end
            % prop
            [N_prop,edges_prop] = getHistOffDif(stegoPropImage1);
            smoothProp(counter) = calcSmoothness(stegoPropImage1);
            % prop_TS
            [N_TS,edges_Ts] = getHistOffDif(stegoTSImage1);
            smoothTs(counter) = calcSmoothness(stegoTSImage1);
            % prop_GATS
            [N_GATS,edges_GATS] = getHistOffDif(stegoGATSImage1);
            smoothGaTs(counter) = calcSmoothness(stegoGATSImage1);
            % compute SSE
            sseBench(counter) = sse(N_bench,N_cover);
            sseBench2(counter) = sse(N_bench2,N_cover);
            sseBench3(counter) = sse(N_bench3,N_cover);
%             if mod==3
%                 sseBench4(counter) = sse(N_bench4,N_cover);
%             sseBench5(counter) = sse(N_bench5,N_cover);
%             end
            sseProp(counter) = sse(N_prop,N_cover);
            sseTS(counter) = sse(N_TS,N_cover);
            
            sseGATS(counter) = sse(N_GATS,N_cover);
        end
        clc;
        disp(counter);
    end
end
%% start visualization
if mod==1
Labels = {'metaTS','metaGATS','metaGA','benchMark','decomposes2','decomposes3'};
elseif mod==3
   Labels = {'metaTS','metaGA','benchMark','decomposes2','decomposes3',...
       'decomposes4','decomposes5'};
else 
  Labels = {'metaTS','metaGA','benchMark','decomposes2','decomposes3'};
end
% MSE
figure;
subplot 231
if mod==1
boxplot([MSETS', MSEGATS', MSEprop',MSEbench' ,MSEbench2' ,MSEbench3'],'Labels',Labels);
elseif mod==3
    boxplot([MSETS', MSEprop',MSEbench' ,MSEbench2' ,MSEbench3'...
       ,MSEbench4',MSEbench5' ],'Labels',Labels);
else
    boxplot([MSETS', MSEprop',MSEbench', MSEbench2',MSEbench3'],'Labels',Labels);
end
title('MSE');
xlabel('algorithm');
ylabel('measure value');
set(gca, 'XTickLabelRotation', -45)
% PSNR
subplot 232
if mod==1
boxplot([PSNRTS', PSNRGATS', PSNRprop',PSNRbench' ,PSNRbench2' ,PSNRbench3'],'Labels',Labels);
elseif mod==3
    boxplot([PSNRTS', PSNRprop',PSNRbench', PSNRbench2',PSNRbench3',PSNRbench4',PSNRbench5'],'Labels',Labels);
else
    boxplot([PSNRTS', PSNRprop',PSNRbench', PSNRbench2',PSNRbench3'],'Labels',Labels);
end
title('PSNR');
xlabel('algorithm');
ylabel('measure value');
set(gca, 'XTickLabelRotation', -45)

% correlation
% figure;
subplot 233
if mod==1
boxplot([correlationTS',correlationGATS',correlationProp',correlationBench',correlationBench2',correlationBench3'],'Labels',Labels);
elseif mod==3
  boxplot([correlationTS',correlationProp',correlationBench',correlationBench2',correlationBench3'...
      ,correlationBench4',correlationBench5'],'Labels',Labels);
else
  boxplot([correlationTS',correlationProp',correlationBench',correlationBench2',correlationBench3'],'Labels',Labels);
end
title('Correlation');
xlabel('algorithm');
ylabel('measure value');
set(gca, 'XTickLabelRotation', -45)
% Structural Similarity Index
% figure;
subplot 234
if mod==1
boxplot([ssimvalTS',ssimvalGATS',ssimvalProp',ssimvalBench',ssimvalBench2',ssimvalBench3'],'Labels',Labels);
elseif mod==3
   boxplot([ssimvalTS',ssimvalProp',ssimvalBench',ssimvalBench2',ssimvalBench3'...
       ,ssimvalBench4',ssimvalBench5'],'Labels',Labels);
else
   boxplot([ssimvalTS',ssimvalProp',ssimvalBench',ssimvalBench2',ssimvalBench3'],'Labels',Labels);
end
set(gca, 'XTickLabelRotation', -45)
title('Structural Similarity Index');
xlabel('algorithm');
ylabel('measure value');
% fused measure1
% figure;
subplot 235
if mod==1
boxplot([fusedMeasure1TS',fusedMeasure1GATS',fusedMeasure1Prop',fusedMeasure1Bench',fusedMeasure1Bench2',fusedMeasure1Bench3'],'Labels',Labels);
elseif mod==3
      boxplot([fusedMeasure1TS',fusedMeasure1Prop',fusedMeasure1Bench',fusedMeasure1Bench2',fusedMeasure1Bench3'...
          ,fusedMeasure1Bench4',fusedMeasure1Bench5'],'Labels',Labels);
else
    
  boxplot([fusedMeasure1TS',fusedMeasure1Prop',fusedMeasure1Bench',fusedMeasure1Bench2',fusedMeasure1Bench3'],'Labels',Labels);
end  
set(gca, 'XTickLabelRotation', -45)
title('fused measure1');
xlabel('algorithm');
ylabel('measure value');
% fused measure2s
% figure;
subplot 236
if mod==1
boxplot([fusedMeasure2TS',fusedMeasure2GATS',fusedMeasure2Prop',fusedMeasure2Bench',fusedMeasure2Bench2',fusedMeasure2Bench3'],'Labels',Labels);
elseif mod==3
 boxplot([fusedMeasure2TS',fusedMeasure2Prop',fusedMeasure2Bench',fusedMeasure2Bench2',fusedMeasure2Bench3'...
     ,fusedMeasure2Bench4',fusedMeasure2Bench5'],'Labels',Labels);
else
 boxplot([fusedMeasure2TS',fusedMeasure2Prop',fusedMeasure2Bench',fusedMeasure2Bench2',fusedMeasure2Bench3'],'Labels',Labels);
end   
set(gca, 'XTickLabelRotation', -45)
title('fused measure2');
xlabel('algorithm');
ylabel('measure value') ;
if mod==1
% SSE(imCover_Hist,stegno_Hist)
figure;
boxplot([sseTS',sseGATS',sseProp',sseBench',sseBench2',sseBench3'],...
    'Labels',Labels);
set(gca, 'XTickLabelRotation', -45)
title('SSE(imCover-HistOfDiff,stegno-HistOfDiff)');
end
if mod==1
% smoothness
figure;
boxplot([smoothCover',smoothTs',smoothGaTs',smoothProp',smoothBench',smoothBench2',...
    smoothBench3'],...
    'Labels',['imCover',Labels]);
set(gca, 'XTickLabelRotation', -45)
title('Smoothness');
end