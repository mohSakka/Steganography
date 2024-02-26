% Chromosome parts
direction=chrom(1);
xOff=chrom(2);
yOff=chrom(3);
bitPlanes=mappingBitPlanes(chrom(4));
bitPlanes=dec2bin(bitPlanes,4);
numOfUsedBits=length(find(bitPlanes=='1'));
sbPole=chrom(5);
sbDir=chrom(6);
bpDir=chrom(7);

% Message bit sequence
reqBitSeq=ChooseRightSecretSeq2(msg1,sbPole,sbDir);
messageLength=length(reqBitSeq(:));    % 27 is the length of chromosome
% Chrom bit sequence
chromBitSeq=ConvertChromToBitSeq(chrom);
chromLength=length(chromBitSeq);

[messReq,chromReq,status]=DetermineRequiredNumberOfPixels...
    (messageLength,chromLength,numOfUsedBits,length(imCover(:)));

[messPixelSeq,chromPixelSeq]=CreateHostPixelSeq...
    (xOff,yOff,direction,messReq,chromReq);
% Extract the original Message
        [orgMessage]=ExtractOriginalMessage...
            (stego,chromPixelSeq,nvar,...
            messageLength,chrom);
         sbPole=chrom(5);
        sbDir=chrom(6);
        trueMessage=ConvertToTrueMessage...
            (orgMessage,sbPole,sbDir);
        
        imSecEx=reshape(trueMessage,length(msg1),8);
        imSecEx=bin2dec(imSecEx);
        imSecEx=reshape(imSecEx,1,length(msg1));