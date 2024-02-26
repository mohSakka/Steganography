function [pixelInd blockSize offset] = determineCurrentPixelInd(Ih,mb,nb,p_dir,...
    currBlockCol,currBlockRow,QL,pixelInd)
% get the current block size
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
    if isempty(pixelInd)
 % generate random offset
 xOff = randi(length(blockCols))-1;
 yOff = randi(length(blockRows))-1;
    end
 % determine the current pixel index
 currPixelX = currPixelCol + xOff;
 currPixelY = currPixelRow + yOff;
 pixelInd = [currPixelY currPixelX];
 offset = [yOff xOff];
    end
 