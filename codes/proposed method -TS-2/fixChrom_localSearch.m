function child = fixChrom(child,trueMesgBitsNum,QL,imSize,Ih)

for m = 1:length(child)
    meta = child{m};
    numberOfPixels = meta(end);
    bitPlanes = mappingBitPlanes(meta(6));
    binBitPlanes = dec2bin(bitPlanes,8);
    numberOfbitPlanesBits = length(find(binBitPlanes=='1'));
    numberOfBits(m) = numberOfPixels*numberOfbitPlanesBits;
    numberOfPixels2(m) = numberOfPixels;
end
fakeMesgBitsNum = sum(numberOfBits);
% start fixing
while fakeMesgBitsNum~=trueMesgBitsNum
    if fakeMesgBitsNum>trueMesgBitsNum
    difference = fakeMesgBitsNum-trueMesgBitsNum;
    maxPxInd = randi(length(child));
% [~,maxPxInd] =  max(numberOfPixels2);
    meta = child{maxPxInd};

      dbp = mappingBitPlanes(meta(6));
    bitPlanes = mappingBitPlanes(meta(6));
    bitPlanes = dec2bin(bitPlanes,8);
    lenOfbP = length(find(bitPlanes=='1'));
    numberOfNeededPixels = ceil(difference/lenOfbP);
    newPixNum = meta(end) - numberOfNeededPixels;
    if newPixNum<1
        newPixNum = 1;
    end
    meta(end) = newPixNum;
    child{maxPxInd} = meta;
    else
        difference = trueMesgBitsNum-fakeMesgBitsNum;
minPxInd = randi(length(child));
% [~,minPxInd] = (numberOfPixels2);
    meta = child{minPxInd};
    brow = meta(1);
    bcol = meta(2);
    bs = findBlockSize(brow,bcol,Ih,QL);
    thrsh = bs(1)*bs(2);
    dbp = mappingBitPlanes(meta(6));
    bitPlanes = mappingBitPlanes(meta(6));
    bitPlanes = dec2bin(bitPlanes,8);
    lenOfbP = length(find(bitPlanes=='1'));
    numberOfNeededPixels = ceil(difference/lenOfbP);
     newPixNum = meta(end) + numberOfNeededPixels;
     newPixNum(newPixNum>thrsh) = thrsh;
    meta(end) = newPixNum;
    child{minPxInd} = meta;
    end
    %%%%%%%%%%%%%%%
    for m = 1:length(child)
        meta = child{m};
        numberOfPixels = meta(end);
        bitPlanes2 = mappingBitPlanes(meta(6));
        binBitPlanes = dec2bin(bitPlanes2,8);
        numberOfbitPlanesBits = length(find(binBitPlanes=='1'));
        numberOfBits(m) = numberOfPixels*numberOfbitPlanesBits;
    numberOfPixels2(m) = numberOfPixels;
    end
    fakeMesgBitsNum = sum(numberOfBits);
    if fakeMesgBitsNum>trueMesgBitsNum
    if fakeMesgBitsNum-trueMesgBitsNum==1
        if ismember(dbp,[3,5,6,9,10,12]) % if there is one bit overflow and the last pixel bitplanes number is 2 then the overflow bit will not affect and it will be ignored 
            fakeMesgBitsNum = trueMesgBitsNum;
        end
    end
    if (fakeMesgBitsNum>trueMesgBitsNum) && (fakeMesgBitsNum-trueMesgBitsNum<=2)
        if ismember(dbp,[7,11,13,14]) % if there is 2 bits overflow and the last pixel bitplanes number is 3 then the overflow bits will not affect and they will be ignored 
            fakeMesgBitsNum = trueMesgBitsNum;
        end
    end
    if (fakeMesgBitsNum>trueMesgBitsNum) && (fakeMesgBitsNum-trueMesgBitsNum<=3)
        if dbp==15 % if there is 3 bits overflow and the last pixel bitplanes number is 4 then the overflow bits will not affect and they will be ignored 
            fakeMesgBitsNum = trueMesgBitsNum;
        end
    end
    end
end

end

