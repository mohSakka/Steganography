function [child1,child2] = crossover3(E1,E2,crossRatio,trueBitsNum)
global Ih;
global QL;
child1 = E1;
child2 = E2;
A = E1.chrom;
B = E2.chrom;
CLength = length(A);
DLength = length(B);
[commonA commonB] = findAandBintersection(A,B);
newA = A;
newA(commonA) = [];
newB = B;
newB(commonB) = [];
C = A(commonA);
D = B(commonB);
remainedCLength = CLength - length(C);
remainedDLength = DLength - length(D);
% if remainedCLength<=0 || remainedDLength<=0
%     disp('err');
% end
% generate the remained part of C
if remainedCLength>0
Aratio = 1 - crossRatio;
AmetasNum = ceil(Aratio * remainedCLength);
AmetasInds = randperm(length(newA),AmetasNum);
Ametas = newA(AmetasInds);
C = [C Ametas];
newA2 = newA;
newA2(AmetasInds) = [];
newB2 = newB;
end
numberOfBits = computeNumberOfSecretBits(C);
while numberOfBits~=trueBitsNum
    if trueBitsNum>numberOfBits
        differ = trueBitsNum - numberOfBits;
        dbp = C{end}(6);
if ~isempty(newB2)
            metaBInd = randi(length(newB2));
            metaB = newB2{metaBInd};
            pixNumNeeded = findPixNumNeeded(metaB,differ);
            blockSize = findBlockSize(metaB(1),metaB(2));
            pixThresh = blockSize(1)*blockSize(2);
            if pixNumNeeded>pixThresh
                pixNumNeeded = pixThresh;
            end
            metaB(end) = pixNumNeeded;
            C = [C metaB];
            newB2(metaBInd) = [];
            numberOfBits = computeNumberOfSecretBits(C);
        else % if isempty(newB2)
            if isempty(newA2)
                disp('What !!!');
            end
            metaAInd = randi(length(newA2));
            metaA = newA2{metaAInd};
            pixNumNeeded = findPixNumNeeded(metaA,differ);
            blockSize = findBlockSize(metaA(1),metaA(2));
            pixThresh = blockSize(1)*blockSize(2);
            if pixNumNeeded>pixThresh
                pixNumNeeded = pixThresh;
            end
            metaA(end) = pixNumNeeded;
            C = [C metaA];
            newA2(metaAInd) = [];
            numberOfBits = computeNumberOfSecretBits(C);
        end
    else % if numberOfBits>trueBitsNum
        differ = numberOfBits - trueBitsNum;
         lastCMeta = C{end};
         dbp = lastCMeta(6);
        %%%%%%%%%%%%%%%%%%%%%%%%%
if differ==1
        if ismember(dbp,[3,5,6,9,10,12]) % if there is one bit overflow and the last pixel bitplanes number is 2 then the overflow bit will not affect and it will be ignored 
            break;
        end
end
    if  differ>=1 && differ<=2 
        if ismember(dbp,[7,11,13,14]) % if there is 2 bits overflow and the last pixel bitplanes number is 3 then the overflow bits will not affect and they will be ignored 
             break;
        end
    end
if   differ>=1 && differ<=3 
        if dbp==15 % if there is 3 bits overflow and the last pixel bitplanes number is 4 then the overflow bits will not affect and they will be ignored 
             break;
        end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
        pixNumNeeded = findPixNumNeeded(lastCMeta,differ);
        if pixNumNeeded>lastCMeta(end)
			C(end) = [];
        else
            lastCMeta(end) = lastCMeta(end) - pixNumNeeded;
            try
            C{end} = lastCMeta;
            catch
                disp('error');
            end
        end
        numberOfBits = computeNumberOfSecretBits(C);
    end
end
% generate the remained part of D
if remainedDLength>0
Bratio = 1 - crossRatio;
BmetasNum = ceil(Bratio * remainedDLength);
BmetasInds = randperm(length(newB),BmetasNum);
try
Bmetas = newB{BmetasInds};
catch
    disp('rrr');
end
D = [D Bmetas];
newB2 = newB;
newA2 = newA;
newB2(BmetasInds) = [];
end
numberOfBits = computeNumberOfSecretBits(D);
while numberOfBits~=trueBitsNum
    if trueBitsNum>numberOfBits
        differ = trueBitsNum - numberOfBits;
        
if ~isempty(newA2)
            metaAInd = randi(length(newA2));
            metaA = newA2{metaAInd};
            pixNumNeeded = findPixNumNeeded(metaA,differ);
            blockSize = findBlockSize(metaA(1),metaA(2));
            pixThresh = blockSize(1)*blockSize(2);
            if pixNumNeeded>pixThresh
                pixNumNeeded = pixThresh;
            end
            metaA(end) = pixNumNeeded;
            D = [D metaA];
            newA2(metaAInd) = [];
            numberOfBits = computeNumberOfSecretBits(D);
        else % if isempty(newA2)
            if isempty(newB2)
                disp('What !!!');
            end
            metaBInd = randi(length(newB2));
            metaB = newB2{metaBInd};
            pixNumNeeded = findPixNumNeeded(metaB,differ);
            blockSize = findBlockSize(metaB(1),metaB(2));
            pixThresh = blockSize(1)*blockSize(2);
            if pixNumNeeded>pixThresh
                pixNumNeeded = pixThresh;
            end
            metaB(end) = pixNumNeeded;
            D = [D metaB];
            newB2(metaBInd) = [];
            numberOfBits = computeNumberOfSecretBits(D);
        end
    else % if numberOfBits>trueBitsNum
        differ = numberOfBits - trueBitsNum;
        lastDMeta = D{end};
        dbp = D{end}(6);
%%%%%%%%%%%%%%%%%%%%%%%%%
if differ==1
        if ismember(dbp,[3,5,6,9,10,12]) % if there is one bit overflow and the last pixel bitplanes number is 2 then the overflow bit will not affect and it will be ignored 
            break;
        end
end
    if  differ>=1 && differ<=2 
        if ismember(dbp,[7,11,13,14]) % if there is 2 bits overflow and the last pixel bitplanes number is 3 then the overflow bits will not affect and they will be ignored 
             break;
        end
    end
if   differ>=1 && differ<=3 
        if dbp==15 % if there is 3 bits overflow and the last pixel bitplanes number is 4 then the overflow bits will not affect and they will be ignored 
             break;
        end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        pixNumNeeded = findPixNumNeeded(lastDMeta,differ);
        if pixNumNeeded>lastDMeta(end)
			D(end) = [];
        else
            lastDMeta(end) = lastDMeta(end) - pixNumNeeded;
            try
            D{end} = lastDMeta;
            catch
                disp('err');
            end
        end
        numberOfBits = computeNumberOfSecretBits(D);
    end
end

child1.chrom = C;
child2.chrom = D;
end
        