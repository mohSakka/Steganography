function [bestChrom,m,pop,mn] = RunAlgorithm(Ih,Is,QL,T_nbc,popSize,maxGen,mr0,imName,seed,mutRatio,TS_mutation_numOfIters)
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
offSpring.Fitness = [];
offSpringCont = 1;
figure;
for genr=1:maxGen
    offSpring.Fitness = [];
    offSpringCont = 1;
    while length(offSpring.Fitness)<popSize
        % select 2 Elites based on mode (Objective function)
        Elite1Ind = fortune_wheel(pop.Fitness);
        Elite1Ind(Elite1Ind<0) = randi(length(pop.Fitness));
        Elite2Ind = fortune_wheel(pop.Fitness);
        Elite2Ind(Elite2Ind<0) = randi(length(pop.Fitness));

        countWhile = 1;
        while Elite1Ind==Elite2Ind
            Elite2Ind = fortune_wheel(pop.Fitness);
            Elite2Ind(Elite2Ind<0) = randi(length(pop.Fitness));
            countWhile = countWhile + 1;
            if countWhile>10 % to avoid infinite loop
%                 disp('error');
                Elite2Ind = randi(length(pop.Fitness));
            end
            
        end
        countWhile = 1;
        Elite1.chrom = pop.chrom{Elite1Ind};
        Elite1.stegno = pop.stegno{Elite1Ind};
        Elite1.Fitness = pop.Fitness(Elite1Ind);
        %%%%%%%%%%%
        Elite2.chrom = pop.chrom{Elite2Ind};
        Elite2.stegno = pop.stegno{Elite2Ind};
        Elite2.Fitness = pop.Fitness(Elite2Ind);
         [child1,child2] = crossoverFinal(Elite1,Elite2,trueMesgBitsNum,Ih,QL);
         [child1.stegno,child1.Fitness] = mesgImbedding(child1.chrom,Ih,QL,Is);
        [child2.stegno,child2.Fitness] = mesgImbedding(child2.chrom,Ih,QL,Is);
         for TS_i = 1:TS_mutation_numOfIters
             ch1 = MutateChrom(child1.chrom,mutRatio);
             ch1 = fixChrom(ch1,trueMesgBitsNum,QL,imSize,Ih);
             [S,F] = mesgImbedding(ch1,Ih,QL,Is); 
             if F>child1.Fitness
                 child1.Fitness = F;
                 child1.chrom = ch1;
                 child1.stegno = S;
             end
             
             ch2 = MutateChrom(child2.chrom,mutRatio);
             ch2 = fixChrom(ch2,trueMesgBitsNum,QL,imSize,Ih);
             [S,F] = mesgImbedding(ch2,Ih,QL,Is); 
             if F>child2.Fitness
                 child2.Fitness = F;
                 child2.chrom = ch2;
                 child2.stegno = S;
             end
   
         end
%         [child1,child2] = CrossOver2(0.5,Elite1,Elite2,Ih,QL,trueMesgBitsNum);
%         [child1,child2] = CrossOver(Elite1,Elite2,Ih,QL);
        % calculate mutation ratio
        mr = mr0*exp(-genr/maxGen);
% mr = mr0;
        %if rand<mr
         %   child1.chrom = MutateChrom(child1.chrom,mutRatio);
          %  child1.chrom = fixChrom(child1.chrom,trueMesgBitsNum,QL,imSize,Ih);
        %end
        %if rand<mr
         %   child2.chrom = MutateChrom(child2.chrom,mutRatio);
          %  child2.chrom = fixChrom(child2.chrom,trueMesgBitsNum,QL,imSize,Ih);
        %end
        % fixing child1 and child2
%         child1.chrom = fixChrom(child1.chrom,trueMesgBitsNum,QL,imSize,Ih);
%         child2.chrom = fixChrom(child2.chrom,trueMesgBitsNum,QL,imSize,Ih);
        %%%%%% create stegno
       % [child1.stegno,child1.Fitness] = mesgImbedding(child1.chrom,Ih,QL,Is);
       % [child2.stegno,child2.Fitness] = mesgImbedding(child2.chrom,Ih,QL,Is);

        offSpring.chrom{offSpringCont} = child1.chrom;
        offSpring.chrom{offSpringCont+1} = child2.chrom;
        offSpring.stegno{offSpringCont} = child1.stegno;
        offSpring.stegno{offSpringCont+1} = child2.stegno;
        offSpring.Fitness(offSpringCont) = child1.Fitness;
        offSpring.Fitness(offSpringCont+1) = child2.Fitness;
        %%%%%%%%%%%%
        offSpringCont = offSpringCont + 2;
    end
    %%%%%% merging old and new generations
    CandidatesChrom = [pop.chrom' ; offSpring.chrom'];
    CandidatesStegno = [pop.stegno' ; offSpring.stegno'];
    CandidatesFit = [pop.Fitness' ; offSpring.Fitness'];
    index = 1;
    for rollCont = 1:popSize
        [~,sortedCandidatesFitInds] = sort(CandidatesFit,'descend');
%         index = fortune_wheel(CandidatesFit);
%         index(index<1) = randi(length(CandidatesFit));
        newPop.chrom{rollCont} = CandidatesChrom{sortedCandidatesFitInds(index)};
        
        newPop.stegno{rollCont} = CandidatesStegno{sortedCandidatesFitInds(index)};
        newPop.Fitness(rollCont) = CandidatesFit(sortedCandidatesFitInds(index));
        index = index + 1;
%         CandidatesChrom(index) = [];
%         CandidatesStegno(index) = [];
%         CandidatesFit(index) = [];
    end
    pop = newPop;
    clc;
    disp(['image number: ' imName]);
    disp(['seed: ' num2str(seed)]);
    disp(['progress: ' num2str(((genr)/(maxGen))*100) ' %']);
    m(genr) = max(pop.Fitness);
    m(genr) = -  m(genr);
    mn(genr) = -mean(pop.Fitness);
    plot(m);
    drawnow
end

% hold on;
[maxFit,bestChromInd] = max(pop.Fitness);
maxFit = - maxFit;
bestChrom.chrom = pop.chrom{bestChromInd};
bestChrom.Fitness = pop.Fitness(bestChromInd);
bestChrom.stegno = pop.stegno{bestChromInd};
plot(m);
% profile viewer;
end
