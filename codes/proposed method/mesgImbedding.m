function [stegno,fit] = mesgImbedding(chrom,Ih,QL,message)
binMessage = message;
messPixelSeqTotal = [];
stegno = Ih;
%%%%%%%%%%%%%%
numberOfBlocks = length(chrom);
secretCounter = 1;
 nb = ceil(size(stegno,2)/QL);
    mb = ceil(size(stegno,1)/QL);
 % get the length of the message
 numberOfBits = computeNumberOfSecretBits(chrom);
 while rem(numberOfBits,8)~=0
     numberOfBits = numberOfBits - 1;
 end
 %%%%%%%%%%%%%%%%%%%%%
 if iscell(chrom)
     ssss = 1:length(chrom);
 else
     ssss = 1;
 end
for b=ssss
    try
    meta = chrom{b};
    catch
        meta = chrom;
    end
    % extract chromosome genes
    blockRow = meta(1);
    blockCol = meta(2);
    bitPlaneDir = meta(3);
    secretBitDir = meta(4);
    secretBitPole = meta(5);
    bitPlanes = mappingBitPlanes(meta(6));
    pixelDir = meta(7);
    rowOffset = meta(8);
    colOffset = meta(9);
    numOfPixels = meta(10);
    %%%%%%%%%%%%%%%%%
    % get the first pixel index
    pixelRow = (blockRow-1) * QL + 1;
    pixelCol = (blockCol-1) * QL + 1;
    % get the pixels sequence
    
      blockCols = [];
    if blockCol==nb
        blockCols = pixelCol:size(stegno,2);
    else
        blockCols = pixelCol:(pixelCol+QL-1);
    end
    blockRows = [];
    if blockRow==mb
        blockRows = pixelRow:size(stegno,1);
    else
        blockRows = pixelRow:(pixelRow+QL-1);
    end    
    blockSize = [length(blockRows) length(blockCols)];
    messPixelSeq = CreateHostPixelSeq(blockSize,pixelCol,pixelRow,colOffset...
        ,rowOffset,pixelDir,numOfPixels,Ih);
    for pix = 1:numOfPixels
        [pixRowInd,pixColInd] = ind2sub(size(Ih),messPixelSeq(pix));
        pixel = stegno(pixRowInd,pixColInd);
        pixel = dec2bin(pixel,8);
         % get the secret bits
    binBitPlanes = dec2bin(bitPlanes,8);
    secretBitsInds = find(binBitPlanes=='1');
%     if secretCounter==10480
%         disp('dz');
%     end
    if bitPlaneDir==1
        if length(secretBitsInds) > length(secretCounter:numberOfBits)
        secretBitsInds = secretBitsInds(end:-1:end-length(secretCounter:numberOfBits)+1);
        else
        secretBitsInds = secretBitsInds(end:-1:1);
        end
    else
         if length(secretBitsInds) > length(secretCounter:length(binMessage)) 
            notNedded =  length(secretBitsInds) - length(secretCounter:length(binMessage));
        secretBitsInds = secretBitsInds(1:end-notNedded);
        else
        secretBitsInds = secretBitsInds;
        end
    end
    
    try
    secretBits =  binMessage(secretCounter:secretCounter+...
        length(secretBitsInds)-1);
    catch
        disp('err');
    end
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
    try
    pixel(secretBitsInds) = secretBits;
    catch
        disp('yeeeeeeeee');
    end
    secretCounter = secretCounter + length(secretBits);
    stegno(pixRowInd,pixColInd) = bin2dec(pixel);
    end
    messPixelSeqTotal = [messPixelSeqTotal messPixelSeq];
    
end
[~,MSE] = measerr(uint8(Ih),uint8(stegno));
% MSE = mse(uint8(Ih),uint8(stegno));
fit = -MSE;
end