if remainedDLength >0
    Bratio = 1 - crossRatio;
    BmetasNum = ceil(Bratio * remainedDLength);
    BmetasInds = randperm(length(newB),BmetasNum);
    Bmetas = newB(BmetasInds);
    D = [D Bmetas];
    newB2 = newB;
    newB2(BmetasInds) = [];
    newA2 = newA;
end
numberOfBits = computeNumberOfSecretBits(D);
remainedDLength = DLength - length(D);
while remainedDLength>0
    if numberOfBits>=trueBitsNum
        break;
    end
    if ~isempty(newA2)
        metaAInd = randi(length(newA2));
        metaA = newA2{metaAInd};
        D = [D metaA];
        newA2(metaAInd) = [];
    elseif ~isempty(newB2)
        metaBInd = randi(length(newB2));
        metaB = newB2{metaBInd};
        D = [D metaB];
        newB2(metaBInd) = [];
    else
        disp('empty A and B !!');
        
    end
    remainedDLength = DLength - length(D);
    numberOfBits = computeNumberOfSecretBits(D);
end
%%%%
numberOfBits = computeNumberOfSecretBits(D);
while numberOfBits~=trueBitsNum
    if numberOfBits>trueBitsNum
    differ = numberOfBits - trueBitsNum;
    lastDMeta = D{end};
    dbp = lastDMeta(6);
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
            disp('error');
        end
    end
    numberOfBits = computeNumberOfSecretBits(D);
     else % if trueBitsNum>numberOfBits
        differ = trueBitsNum-numberOfBits;
        bitsNeededFromEachBlock = differ/length(D);
        if bitsNeededFromEachBlock<1
            numberOfBlocksToSelect = extractNumberOfBlocks(bitsNeededFromEachBlock);
            blocks = randperm(length(D),numberOfBlocksToSelect);
            bitsNeededFromEachBlock = differ/length(blocks); 
            bitsNeededFromEachBlock = ceil(bitsNeededFromEachBlock);
        else
            bitsNeededFromEachBlock = ceil(bitsNeededFromEachBlock);
            blocks = 1:length(D);
        end
           for b = blocks
               blockSize = findBlockSize(D{b}(1),D{b}(2));
            pixThresh = blockSize(1)*blockSize(2);
            pixNumNeeded = findPixNumNeeded(D{b},bitsNeededFromEachBlock);
            D{b}(end) = D{b}(end) + pixNumNeeded;
            if D{b}(end)>pixThresh
                D{b}(end) = pixThresh;
            end
           end
               numberOfBits = computeNumberOfSecretBits(D);
end
end
 
