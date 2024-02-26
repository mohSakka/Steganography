 
    for sbmsg=1:numberOfSubMsgs
        try
        subMsgs{sbmsg} = subMsg(prevInd:prevInd + floor(length(subMsg)/numberOfSubMsgs));
        catch
            subMsgs{sbmsg} = subMsg(prevInd:end);
        end
        prevInd = prevInd+ceil(length(subMsg)/numberOfSubMsgs) + 1;
    end
    for ch=1:numberOfSubMsgs
    chrom = finalChrom(idx:idx+6);
    idx = idx + 7;
    oldChromPixels = [];
    % Chromosome parts
    direction=chrom(1);
    xOff=chrom(2);
    yOff=chrom(3);
    bitPlanes=mappingBitPlanes(chrom(4));bitPlanes=dec2bin(bitPlanes,4);
    numOfUsedBits=length(find(bitPlanes=='1'));
    sbPole=chrom(5);
    sbDir=chrom(6);
    bpDir=chrom(7);
    
    % Message bit sequence
    reqBitSeq=ChooseRightSecretSeq2(subMsgs{ch},sbPole,sbDir);
    messageLength=length(reqBitSeq(:));    % 27 is the length of chromosome
    % Chrom bit sequence
    chromBitSeq=ConvertChromToBitSeq(chrom);
    chromLength=length(chromBitSeq);
    
    [messReq,chromReq,status]=DetermineRequiredNumberOfPixels...
        (messageLength,chromLength,numOfUsedBits,length(imCover(:)));
    
    [messPixelSeq,chromPixelSeq]=CreateHostPixelSeq...
        (oldChromPixels,xOff,yOff,direction,messReq,chromReq);
    
    stegoBench = EmbeddingTheMessage(reqBitSeq,chromBitSeq,bitPlanes,...
        bpDir,stegoBench,messPixelSeq,chromPixelSeq);
    oldChromPixels = [oldChromPixels chromPixelSeq];
    end