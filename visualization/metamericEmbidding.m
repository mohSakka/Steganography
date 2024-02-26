global imCover;
QL = 100;
numberOfSubMsgBits = length(subMsg)*8;
numberOfRemainedBits = numberOfSubMsgBits;
isBitsTaken = 0;
chrom1 = {};
chrom1LoopIdx = 1;

while ~isBitsTaken
    try
meta = chrom{lastGaMetaIdx};
    catch
        disp('dddd');
    end
bp = meta(6);
bp = dec2bin(bp);
bp = length(find(bp=='1'));
nOfBts = meta(end)*bp;
if nOfBts==numberOfRemainedBits
    chrom1{chrom1LoopIdx} = meta;
    isBitsTaken = 1;
    numberOfRemainedBits = 0;
    break;
elseif nOfBts > numberOfRemainedBits
    chrom1{chrom1LoopIdx} = meta;
    chrom1{chrom1LoopIdx}(end) = ceil(numberOfRemainedBits/bp);
   % meta(end) = meta(end) - ceil(numberOfRemainedBits/bp);
    
   % blockSize = findBlockSize(meta(1),meta(2),imCover,QL);
%     pixelRow = (meta(1)-1) * QL + 1;
%     pixelCol = (meta(2)-1) * QL + 1;
%     
%     block = imCover(pixelRow:pixelRow+blockSize(1)-1,pixelCol:...
%         pixelCol+blockSize(2)-1);
%     messPixelSeq = CreateHostPixelSeq(blockSize,1,1,...
%         meta(9),meta(8),meta(7),meta(end),block);
%     lastPix = messPixelSeq(end);
%     [rowOffset,colOffset] = ind2sub(blockSize,lastPix);
%     
%     meta(8) = rowOffset;
%     meta(9) = colOffset;
    %prop.bestChrom.chrom{lastGaMetaIdx} = meta;
    numberOfRemainedBits = 0; 
    isBitsTaken = 1;
    break;
elseif nOfBts < numberOfRemainedBits
    chrom1{chrom1LoopIdx} = meta;
    chrom1LoopIdx = chrom1LoopIdx + 1;
    numberOfRemainedBits = numberOfRemainedBits - nOfBts;
    lastGaMetaIdx = lastGaMetaIdx + 1;
end
end


[stegno,~] = mesgImbedding(chrom1,imCover,QL,binSubMsg);
lastGaMetaIdx = 1;