% generate child1
% get A ratio
rt = 0.1;
threshold = trueMesgBitsNum*rt;

Aratio = 1-ratio;
lengthOfApart = ceil(Aratio*ch1Length);
lengthOfBpart = ch1Length - lengthOfApart;
randomMetaIndsA = randperm(length(A.chrom),lengthOfApart);
child1.chrom(1:lengthOfApart) = A.chrom(randomMetaIndsA);
% compute the number of bits 
numberOfBits = computeNumberOfSecretBits(child1.chrom);
numberOfRemainedBits = trueMesgBitsNum - numberOfBits;
MetaIndsB = randperm(length(B.chrom),lengthOfBpart);
% find the blocks inds in A and B chromosome
indsOfAPartBlocks = findBlocksInds(A.chrom(randomMetaIndsA),QL,Ih);
indsOfBPartBlocks = findBlocksInds(B.chrom(MetaIndsB),QL,Ih);
while any(ismember(indsOfBPartBlocks,indsOfAPartBlocks))
    MetaIndsB = randperm(length(B.chrom),lengthOfBpart);
end
secondPartOfChrom = B.chrom(MetaIndsB);
numberOfBits2 = computeNumberOfSecretBits(secondPartOfChrom);
% find all assortements
assorts = combnk(1:length(B.chrom),lengthOfBpart);
index = 1;
while numberOfBits2~=numberOfRemainedBits%-threshold && numberOfBits2<=numberOfRemainedBits+threshold)
   if numberOfRemainedBits<0
       break;
   end
  
if numberOfBits2<numberOfRemainedBits
    differ = numberOfRemainedBits - numberOfBits2
% select other random metameric from B
newBMetaInd = randi(length(B.chrom));
indsOfnewBPartBlocks = findBlocksInds(B.chrom(newBMetaInd),QL,Ih);
while ismember(newBMetaInd,MetaIndsB) || ismember(indsOfnewBPartBlocks,indsOfAPartBlocks)
    newBMetaInd = randi(length(B.chrom)); 
end
% calculate the number of pixels needed from this metameric
[numberOfNeededPixels,allPixNum] = findNumberOfNeededPixels(B.chrom(newBMetaInd),differ);
if allPixNum>=numberOfNeededPixels
    toAddMeta = cell2mat(B.chrom(newBMetaInd));
    toAddMeta(end) =  numberOfNeededPixels;
    secondPartOfChrom = [secondPartOfChrom toAddMeta];
else
    toAddMeta = B.chrom(newBMetaInd);
        secondPartOfChrom = [secondPartOfChrom toAddMeta];
end
while numberOfNeededPixels>allPixNum
    % select other random metameric from B
newBMetaInd = randi(length(B.chrom));
indsOfnewBPartBlocks = findBlocksInds(B.chrom(newBMetaInd),QL,Ih);
while ismember(newBMetaInd,MetaIndsB) || ismember(indsOfnewBPartBlocks,indsOfABlocks)
    newBMetaInd = randi(length(B.chrom)); 
end
% calculate the number of pixels needed from this metameric
[numberOfNeededPixels,allPixNum] = findNumberOfNeededPixels(B.chrom(newBMetaInd),differ);
if allPixNum>=numberOfNeededPixels
    toAddMeta = B.chrom(newBMetaInd);
    toAddMeta(end) = numberOfNeededPixels;
    secondPartOfChrom = [secondPartOfChrom toAddMeta];
else
    toAddMeta = B.chrom(newBMetaInd);
        secondPartOfChrom = [secondPartOfChrom toAddMeta];
end
end
numberOfBits2 = computeNumberOfSecretBits(secondPartOfChrom);
else 
    differ = numberOfBits2 - numberOfRemainedBits;
   % select the last chromosome from sedcondPart
   meta = secondPartOfChrom(end);
   bp = meta(6);
   bp = dec2bin(bp,8);
   numberOfBits = length(find(bp=='1'));
neededPixelsNum = floor(differ/numberOfBits);
if neededPixelsNum<meta(end)
meta(end) = meta(end) - neededPixelsNum;
numberOfBits2 = numberOfBits2 - neededPixelsNum*numberOfBits;
else
        numberOfBits2 = numberOfBits2 - (meta(end)-1)*numberOfBits;
    meta(end) = 1;
newIndex = length(secondPartOfChrom);
    differ = numberOfBits2 - numberOfRemainedBits;
    while differ > 0
    newIndex = newIndex - 1;
    meta = secondPartOfChrom(newIndex);
    bp = meta(6);
    dbp = bp;
   bp = dec2bin(bp,8);
   numberOfBits = length(find(bp=='1'));
neededPixelsNum = floor(differ/numberOfBits);
if neededPixelsNum<meta(end)
meta(end) = meta(end) - neededPixelsNum;
numberOfBits2 = numberOfBits2 - neededPixelsNum*numberOfBits;
else
        numberOfBits2 = numberOfBits2 - (meta(end)-1)*numberOfBits;
    meta(end) = 1;
secondPartOfChrom(newIndex) = meta;
end
differ = numberOfBits2-numberOfRemainedBits;
%%%%%%%%%%%%%5
 if differ>0
    if differ==1
        if ismember(dbp,[3,5,6,9,10,12]) % if there is one bit overflow and the last pixel bitplanes number is 2 then the overflow bit will not affect and it will be ignored 
            differ = 0;
        end
    end
    if (differ>0) && (differ<=2)
        if ismember(dbp,[7,11,13,14]) % if there is 2 bits overflow and the last pixel bitplanes number is 3 then the overflow bits will not affect and they will be ignored 
             differ = 0;
        end
    end
    if (differ>0) && (differ<=3)
        if dbp==15 % if there is 3 bits overflow and the last pixel bitplanes number is 4 then the overflow bits will not affect and they will be ignored 
             differ = 0;
        end
    end
 end
    %%%%%%%%%%%%%%%%%%%
    end
end
end
end
child1.chrom = [child1.chrom secondPartOfChrom];
