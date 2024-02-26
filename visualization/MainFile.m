%% modify "mod" and "dsNumber" as you need 
%% initialization
clear;
clc;
close all;
lw = 1.5;
fs = 14;

%% adding required paths
addpath([cd '/../codes/Benchmark code (Image hiding using GA)/' ...
    'Benchmark code (Image hiding using GA)']);
addpath([cd '/../codes/Decomposed Benchmark code (Image hiding using GA)/' ...
    'Benchmark code (Image hiding using GA)']);
% format short
%% loading propsed method results
counter = 0;
dsNumber = 3; % select dataset number ,1-brain,2-chest,3-Rentina
datasets = {'brain images','Our Data','healthy'};
resultsNames = {'results message length x3','results message length x3 Chest' ,...
    'results-codeOcean-eye'};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numOfImgs = 2; 

for imNum = 1:numOfImgs
    imName1 = num2str(imNum);
    imName = num2str(imNum);
    if dsNumber==1
    imCoverData = load([cd '/../data/brain images/' imName1 '.mat']);
    imCover = imCoverData.cjdata.image;
    elseif dsNumber==3
        imCover = imread([cd '/../data/healthy/' imName1 '.jpg']);
    else
        imCover = imread([cd '/../data/Our Data/' imName1 '.jpeg']);
    end
    imCover = preprocess(imCover);
    for seed = 1:5
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
   
        counter = counter + 1;
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

        stegoBench4 = bench4.stego;
        stegoBenchVector4 = stegoBench4;
        stegoBenchImage4 = stegoBenchVector4;
        stegoBenchImage4 = uint8(stegoBenchImage4);
        % benchmark decomposed5
        stegoBench5 = bench5.stego;
        stegoBenchVector5 = stegoBench5;
        stegoBenchImage5 = stegoBenchVector5;
        stegoBenchImage5 = uint8(stegoBenchImage5);
        % benchmark decomposed6
        stegoBench6 = bench6.stego;
        stegoBenchVector6 = stegoBench6;
        stegoBenchImage6 = stegoBenchVector6;
        stegoBenchImage6 = uint8(stegoBenchImage6);
        % benchmark decomposed7
        stegoBench7 = bench7.stego;
        stegoBenchVector7 = stegoBench7;
        stegoBenchImage7 = stegoBenchVector7;
        stegoBenchImage7 = uint8(stegoBenchImage7);
        % benchmark decomposed8
        stegoBench8 = bench8.stego;
        stegoBenchVector8 = stegoBench8;
        stegoBenchImage8 = stegoBenchVector8;
        stegoBenchImage8 = uint8(stegoBenchImage8);
        % benchmark decomposed9
        stegoBench9 = bench9.stego;
        stegoBenchVector9 = stegoBench9;
        stegoBenchImage9 = stegoBenchVector9;
        stegoBenchImage9 = uint8(stegoBenchImage9);
        % benchmark decomposed10
        stegoBench10 = bench10.stego;
        stegoBenchVector10 = stegoBench10;
        stegoBenchImage10 = stegoBenchVector10;
        stegoBenchImage10 = uint8(stegoBenchImage10);
        %% computing the measures
        % MSE & PSNR
        
        [PSNRbench(counter),MSEbench(counter)] = measerr(imCover,stegoBenchVector);
        [PSNRbench2(counter),MSEbench2(counter)] = measerr(imCover,stegoBenchVector2);
        [PSNRbench3(counter),MSEbench3(counter)] = measerr(imCover,stegoBenchVector3);
            [PSNRbench4(counter),MSEbench4(counter)] = measerr(imCover,stegoBenchVector4);
            [PSNRbench5(counter),MSEbench5(counter)] = measerr(imCover,stegoBenchVector5);
            [PSNRbench6(counter),MSEbench6(counter)] = measerr(imCover,stegoBenchVector6);
            [PSNRbench7(counter),MSEbench7(counter)] = measerr(imCover,stegoBenchVector7);
            [PSNRbench8(counter),MSEbench8(counter)] = measerr(imCover,stegoBenchVector8);
            [PSNRbench9(counter),MSEbench9(counter)] = measerr(imCover,stegoBenchVector9);
            [PSNRbench10(counter),MSEbench10(counter)] = measerr(imCover,stegoBenchVector10);

            % correlation
       
        correlationBench(counter) = corr(double(stegoBenchVector(:)),double(imCover(:)));
        correlationBench2(counter) = corr(double(stegoBenchVector2(:)),double(imCover(:)));
        correlationBench3(counter) = corr(double(stegoBenchVector3(:)),double(imCover(:)));
        correlationBench4(counter) = corr(double(stegoBenchVector4(:)),double(imCover(:)));
        correlationBench5(counter) = corr(double(stegoBenchVector5(:)),double(imCover(:)));
        correlationBench6(counter) = corr(double(stegoBenchVector6(:)),double(imCover(:)));
        correlationBench7(counter) = corr(double(stegoBenchVector7(:)),double(imCover(:)));
        correlationBench8(counter) = corr(double(stegoBenchVector8(:)),double(imCover(:)));
        correlationBench9(counter) = corr(double(stegoBenchVector9(:)),double(imCover(:)));
        correlationBench10(counter) = corr(double(stegoBenchVector10(:)),double(imCover(:)));

        % Structural Similarity Index
        
        
        stegoBenchImage1 = uint8(stegoBenchImage);
        stegoBenchImage2 = uint8(stegoBenchImage2);
        stegoBenchImage3 = uint8(stegoBenchImage3);
        stegoBenchImage4 = uint8(stegoBenchImage4);
        stegoBenchImage5 = uint8(stegoBenchImage5);
        stegoBenchImage6 = uint8(stegoBenchImage6);
        stegoBenchImage7 = uint8(stegoBenchImage7);
        stegoBenchImage8 = uint8(stegoBenchImage8);
        stegoBenchImage9 = uint8(stegoBenchImage9);
        stegoBenchImage10 = uint8(stegoBenchImage10);
        
        imCover1 = uint8(imCover);
        
        ssimvalBench(counter) = ssim(stegoBenchImage1,imCover1);
        ssimvalBench2(counter) = ssim(stegoBenchImage2,imCover1);
        ssimvalBench3(counter) = ssim(stegoBenchImage2,imCover1);
        ssimvalBench4(counter) = ssim(stegoBenchImage4,imCover1);
        ssimvalBench5(counter) = ssim(stegoBenchImage5,imCover1);
        ssimvalBench6(counter) = ssim(stegoBenchImage6,imCover1);
        ssimvalBench7(counter) = ssim(stegoBenchImage7,imCover1);
        ssimvalBench8(counter) = ssim(stegoBenchImage8,imCover1);
        ssimvalBench9(counter) = ssim(stegoBenchImage9,imCover1);
        ssimvalBench10(counter) = ssim(stegoBenchImage10,imCover1);
        % fused measures
        % format short
        
        fusedMeasure1Bench(counter) = correlationBench(counter)*ssimvalBench(counter);
        fusedMeasure1Bench2(counter) = correlationBench2(counter)*ssimvalBench2(counter);
        fusedMeasure1Bench3(counter) = correlationBench3(counter)*ssimvalBench3(counter);

        fusedMeasure1Bench4(counter) = correlationBench4(counter)*ssimvalBench4(counter);
        fusedMeasure1Bench5(counter) = correlationBench5(counter)*ssimvalBench5(counter);
        fusedMeasure1Bench6(counter) = correlationBench6(counter)*ssimvalBench6(counter);
        fusedMeasure1Bench7(counter) = correlationBench7(counter)*ssimvalBench7(counter);
        fusedMeasure1Bench8(counter) = correlationBench8(counter)*ssimvalBench8(counter);
        fusedMeasure1Bench9(counter) = correlationBench9(counter)*ssimvalBench9(counter);
        fusedMeasure1Bench10(counter) = correlationBench10(counter)*ssimvalBench10(counter);
        
        fusedMeasure2Bench4(counter) = fusedMeasure1Bench4(counter)/MSEbench4(counter);
        fusedMeasure2Bench5(counter) = fusedMeasure1Bench5(counter)/MSEbench5(counter);
        
        fusedMeasure2Bench(counter) = fusedMeasure1Bench(counter)/MSEbench(counter);
        fusedMeasure2Bench2(counter) = fusedMeasure1Bench2(counter)/MSEbench2(counter);
        fusedMeasure2Bench3(counter) = fusedMeasure1Bench3(counter)/MSEbench3(counter);
        fusedMeasure2Bench7(counter) = fusedMeasure1Bench7(counter)/MSEbench7(counter);
        fusedMeasure2Bench8(counter) = fusedMeasure1Bench8(counter)/MSEbench8(counter);
        fusedMeasure2Bench9(counter) = fusedMeasure1Bench9(counter)/MSEbench9(counter);
        fusedMeasure2Bench10(counter) = fusedMeasure1Bench10(counter)/MSEbench10(counter);
         fusedMeasure2Bench6(counter) = fusedMeasure1Bench6(counter)/MSEbench6(counter);

        % HistOfDiff & smoothness
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

