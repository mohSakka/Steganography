rng(seed)
options = optimoptions('ga','PlotFcns', @gaplotbestf,'Generations',50,...
    'PopulationSize',50);%,'StallGenLimit',inf);
nvar=7;
lowerBounds=[0 0 0 1 0 0 0];
higherBounds=[15 511 511 15 1 1 1];
[chrom,bestVal,flag] = ga(@ObjectiveFunc,nvar,[],[],[],[],lowerBounds,higherBounds,[],1:nvar,options);

% Chromosome parts
direction=chrom(1);
xOff=chrom(2);
yOff=chrom(3);
bitPlanes=mappingBitPlanes(chrom(4));bitPlanes=dec2bin(bitPlanes,4);numOfUsedBits=length(find(bitPlanes=='1'));
sbPole=chrom(5);
sbDir=chrom(6);
bpDir=chrom(7);

% Message bit sequence
reqBitSeq=ChooseRightSecretSeq(sbPole,sbDir);
messageLength=length(reqBitSeq(:));    % 27 is the length of chromosome
% Chrom bit sequence
chromBitSeq=ConvertChromToBitSeq(chrom);
chromLength=length(chromBitSeq);

[messReq,chromReq,status]=DetermineRequiredNumberOfPixels...
    (messageLength,chromLength,numOfUsedBits,length(imCover(:)));

[messPixelSeq,chromPixelSeq]=CreateHostPixelSeq...
    (xOff,yOff,direction,messReq,chromReq);

stego=EmbeddingTheMessage(reqBitSeq,chromBitSeq,bitPlanes,bpDir,imCover,messPixelSeq,chromPixelSeq);
