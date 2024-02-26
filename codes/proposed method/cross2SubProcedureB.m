% generate child2
% get B ratio
rt = 0.1;
threshold = trueMesgBitsNum*rt;

Bratio = 1-ratio;
lengthOfBpart = ceil(Bratio*ch2Length);
lengthOfApart = ch2Length - lengthOfBpart;
randomMetaIndsB = randperm(length(B.chrom),lengthOfBpart);
child2.chrom(1:lengthOfBpart) = B.chrom(randomMetaIndsB);
% compute the number of bits 
numberOfBits = computeNumberOfSecretBits(child2.chrom);
numberOfRemainedBits = trueMesgBitsNum - numberOfBits;
MetaIndsA = randperm(length(A.chrom),lengthOfApart);
secondPartOfChrom = A.chrom(MetaIndsA);
numberOfBits2 = computeNumberOfSecretBits(secondPartOfChrom);
assorts = combnk(1:length(A.chrom),lengthOfApart);
index = 1;
while ~(numberOfBits2>=numberOfRemainedBits-threshold && numberOfBits2<=numberOfRemainedBits+threshold)
   if numberOfRemainedBits<0
       break;
   end
    if index>size(assorts,1)
        rt = rt + 0.1;
        threshold = trueMesgBitsNum*rt;
        index = 1;
   end
    MetaIndsA = assorts(index,:);
    secondPartOfChrom = A.chrom(MetaIndsA);
    index = index + 1;
numberOfBits2 = computeNumberOfSecretBits(secondPartOfChrom);
end
child2.chrom(lengthOfBpart+1:lengthOfBpart+lengthOfApart) = A.chrom(MetaIndsA);