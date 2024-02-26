function [bestChrom,m,pop,mn] = RunAlgorithm(Ih,Is,QL,T_nbc,popSize,maxGen,mr0,imName,seed,mutRatio)
% profile on;
binMessage = Is;
trueMesgBitsNum = length(binMessage);
for i=1:size(Ih,1)
    for j=1:size(Ih,2)
        Ihb{i,j} = dec2bin(Ih(i,j),8);
    end
end
%% Generate first population based on population size and pseudocode 1
[pop] = generateFirstPop2(Ih,Ihb,Is,QL,T_nbc,popSize);
pop = pop';
%% Evaluation
for i=1:popSize
    individual.stegno = pop.stegno{i};
    individual.chrom = pop.chrom{i};
    pop.Fitness(i) = ObjectiveFunc(individual,Ih,QL);
end
imSize = size(pop.stegno{1});
%% start iterations
%figure;
T = 10;
for genr=1:maxGen

           child1.chrom = MutateChrom(pop.chrom{i},mutRatio);
           child1.chrom = fixChrom(child1.chrom,trueMesgBitsNum,QL,imSize,Ih);
        [child1.stegno,child1.Fitness] = mesgImbedding(child1.chrom,Ih,QL,Is);
    if child1.Fitness >  pop.Fitness(i)
        pop.Fitness(i) = child1.Fitness
        pop.chrom{i} = child1.chrom
        pop.stegno{i} =  child1.stegno
    else
        delta = child1.Fitness - pop.Fitness(i)
        if rand<0%exp(-delta/(genr*T))
         pop.Fitness(i) = child1.Fitness
        pop.chrom{i} = child1.chrom
        pop.stegno{i} =  child1.stegno
        end
        
    end
       T = T*0.1; 
        clc;
    disp(['image number: ' imName]);
    disp(['seed: ' num2str(seed)]);
    disp(['progress: ' num2str(((genr)/(maxGen))*100) ' %']);
    m(genr) = max(pop.Fitness);
    m(genr) = -  m(genr);
    mn(genr) = -mean(pop.Fitness);
 %   plot(m);
    %drawnow
end

% hold on;
[maxFit,bestChromInd] = max(pop.Fitness);
maxFit = - maxFit;
bestChrom.chrom = pop.chrom{bestChromInd};
bestChrom.Fitness = pop.Fitness(bestChromInd);
bestChrom.stegno = pop.stegno{bestChromInd};
%plot(m);
% profile viewer;
end
