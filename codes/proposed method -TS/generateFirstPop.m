function [pop,tmp] = generateFirstPop(Ihd,Is,QL,T_nbc,popSize)
binMessage = Is;
keyArr = [0 0 0 0 1 -1 1 -1 0 0 0 0 1 1 -1 -1];
for ci = 1:popSize
    ci
    chrom = [];
    oldBlockInds = []; % to prevent blocks re-using
    %% generate random block and pixel directions
    p_dir = randi(16)-1; % 16 directions
    key = keyArr(p_dir + 1);
    %% read the size of host image
    [m,n] = size(Ihd);
    %% Decompose the image into blocks based on size and QL
    nb = ceil(n/ QL); % blocks along the coloumns
    mb = ceil(m/ QL); % blocks along the rows
    %% generate Random Block between 1 and nb, 1 and mb and assign it to the current location...
    %% and random values for, SB-Pole, SB-Dire , BP-Dire, Bit-Planes.
    currBlockCol = randi(nb);
    currBlockRow = randi(mb);
    blockSize = findBlockSize(currBlockRow,currBlockCol);
    pixThresh = blockSize(1)*blockSize(2);
    blockInd = sub2ind([mb,nb],currBlockRow,currBlockCol);
    oldBlockInds = [oldBlockInds blockInd];
    SB_Pol = randi(2)-1; % pole of secret bits
    SB_Dir = randi(2)-1; % direction of secret bits
    BP_Dir = randi(2)-1; % direction of bit plane
    Bit_Planes = 3;%randi(15);
    %% generat first part of chromosome
    nbc = 0; % number of bit changes
    secretMesgCont = 1; % counter of message bits
    tmpStegno = Ihd;
    newCounter = 1; % counter of reversed message bits
    isStillAvailable = 1; % if the current pixel still available
    thisBitInd = []; % bit index inside this pixel
    isInserted = 0; % is the current secret bit inserted in the current pixel
    numUsedBlocks = 1; 
    pixelInd = []; % current pixel index
    loopCont = 0; 
    pixNum = 1; % pixel number
    tmp=[];
    while secretMesgCont <= length(binMessage)    
        %         secretMesgCont = secretMesgCont + 1;
        loopCont = loopCont+1;
        if ((nbc<T_nbc) || (isStillAvailable==1)) &&  pixNum<=pixThresh
            % insert one bit in current location using (SB-Pole, SB-Dire ,BP-Dire, Bit-Planes)
            % update the value of nbc and used blocks
            if loopCont==1
                % determine the current pixel
                [pixelInd blockSize offset] = determineCurrentPixelInd(Ihd,mb,nb,p_dir,...
                    currBlockCol,currBlockRow,QL,pixelInd);
               pixThresh = blockSize(1)* blockSize(2);
                chrom{1} = [currBlockRow currBlockCol  BP_Dir SB_Dir SB_Pol Bit_Planes p_dir offset,pixNum];
                % get this pixel and convert it to binary
                pixel = tmpStegno(pixelInd(1),pixelInd(2));
                binPixel = dec2bin(pixel,8);
                newPixel = binPixel;
                % get the needed bits from the message
                binBitPlanes = dec2bin(Bit_Planes,8);
                numBits = length(find(binBitPlanes=='1'));
                try
                    thisPixMessageBits = binMessage(secretMesgCont:secretMesgCont+numBits-1);
                catch
                    thisPixMessageBits = binMessage(secretMesgCont:end);
                end
                if SB_Dir==1
                    thisPixMessageBits = thisPixMessageBits(end:-1:1);
                end
                thisBitCont = 1; % bit counter of the current pixel
            end
            % inserting one bit
            bitToInsert = thisPixMessageBits(thisBitCont);
            [newPixel,isInserted,isStillAvailable,thisBitInd,oldBit] =...
                insertOneBit(bitToInsert,thisBitInd,Bit_Planes,BP_Dir,SB_Pol,newPixel);
            if isInserted
                secretMesgCont = secretMesgCont + 1;
                thisBitCont = thisBitCont + 1;
            end
            % updating nbc
            if oldBit~=bitToInsert
                nbc = nbc+1;
            end
%             binPixel(find(dec2bin(Bit_Planes,8)=='1')) = newPixel(find(dec2bin(Bit_Planes,8)=='1'));
            
            if isStillAvailable==0 && secretMesgCont<=length(binMessage)
                            tmpStegno(pixelInd(1),pixelInd(2)) = bin2dec(newPixel);
                [pixelInd(1) pixelInd(2),key] = determineNextPixel(pixelInd(1),pixelInd(2),p_dir,blockSize(1),blockSize(2),currBlockCol,currBlockRow,QL,key);
                isStillAvailable = 1;
                isInserted = 0;
                thisBitInd = [];
                if nbc<T_nbc &&  pixNum<pixThresh        
                pixNum = pixNum+1; % increment the number of pixels
                chrom{numUsedBlocks}(end) = pixNum; 
                else
                    isStillAvailable = 0;
                  chrom{numUsedBlocks}(end) = pixNum; 
                end
                %                 try
                pixel = Ihd(pixelInd(1),pixelInd(2));
                binPixel = dec2bin(pixel,8);
                newPixel = binPixel;
                binBitPlanes = dec2bin(Bit_Planes,8);
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
            end
            %% generate the others parts
        else % if nbc>=T_nbc
            % generate Random Block between 1 and nb, 1 and mb and assign it to current location
            % and random values for, SB-Pole, SB-Dire , BP-Dire, Bit-Planes and assign them to new part of chromosome
            % determine the next block using b_dir
            %             newCounter = 1;
           pixNum = 1;
            pixelInd = [];
            thisBitInd = [];
            newBlockInd = randi(mb*nb);
            while ismember(newBlockInd,oldBlockInds)
                newBlockInd = randi(mb*nb); % determin new block index
            end
            oldBlockInds = [oldBlockInds newBlockInd];
            [newBlockInd(1) newBlockInd(2)]  = ind2sub([mb,nb],newBlockInd); 
            
            % generating SB-Pole, SB-Dire , BP-Dire, Bit-Planes
            SB_Pol = randi(2)-1; % pole of secret bits
            SB_Dir = randi(2)-1; % direction of secret bits
            BP_Dir = randi(2)-1; % direction of bit plane
            Bit_Planes = 3;%randi(15);
            p_dir = randi(16)-1;
            key = keyArr(p_dir+1);
            [pixelInd blockSize offset] = determineCurrentPixelInd(Ihd,mb,nb,p_dir,newBlockInd(2),newBlockInd(1),QL,pixelInd);
           isStillAvailable = 1;
            currBlockRow  = newBlockInd(1);
            currBlockCol = newBlockInd(2);
            numUsedBlocks = numUsedBlocks + 1;
            chrom{numUsedBlocks} = [newBlockInd(1) newBlockInd(2) BP_Dir SB_Dir SB_Pol Bit_Planes p_dir offset pixNum];
            nbc = 0;
    pixThresh = blockSize(1)*blockSize(2);
            pixel = tmpStegno(pixelInd(1),pixelInd(2));
        
            binPixel = dec2bin(pixel,8);
            newPixel = binPixel;
            %             secretMesgCont = secretMesgCont-1;
            binBitPlanes = dec2bin(Bit_Planes,8);
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
        end
    end
    pop.chrom{ci} = chrom;
    pop.stegno{ci} = tmpStegno;
%     pop.stegnoMat{ci} = cell2mat(tmpStegno);
end
% profview;