function [binaryMessage,message] = extractMessage1(individual,QL)
chrom = individual.chrom;
Is = individual.stegno;
numberOfBlocks = length(chrom);
secretCounter = 1;
 nb = ceil(size(Is,2)/QL);
    mb = ceil(size(Is,1)/QL);
 % get the length of the message
 numberOfBits = zeros(1,numberOfBlocks);
 for b = 1:numberOfBlocks
     meta = chrom{b};
     bitPlanes = meta(6);
     bitPlanes = dec2bin(bitPlanes,8);
     numBitPlanes = length(find(bitPlanes=='1'));
      numOfPixels = meta(10);
      numberOfBits(b) = numOfPixels * numBitPlanes;  
 end
 numberOfBits = sum(numberOfBits);
 while rem(numberOfBits,8)~=0
     numberOfBits = numberOfBits - 1;
 end
     
for b = 1:numberOfBlocks
    meta = chrom{b};
    
    % extract chromosome genes
    blockRow = meta(1);
    blockCol = meta(2);
    bitPlaneDir = meta(3);
    secretBitDir = meta(4);
    secretBitPole = meta(5);
    bitPlanes = meta(6);
    pixelDir = meta(7);
    rowOffset = meta(8);
    colOffset = meta(9);
    numOfPixels = meta(10);
    %%%%%%%%%%%%%%%%%
    
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
    messPixelSeq = CreateHostPixelSeq(blockSize,pixelCol,pixelRow,colOffset...
        ,rowOffset,pixelDir,numOfPixels,Is);
    for pix = 1:numOfPixels
        [pixRowInd,pixColInd] = ind2sub(size(Is),messPixelSeq(pix));
    stegnoPixel = Is{pixRowInd,pixColInd};
%     stegnoPixel = dec2bin(stegnoPixel,8);
    % get the secret bits
    binBitPlanes = dec2bin(bitPlanes,8);
    secretBitsInds = find(binBitPlanes=='1');
    
    if bitPlaneDir==1
        if length(secretBitsInds) > length(secretCounter:numberOfBits)
        secretBitsInds = secretBitsInds(end:-1:end-length(secretCounter:numberOfBits)+1);
        else
        secretBitsInds = secretBitsInds(end:-1:1);
        end
    else
         if length(secretBitsInds) > length(secretCounter:numberOfBits)
             notNedded =  length(secretBitsInds) - length(secretCounter:numberOfBits);
        secretBitsInds = secretBitsInds(1:end-notNedded);
        else
        secretBitsInds = secretBitsInds;
        end
    end
    secretBits = stegnoPixel(secretBitsInds);
    if secretBitDir==0
        secretBits = secretBits;
    else
        secretBits = secretBits(end:-1:1);
    end
    if secretBitPole==1
        for i=1:length(secretBits)
            if secretBits(i)=='1'
                secretBits(i) = '0';
            elseif secretBits(i)=='0'
                secretBits(i) = '1';
            end
        end
    end
       binaryMessage(secretCounter:secretCounter+length(secretBits)-1) = secretBits;
       secretCounter = secretCounter + length(secretBits);
       % determine next pixel
       
    end
end
cnt = 0;
       for bt=0:8:length(binaryMessage)-8
           cnt = cnt+1;
           bm = binaryMessage(bt+1:bt+8);
           dc = bin2dec(bm);
           message(cnt) = char(dc);
       end
end
           
    
    
