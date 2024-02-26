function [child1,child2] = crossoverFinal(E1,E2,trueBitsNum,Ih,QL) 
A = E1.chrom;
B = E2.chrom;
[commonA commonB] = findAandBintersection(A,B,Ih,QL);
if any(commonA) 
[subCommA subCommB] = classify2(A(commonA),B(commonB),Ih,QL);
subShared = [subCommA subCommB];
else
    subShared =[];
end
notSharedA = ~commonA;
notSharedB = ~commonB;
Z = [E1.chrom(notSharedA) E2.chrom(notSharedB)];
% generate C chromosome
C = [];
fakeBitsNum = 0;
notShared = Z;
if ~isempty(notShared) 
while fakeBitsNum<trueBitsNum
    try
    randMetaInd = randi(length(notShared));
    catch
        break;
    end
    meta = notShared(randMetaInd);
    notShared(randMetaInd) = [];
    C = [C meta];
    fakeBitsNum = computeNumberOfSecretBits(C);
    
    if isempty(notShared);
        break;
    end
end
end
shared1 = subShared;
if ~isempty(shared1)
while fakeBitsNum<trueBitsNum
    try
    randMetaInd = randi(size(shared1,1));
    catch
        disp('fdasfs');
    end
    r = randi(2);
    meta = shared1(randMetaInd,r);
    shared1(randMetaInd,:) = [];
    C = [C meta];
    fakeBitsNum = computeNumberOfSecretBits(C);
    if isempty(shared1)
        break;
    end
end
end

while fakeBitsNum~=trueBitsNum
    if fakeBitsNum>trueBitsNum
    differ = fakeBitsNum - trueBitsNum;
    if iscell(C)
    lastCMeta = C{end};
    else 
        lastCMeta = C;
    end
        
    dbp = mappingBitPlanes(lastCMeta(6));
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
    if pixNumNeeded>=lastCMeta(end)
        C(end) = [];
    else
        lastCMeta(end) = lastCMeta(end) - pixNumNeeded;
        try
            if iscell(C)
            C{end} = lastCMeta;
            else
                C = lastCMeta;
            end
                
        catch
            disp('error');
        end
    end
    fakeBitsNum = computeNumberOfSecretBits(C);
    else % if trueBitsNum>numberOfBits
        differ = trueBitsNum-fakeBitsNum;
        if iscell(C)  
        bitsNeededFromEachBlock = differ/length(C);
        else
            bitsNeededFromEachBlock = differ;
        end
            
        if bitsNeededFromEachBlock<1
%             numberOfBlocksToSelect = extractNumberOfBlocks(bitsNeededFromEachBlock);
            blocks = randi(length(C));
            bitsNeededFromEachBlock = differ;
%             bitsNeededFromEachBlock = differ/length(blocks); 
%             bitsNeededFromEachBlock = ceil(bitsNeededFromEachBlock);
        else
            bitsNeededFromEachBlock = ceil(bitsNeededFromEachBlock);
            if iscell(C)
            blocks = 1:length(C);
            else
                blocks = 1;
            end
                
        end
           for b = blocks
               if iscell(C)
            blockSize = findBlockSize(C{b}(1),C{b}(2),Ih,QL);
               else
                    blockSize = findBlockSize(C(1),C(2),Ih,QL);
               end
            pixThresh = blockSize(1)*blockSize(2);
            if iscell(C)
            pixNumNeeded = findPixNumNeeded(C{b},bitsNeededFromEachBlock);
            C{b}(end) = C{b}(end) + pixNumNeeded;
            if C{b}(end)>pixThresh
                C{b}(end) = pixThresh;
            end
            else
              pixNumNeeded = findPixNumNeeded(C,bitsNeededFromEachBlock);
            C(end) = C(end) + pixNumNeeded;
            if C(end)>pixThresh
                C(end) = pixThresh;
            end  
            end
           end
               fakeBitsNum = computeNumberOfSecretBits(C);
    end
end
% generate D chromosome
D = [];
fakeBitsNum = 0;
notShared = Z;
if ~isempty(notShared)
while fakeBitsNum<trueBitsNum
    try
    randMetaInd = randi(length(notShared));
    catch
        disp('ddxsf');
    end
    meta = notShared(randMetaInd);
    notShared(randMetaInd) = [];
    D = [D meta];
    fakeBitsNum = computeNumberOfSecretBits(D);
    
    if isempty(notShared);
        break;
    end
end
end
shared1 = subShared;
if ~isempty(shared1)
while fakeBitsNum<trueBitsNum
    try
    randMetaInd = randi(size(shared1,1));
    catch
        disp('fsdf');
    end
    r = randi(2);
    meta = shared1(randMetaInd,r);
    shared1(randMetaInd,:) = [];
    D = [D meta];
    fakeBitsNum = computeNumberOfSecretBits(D);
    if isempty(shared1)
        break;
    end
end
end
while fakeBitsNum~=trueBitsNum
    if fakeBitsNum>trueBitsNum
    differ = fakeBitsNum - trueBitsNum;
    if iscell(D)
    lastCMeta = D{end};
    else
        lastCMeta = D;
    end
        
    dbp = mappingBitPlanes(lastCMeta(6));
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
    if pixNumNeeded>=lastCMeta(end)
        D(end) = [];
    else
        lastCMeta(end) = lastCMeta(end) - pixNumNeeded;
        try
            if iscell(D)
            D{end} = lastCMeta;
            else
                D = lastCMeta;
            end
        catch
            disp('error');
        end
    end
    fakeBitsNum = computeNumberOfSecretBits(D);
    else % if trueBitsNum>numberOfBits
        differ = trueBitsNum-fakeBitsNum;
        if iscell(D)
        bitsNeededFromEachBlock = differ/length(D);
        else
            bitsNeededFromEachBlock = differ;
        end
            
        if bitsNeededFromEachBlock<1
            numberOfBlocksToSelect = extractNumberOfBlocks(bitsNeededFromEachBlock);
            blocks = randperm(length(D),numberOfBlocksToSelect);
            bitsNeededFromEachBlock = differ/length(blocks); 
            bitsNeededFromEachBlock = ceil(bitsNeededFromEachBlock);
        else
            bitsNeededFromEachBlock = ceil(bitsNeededFromEachBlock);
            if iscell(D)
            blocks = 1:length(D);
            else
                blocks = 1;
            end
        end
           for b = blocks
               if iscell(D)
            blockSize = findBlockSize(D{b}(1),D{b}(2),Ih,QL);
            pixThresh = blockSize(1)*blockSize(2);
            pixNumNeeded = findPixNumNeeded(D{b},bitsNeededFromEachBlock);
            D{b}(end) = D{b}(end) + pixNumNeeded;
            if D{b}(end)>pixThresh
                D{b}(end) = pixThresh;
            end
               else
                 blockSize = findBlockSize(D(1),D(2),Ih,QL);
            pixThresh = blockSize(1)*blockSize(2);
            pixNumNeeded = findPixNumNeeded(D,bitsNeededFromEachBlock);
            D(end) = D(end) + pixNumNeeded;
            if D(end)>pixThresh
                D(end) = pixThresh;
            end  
           end
               fakeBitsNum = computeNumberOfSecretBits(D);
    end
    end
end
    if ~(iscell(C) || iscell(D))
        disp('err');
    end
child1.chrom = C;
child2.chrom = D;
end