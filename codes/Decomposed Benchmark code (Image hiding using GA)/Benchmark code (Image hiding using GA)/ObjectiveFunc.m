function fitVal=ObjectiveFunc(chrom,forbiddenAreas,oldChromPixels)

% Global variable
global imCover 

% Chromosome parts
direction=chrom(1);
xOff=chrom(2);
yOff=chrom(3);
bitPlanes= mappingBitPlanes(chrom(4));
bitPlanes=dec2bin(bitPlanes,4);numOfUsedBits=length(find(bitPlanes=='1'));
sbPole=chrom(5);
sbDir=chrom(6);
bpDir=chrom(7);

% Message bit sequence
reqBitSeq=ChooseRightSecretSeq(sbPole,sbDir);
messageLength=length(reqBitSeq(:));    % 27 is the length of chromosome
% Chrom bit sequence
chromBitSeq=ConvertChromToBitSeq(chrom);
chromLength=length(chromBitSeq);

[messReq,chromReq,status]=DetermineRequiredNumberOfPixels(messageLength,chromLength,numOfUsedBits,length(imCover(:)));
if ~status
    fitVal=0;
    return;
end

[messPixelSeq,chromPixelSeq]=CreateHostPixelSeq...
    (oldChromPixels,xOff,yOff,direction,messReq,chromReq);

if any(ismember(messPixelSeq,forbiddenAreas))
    MSE = inf;
else
    stego=EmbeddingTheMessage(reqBitSeq,chromBitSeq,...
        bitPlanes,bpDir,imCover,messPixelSeq,chromPixelSeq);

[~,MSE] = measerr(uint8(imCover),uint8(stego));
% MSE = mse(uint8(imCover),uint8(stego));
end
fitVal=MSE;

end