function mutated = MutateChrom(chrom,ratio)
mutated = chrom;
numberOfMutated = round(ratio*length(chrom));
randomInds = randperm(length(chrom),numberOfMutated);
for ccc=1:length(randomInds)
randomIndx = randomInds(ccc);
meta = chrom{randomIndx};
% select one of b_dir, p_dir, SB-Pole, SB-Dire , BP-Dire, Bit-Planes
mutatedVar = 2 + randi(5);
if ismember(mutatedVar,[3 4 5])
    if meta(mutatedVar)==0
        meta(mutatedVar)=1;
    else
        meta(mutatedVar)=0;
    end
elseif mutatedVar==6
     meta(mutatedVar) = randi(15);
%     oldVal =  meta(mutatedVar);
%     oneBitArr = [1 2 4 8];
%     twoBitsArr = [3 5 6 9 10 12 ];
%     threeBitsArr = [7 11 13 14];
%     fourBitsArr = 15;
% if ismember(oldVal,oneBitArr)
%      ind = randi(4);
%      meta(mutatedVar) = oneBitArr(ind);
% elseif ismember(oldVal,twoBitsArr)
%     ind = randi(6);
%      meta(mutatedVar) = twoBitsArr(ind);
% elseif ismember(oldVal,threeBitsArr)
%      ind = randi(4);
%      meta(mutatedVar) = threeBitsArr(ind);
% else
%     meta(mutatedVar) = meta(mutatedVar);
% end
elseif mutatedVar==7
    oldVal =  meta(mutatedVar);
    while oldVal==meta(mutatedVar)
     meta(mutatedVar) = randi(15)-1;
    end
end
mutated{randomIndx} = meta;
end
end