%                 % deco 4 
            [N_bench4,edges_bench4] = getHistOffDif(stegoBenchImage4);
            
            smoothBench4(counter) = calcSmoothness(stegoBenchImage4);
            % deco5
            [N_bench5,edges_bench5] = getHistOffDif(stegoBenchImage5);
%             
            smoothBench5(counter) = calcSmoothness(stegoBenchImage5);
% deco6
            [N_bench6,edges_bench6] = getHistOffDif(stegoBenchImage6);
%             
            smoothBench6(counter) = calcSmoothness(stegoBenchImage6);
% deco7
            [N_bench7,edges_bench7] = getHistOffDif(stegoBenchImage7);
%             
            smoothBench7(counter) = calcSmoothness(stegoBenchImage7);
% deco8
            [N_bench8,edges_bench8] = getHistOffDif(stegoBenchImage8);
%             
            smoothBench8(counter) = calcSmoothness(stegoBenchImage8);
% deco9
            [N_bench9,edges_bench9] = getHistOffDif(stegoBenchImage9);
%             
            smoothBench9(counter) = calcSmoothness(stegoBenchImage9);
% deco10
            [N_bench10,edges_bench10] = getHistOffDif(stegoBenchImage10);
%             
            smoothBench10(counter) = calcSmoothness(stegoBenchImage10);

            
            % compute SSE
            sseBench(counter) = sse(N_bench,N_cover);
            sseBench2(counter) = sse(N_bench2,N_cover);
            sseBench3(counter) = sse(N_bench3,N_cover);

            sseBench4(counter) = sse(N_bench4,N_cover);
            sseBench5(counter) = sse(N_bench5,N_cover);
