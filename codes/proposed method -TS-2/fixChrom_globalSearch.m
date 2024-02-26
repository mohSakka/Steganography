function child = fixChrom_globalSearch(child,trueMesgBitsNum,QL,imSize,Ih,binMessage,T_nbc)
% find number of blocks in rows and cols
[m,n] = size(Ih);
nb = ceil(n/ QL); % blocks along the coloumns
mb = ceil(m/ QL); % blocks along the rows
keyArr = [0 0 0 0 1 -1 1 -1 0 0 0 0 1 1 -1 -1];
%%
for m = 1:length(child)
    meta = child{m};
    numberOfPixels = meta(end);
    bitPlanes = mappingBitPlanes(meta(6));
    binBitPlanes = dec2bin(bitPlanes,8);
    numberOfbitPlanesBits = length(find(binBitPlanes=='1'));
    numberOfBits(m) = numberOfPixels*numberOfbitPlanesBits;
    numberOfPixels2(m) = numberOfPixels;
end
%%
fakeMesgBitsNum = sum(numberOfBits);
% extract block indices
blockInds = [];
for m=1:length(child)
    meta = child{m};
    blockSubInds = meta(1:2);
    blockInd = sub2ind([mb,nb],blockSubInds(1),blockSubInds(2));
    blockInds = [blockInds blockInd];
end
%%
% start fixing
if fakeMesgBitsNum~=trueMesgBitsNum
if fakeMesgBitsNum<trueMesgBitsNum
    secretMesgCont = fakeMesgBitsNum;
    %% metameric loop (block loop)
    while fakeMesgBitsNum~=trueMesgBitsNum
        %% create new metameric
        
        meta=[];
        % generate new block index
        newBlockInd = randi(mb*nb);
        while ismember(newBlockInd,blockInds)
            newBlockInd = randi(mb*nb);
        end
        % add the new block index to the blockInds list
        blockInds = [blockInds newBlockInd];
        nbc=0; % no bit changed yet
        isStillAvailable = 1; % for pixel
        pixNum = 1; % still one pixel used
        % find block row an coloumn
        [blockRow,blockCol] = ind2sub([mb,nb],newBlockInd);
        blockSize = findBlockSize(blockRow,blockCol,Ih,QL);
        pixThresh= blockSize(1) * blockSize(2); % find number of pixels in the block
        % assigne first 2 variables in the new meta
        meta(1:2) = [blockRow,blockCol];
        % now generate new decision variables
        SB_Pol = randi(2)-1; % pole of secret bits
        SB_Dir = randi(2)-1; % direction of secret bits
        BP_Dir = randi(2)-1; % direction of bit plane
        Bit_Planes = randi(15);
        p_dir = randi(16)-1; % 16 directions
        key = keyArr(p_dir + 1);
        % initial conditions
        pixelInd = [];
        thisBitInd = [];
        %%%%%%%%%
        [pixelInd blockSize offset] = determineCurrentPixelInd(Ih,mb,nb,p_dir,...
            blockCol,blockRow,QL,pixelInd);
        meta = [blockRow blockCol  BP_Dir SB_Dir SB_Pol Bit_Planes p_dir offset pixNum];
        % get this pixel and convert it to binary
        pixel = Ih(pixelInd(1),pixelInd(2));
        binPixel = dec2bin(pixel,8);
        newPixel = binPixel;
        % get the needed bits from the message
        binBitPlanes = dec2bin(mappingBitPlanes(Bit_Planes),8);
        numBits = length(find(binBitPlanes=='1'));
        try
            thisPixMessageBits = binMessage(secretMesgCont:secretMesgCont+numBits-1);
        catch
            thisPixMessageBits = binMessage(secretMesgCont:end);
        end
        if SB_Dir==1
            thisPixMessageBits = thisPixMessageBits(end:-1:1);
        end
        thisBitCont = 1; % within the current pixel
        %% pixel loop
        while ((nbc<T_nbc) || (isStillAvailable==1)) && pixNum<=pixThresh
            % insert one bit in current location using (SB-Pole, SB-Dire ,BP-Dire, Bit-Planes)
            % update the value of nbc and used blocks
            %% bit loop
            % inserting one bit
            bitToInsert = thisPixMessageBits(thisBitCont);
            [newPixel,isInserted,isStillAvailable,thisBitInd,oldBit] =...
                insertOneBit(bitToInsert,thisBitInd,mappingBitPlanes(Bit_Planes),BP_Dir,SB_Pol,newPixel);
            if isInserted
                secretMesgCont = secretMesgCont + 1;
                fakeMesgBitsNum = fakeMesgBitsNum + 1;
                if fakeMesgBitsNum==trueMesgBitsNum
                    break;
                end
                %                 clc;
                %                 disp(secretMesgCont);
                thisBitCont = thisBitCont + 1;
            end
            % updating nbc
            if oldBit~=bitToInsert
                nbc = nbc+1;
            end
            %% travel to new pixel
            if isStillAvailable==0 && secretMesgCont<=length(binMessage)
                %                 tmpPix = newPixel(end-3:end);
                % tmp = [tmp newPixel(find(dec2bin(mappingBitPlanes(Bit_Planes),8)=='1'))];
                
                [pixelInd(1) pixelInd(2),key] = determineNextPixel(pixelInd(1),pixelInd(2),p_dir,blockSize(1),blockSize(2),blockCol,blockRow,QL,key);
                isStillAvailable = 1;
                isInserted = 0;
                thisBitInd = [];
                if nbc<T_nbc  && pixNum<pixThresh
                    pixNum = pixNum + 1;
                    meta(end) = pixNum;
                    pixel = Ih(pixelInd(1),pixelInd(2));
                    binPixel = dec2bin(pixel,8);
                    newPixel = binPixel;
                    binBitPlanes = dec2bin(mappingBitPlanes(Bit_Planes),8);
                    numBits = length(find(binBitPlanes=='1'));
                    try
                        thisPixMessageBits = binMessage(secretMesgCont:secretMesgCont+numBits-1);
                    catch
                        thisPixMessageBits = binMessage(secretMesgCont:end);
                    end
                    if SB_Dir==1
                        thisPixMessageBits = thisPixMessageBits(end:-1:1);
                    end
                    thisBitCont = 1;
                else
                    %                     if pixNum>=pixThresh
                    %                         disp('fcsf');
                    %                     end
                    isStillAvailable = 0;
                    nbc = T_nbc;
                    child{end+1} = meta;
                end
                
            end
        end
    end
elseif fakeMesgBitsNum>trueMesgBitsNum
     while fakeMesgBitsNum~=trueMesgBitsNum
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
    %%
   
 difference = fakeMesgBitsNum-trueMesgBitsNum;
    maxPxInd = randi(length(child));
% [~,maxPxInd] =  max(numberOfPixels2);
    meta = child{maxPxInd};
try
      dbp = mappingBitPlanes(meta(6));
catch
    disp('err');
end
    bitPlanes = mappingBitPlanes(meta(6));
    bitPlanes = dec2bin(bitPlanes,8);
    lenOfbP = length(find(bitPlanes=='1'));
    numberOfNeededPixels = ceil(difference/lenOfbP);
    newPixNum = meta(end) - numberOfNeededPixels;
    if newPixNum<1
        child{maxPxInd} = [];
        fakeMesgBitsNum = fakeMesgBitsNum - (lenOfbP*meta(end));
    else
    meta(end) = newPixNum;
    child{maxPxInd} = meta;  
    end
    
   
end
end
end
