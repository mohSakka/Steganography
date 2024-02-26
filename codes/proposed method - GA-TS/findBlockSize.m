function blockSize = findBlockSize(currBlockRow,currBlockCol,Ih,QL)
imSize = size(Ih);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nb = ceil(imSize(1)/QL);
mb = ceil(imSize(2)/QL);
currPixelCol = (currBlockCol-1) * QL + 1;
currPixelRow = (currBlockRow-1) * QL + 1;
blockCols = [];
if currBlockCol==nb
    blockCols = currPixelCol:size(Ih,2);
else
    blockCols = currPixelCol:(currPixelCol+QL-1);
end
blockRows = [];
if currBlockRow==mb
    blockRows = currPixelRow:size(Ih,1);
else
    blockRows = currPixelRow:(currPixelRow+QL-1);
end


blockSize = [length(blockRows) length(blockCols)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end