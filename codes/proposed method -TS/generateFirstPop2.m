function [pop,tmp] = generateFirstPop(Ihd,Ihb,Is,QL,T_nbc,popSize)
% profile on;
binMessage = Is;
tmp=[];
% binMessage =  binMessage';
% binMessage = binMessage(:)';
keyArr = [0 0 0 0 1 -1 1 -1 0 0 0 0 1 1 -1 -1];

for ci = 1:popSize
    ci
%     if ci==3
%         disp('stop');
%     end
    chrom = [];
    oldBlockInds = [];
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
    blockSize = findBlockSize(currBlockRow,currBlockCol,Ihd,QL);
    blockInd = sub2ind([mb,nb],currBlockRow,currBlockCol);
    oldBlockInds = [oldBlockInds blockInd];
    SB_Pol = randi(2)-1; % pole of secret bits
    SB_Dir = randi(2)-1; % direction of secret bits
    BP_Dir = randi(2)-1; % direction of bit plane
    
    Bit_Planes = randi(15);
    %% generat first part of chromosome
    nbc = 0;
    secretMesgCont = 1;
    tmpStegno = Ihb;
    newCounter = 1;
    isStillAvailable = 1;
    thisBitInd = [];
    isInserted = 0;
    numUsedBlocks = 1;
    pixelInd = [];
    loopCont = 0;
    pixNum = 1;
    tmp=[];
    pixThresh= blockSize(1) * blockSize(2);
    while secretMesgCont <= length(binMessage)
%         if secretMesgCont>=345
%             disp('stop');
%         end
%         if ci==6
%             disp('stop');
%         end
        %         secretMesgCont = secretMesgCont + 1;
        loopCont = loopCont+1;
        if ((nbc<T_nbc) || (isStillAvailable==1)) && pixNum<=pixThresh
            % insert one bit in current location using (SB-Pole, SB-Dire ,BP-Dire, Bit-Planes)
            % update the value of nbc and used blocks
            if loopCont==1
                [pixelInd blockSize offset] = determineCurrentPixelInd(Ihd,mb,nb,p_dir,...
                    currBlockCol,currBlockRow,QL,pixelInd);
                chrom{1} = [currBlockRow currBlockCol  BP_Dir SB_Dir SB_Pol Bit_Planes p_dir offset pixNum];
                %                 try
                % get this pixel and convert it to binary
                pixel = tmpStegno(pixelInd(1),pixelInd(2));
                %                 catch
                %                     disp('ddd');
                %                 end
                binPixel = cell2mat(Ihb(pixelInd(1),pixelInd(2)));
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
                thisBitCont = 1;
            end
            % inserting one bit
            %             if SB_Dir==0
            bitToInsert = thisPixMessageBits(thisBitCont);
            %             else
            %                 revBinMessage = binMessage(end:-1:1);
            %                 revBinMessage = revBinMessage(1:end-secretMesgCont+1);
            %                 try
            %                     bitToInsert = revBinMessage(newCounter);
            %                 catch
            %                     disp('newCounter Index exceeds matrix dimensions.');
            %                 end
            
            %             end
            %             try
            [newPixel,isInserted,isStillAvailable,thisBitInd,oldBit] =...
                insertOneBit(bitToInsert,thisBitInd,mappingBitPlanes(Bit_Planes),BP_Dir,SB_Pol,newPixel);
            %             catch
            %                 disp('fff');
            %             end
            if isInserted
                secretMesgCont = secretMesgCont + 1;
%                 clc;
%                 disp(secretMesgCont);
                thisBitCont = thisBitCont + 1;
            end
            % updating nbc
            if oldBit~=bitToInsert
                nbc = nbc+1;
            end
            tmpStegno{pixelInd(1),pixelInd(2)}=  newPixel;
            
            if isStillAvailable==0 && secretMesgCont<=length(binMessage)
                %                 tmpPix = newPixel(end-3:end);
                tmp = [tmp newPixel(find(dec2bin(mappingBitPlanes(Bit_Planes),8)=='1'))];
                
                [pixelInd(1) pixelInd(2),key] = determineNextPixel(pixelInd(1),pixelInd(2),p_dir,blockSize(1),blockSize(2),currBlockCol,currBlockRow,QL,key);
                isStillAvailable = 1;
                isInserted = 0;
                thisBitInd = [];
                if nbc<T_nbc  && pixNum<pixThresh
                    pixNum = pixNum + 1;
                     chrom{numUsedBlocks}(end) = pixNum;  
                     %                 try
                pixel = Ihd(pixelInd(1),pixelInd(2));
                %                 catch
                %                     disp('ddd');
                %                 end
                binPixel = cell2mat(Ihb(pixelInd(1),pixelInd(2)));
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
                end
               
            end
            %% generate the others parts
        else % if nbc>=T_nbc
            % generate Random Block between 1 and nb, 1 and mb and assign it to current location
            % and random values for, SB-Pole, SB-Dire , BP-Dire, Bit-Planes and assign them to new part of chromosome
            % determine the next block using b_dir
            %             newCounter = 1;
            pixelInd = [];
            thisBitInd = [];
            newBlockInd = randi(mb*nb);
            while ismember(newBlockInd,oldBlockInds)
                newBlockInd = randi(mb*nb);
            end
            oldBlockInds = [oldBlockInds newBlockInd];
            [newBlockInd(1) newBlockInd(2)]  = ind2sub([mb,nb],newBlockInd);
            % generating SB-Pole, SB-Dire , BP-Dire, Bit-Planes
            SB_Pol = randi(2)-1; % pole of secret bits
            SB_Dir = randi(2)-1; % direction of secret bits
            BP_Dir = randi(2)-1; % direction of bit plane
            Bit_Planes = randi(15);
            p_dir = randi(16)-1;
            key = keyArr(p_dir+1);
            [pixelInd blockSize offset] = determineCurrentPixelInd(Ihd,mb,nb,p_dir,newBlockInd(2),newBlockInd(1),QL,pixelInd);
            currBlockRow  = newBlockInd(1);
            currBlockCol = newBlockInd(2);
            pixThresh = blockSize(1) * blockSize(2);
                            isStillAvailable = 1;

            numUsedBlocks = numUsedBlocks + 1;
            pixNum = 1;
            chrom{numUsedBlocks} = [newBlockInd(1) newBlockInd(2) BP_Dir SB_Dir SB_Pol Bit_Planes p_dir offset pixNum];
            nbc = 0;
            %             try
            pixel = tmpStegno(pixelInd(1),pixelInd(2));
            %             catch
            %                 disp('ddd');
            %             end
            binPixel = cell2mat(Ihb(pixelInd(1),pixelInd(2)));
            newPixel = binPixel;
            %             secretMesgCont = secretMesgCont-1;
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
        end
    end
    pop.chrom{ci} = chrom;
    pop.sc{ci} = secretMesgCont;
    for sgi = 1:size(tmpStegno,1)
        for sgj = 1:size(tmpStegno,2)
            fstegno(sgi,sgj) = bin2dec(tmpStegno{sgi,sgj});
        end
    end
            
    pop.stegno{ci} = fstegno;
%     pop.stegnoMat{ci} = cell2mat(tmpStegno);
end
% profview;