function numberOfBits = computeNumberOfSecretBits(chrom)
numberOfBits = 0;
if iscell(chrom)
    L = length(chrom);
else
    L = 1;
end
for m = 1:L
    if length(chrom)~=1 && iscell(chrom)
         meta =  cell2mat(chrom(m));
    elseif iscell(chrom)
        meta = chrom{m};
    else
        meta = chrom;
    end

    bitPlanes = mappingBitPlanes(meta(6));
    bitPlanes = dec2bin(bitPlanes,8);
    bitsNum = length(find(bitPlanes=='1'));
    numberOfPixel = meta(end);
    numberOfBits = numberOfBits + (bitsNum*numberOfPixel);
end
end