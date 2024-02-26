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
remainedCLength = CLength - length(C);
while remainedCLength>0
    if numberOfBits>=trueBitsNum
        break;
    end
    if ~isempty(newB2)
        metaBInd = randi(length(newB2));
        metaB = newB2{metaBInd};
        C = [C metaB];
        newB2(metaBInd) = [];
    elseif ~isempty(newA2)
        metaAInd = randi(length(newA2));
        metaA = newA2{metaAInd};
        C = [C metaA];
        newA2(metaAInd) = [];
    else
        disp('empty A and B !!');
        
    end
    remainedCLength = CLength - length(C);
    numberOfBits = computeNumberOfSecretBits(C);
end
%%%%
numberOfBits = computeNumberOfSecretBits(C);
while numberOfBits~=trueBitsNum
    if numberOfBits>trueBitsNum
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
    else % if trueBitsNum>numberOfBits
        differ = trueBitsNum-numberOfBits;
        bitsNeededFromEachBlock = differ/length(C);
        if bitsNeededFromEachBlock<1
            numberOfBlocksToSelect = extractNumberOfBlocks(bitsNeededFromEachBlock);
            blocks = randperm(length(C),numberOfBlocksToSelect);
            bitsNeededFromEachBlock = differ/length(blocks); 
            bitsNeededFromEachBlock = ceil(bitsNeededFromEachBlock);
        else
            bitsNeededFromEachBlock = ceil(bitsNeededFromEachBlock);
            blocks = 1:length(C);
        end
           for b = blocks
            blockSize = findBlockSize(C{b}(1),C{b}(2));
            pixThresh = blockSize(1)*blockSize(2);
            pixNumNeeded = findPixNumNeeded(C{b},bitsNeededFromEachBlock);
            C{b}(end) = C{b}(end) + pixNumNeeded;
            if C{b}(end)>pixThresh
                C{b}(end) = pixThresh;
            end
           end
               numberOfBits = computeNumberOfSecretBits(C);
    end
end