sseBench6(counter) = sse(N_bench6,N_cover);
sseBench7(counter) = sse(N_bench7,N_cover);
sseBench8(counter) = sse(N_bench8,N_cover);
sseBench9(counter) = sse(N_bench9,N_cover);
sseBench10(counter) = sse(N_bench10,N_cover);
        end
        clc;
        disp(counter);
    end
%% start visualization
Labels = {'benchMark','decomposes2','decomposes3',...
       'decomposes4','decomposes5','decomposes6','decomposes7'...
       ,'decomposes8','decomposes9','decomposes10'};
% MSE
figure;
subplot 231
boxplot([MSEbench' ,MSEbench2' ,MSEbench3'...
       ,MSEbench4',MSEbench5' ,MSEbench6',MSEbench7',MSEbench8'...
       ,MSEbench9',MSEbench10'],'Labels',Labels);
   
title('MSE','fontsize',fs);
xlabel('algorithm','fontsize',fs);
ylabel('measure value','fontsize',fs);
set(gca, 'XTickLabelRotation', -45)
set(gca,'Fontsize',fs)
set(findobj(gca,'type','line'),'linew',lw)
% PSNR
subplot 232
boxplot([PSNRbench', PSNRbench2',PSNRbench3',PSNRbench4',PSNRbench5'...
    ,PSNRbench6',PSNRbench7',PSNRbench8',PSNRbench9',PSNRbench10'],'Labels',Labels);
title('PSNR','fontsize',fs);
xlabel('algorithm','fontsize',fs);
ylabel('measure value','fontsize',fs);
set(gca, 'XTickLabelRotation', -45)
set(gca,'Fontsize',fs)
set(findobj(gca,'type','line'),'linew',lw)
% correlation
% figure;
subplot 233
boxplot([correlationBench',correlationBench2',correlationBench3'...
      ,correlationBench4',correlationBench5',correlationBench6'...
      ,correlationBench7',correlationBench8',correlationBench9',correlationBench10'],'Labels',Labels);
title('Correlation','fontsize',fs);
xlabel('algorithm','fontsize',fs);
ylabel('measure value','fontsize',fs);
set(gca, 'XTickLabelRotation', -45)
set(gca,'Fontsize',fs)
set(findobj(gca,'type','line'),'linew',lw)
% Structural Similarity Index
% figure;
subplot 234
boxplot([ssimvalBench',ssimvalBench2',ssimvalBench3'...
       ,ssimvalBench4',ssimvalBench5',ssimvalBench6'...
       ,ssimvalBench7',ssimvalBench8',ssimvalBench9',ssimvalBench10'],'Labels',Labels);
set(gca, 'XTickLabelRotation', -45)
set(gca,'Fontsize',fs)
title('Structural Similarity Index','fontsize',fs);
xlabel('algorithm','fontsize',fs);
ylabel('measure value','fontsize',fs);
set(findobj(gca,'type','line'),'linew',lw)
% fused measure1
% figure;
subplot 235
boxplot([fusedMeasure1Bench',fusedMeasure1Bench2',fusedMeasure1Bench3'...
          ,fusedMeasure1Bench4',fusedMeasure1Bench5',fusedMeasure1Bench6'...
          ,fusedMeasure1Bench7',fusedMeasure1Bench8',fusedMeasure1Bench9'...
          ,fusedMeasure1Bench10'],'Labels',Labels);
set(gca, 'XTickLabelRotation', -45)
set(gca,'Fontsize',fs)
title('fused measure1','fontsize',fs);
xlabel('algorithm','fontsize',fs);
ylabel('measure value','fontsize',fs);
set(findobj(gca,'type','line'),'linew',lw)
% fused measure2
% figure;
subplot 236
boxplot([fusedMeasure2Bench',fusedMeasure2Bench2',fusedMeasure2Bench3'...
     ,fusedMeasure2Bench4',fusedMeasure2Bench5',fusedMeasure2Bench6'...
     ,fusedMeasure2Bench7',fusedMeasure2Bench8',fusedMeasure2Bench9',fusedMeasure2Bench10'],'Labels',Labels);  
set(gca, 'XTickLabelRotation', -45)
set(gca,'Fontsize',fs)
title('fused measure2','fontsize',fs);
xlabel('algorithm','fontsize',fs);
ylabel('measure value','fontsize',fs) ;
set(findobj(gca,'type','line'),'linew',lw)
% SSE(imCover_Hist,stegno_Hist)
figure;
boxplot([sseBench',sseBench2',sseBench3',sseBench4',sseBench5',...
    sseBench6',sseBench7',sseBench8',sseBench9',sseBench10'],'Labels',Labels);
set(gca, 'XTickLabelRotation', -45)
xlabel('algorithm','fontsize',fs);

set(gca,'Fontsize',fs)
set(findobj(gca,'type','line'),'linew',lw)
title('SSE(imCover-HistOfDiff,stegno-HistOfDiff)','fontsize',fs);
% smoothness
figure;
boxplot([smoothCover',smoothBench',smoothBench2',...
    smoothBench3',smoothBench4',smoothBench5',smoothBench6',smoothBench7',...
    smoothBench8',smoothBench9',smoothBench10'],'Labels',['imCover',Labels]);
set(gca, 'XTickLabelRotation', -45);
xlabel('algorithm','fontsize',fs);

set(findobj(gca,'type','line'),'linew',lw)
title('Smoothness','fontsize',fs);
set(gca,'Fontsize',fs)