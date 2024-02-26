function [numberOfNeededPixels,allPixNum] = findNumberOfNeededPixels(meta,neededBits)
meta = cell2mat(meta);
 bp = mappingBitPlanes(meta(6));
 bp = dec2bin(bp,8);
 numberOfBits = length(find(bp=='1'));
 numberOfNeededPixels = ceil(neededBits/numberOfBits);
 allPixNum = meta(end);
end