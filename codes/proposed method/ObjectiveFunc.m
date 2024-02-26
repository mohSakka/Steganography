function fitVal=ObjectiveFunc(individual,Ih,QL)
stegno = individual.stegno;
Is = stegno;
chrom = individual.chrom;
nb = ceil(size(stegno,2)/QL);
    mb = ceil(size(stegno,1)/QL);
    messPixelSeqTotal = [];
% for i = 1:size(s,1)
% for j=1:size(s,2)
% s2(i,j) = myBin2Dec(s{i,j});
% end
% end
for b = 1:length(chrom)
   meta = chrom{b};
blockRow = meta(1);
blockCol = meta(2);
% determine the first pixel that contains the secret bits
    pixelRow = (blockRow - 1) * QL + 1;
    pixelCol = (blockCol - 1) * QL + 1;
    blockCols = [];
    if blockCol==nb
        blockCols = pixelCol:size(Is,2);
    else
        blockCols = pixelCol:(pixelCol+QL-1);
    end
    blockRows = [];
    if blockRow==mb
        blockRows = pixelRow:size(Is,1);
    else
        blockRows = pixelRow:(pixelRow+QL-1);
    end    
    blockSize = [length(blockRows) length(blockCols)];
    rowOffset = meta(8);
    colOffset = meta(9);
    pixelDir = meta(7);
    numOfPixels = meta(10);
messPixelSeq = CreateHostPixelSeq(blockSize,pixelCol,pixelRow,colOffset...
        ,rowOffset,pixelDir,numOfPixels,stegno);
messPixelSeqTotal = [messPixelSeqTotal messPixelSeq];
end
[~,MSE] = measerr(uint8(Ih),uint8(stegno));
% MSE = mse(uint8(Ih),uint8(stegno));

fitVal= - MSE;


