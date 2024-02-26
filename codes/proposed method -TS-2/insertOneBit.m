function [newBinPixel,isInserted,isStillAvailable,thisBitInd,oldBit] = insertOneBit(...
    bitToInsert,thisBitInd,Bit_Planes,BP_Dir,SB_Pol,newPixel)
newBinPixel = newPixel;
%%%%%%%%% SB_Pole
if SB_Pol==1
    if bitToInsert=='1'
        bitToInsert='0';
    elseif bitToInsert=='0'
        bitToInsert='1';
    end
end
%%%%%%%%% end SB_Pol
isStillAvailable = 1;
switch Bit_Planes
    %%%%%%%%%%%%%%%%%%%% case 0
    case 0
        oldBit = [];
        newBinPixel = newBinPixel;
        isInserted = 0;   % the bit haven't been inserted
        isStillAvailable = 0;
        %%%%%%%%%%%%%%%% case 1
    case 1
        oldBit = newBinPixel(end);
        newBinPixel(end) = bitToInsert;
        isInserted = 1;   % the bit have been inserted
        isStillAvailable = 0;
        %%%%%%%%%%%%%%%%%%%% case 2
    case 2
        oldBit = newBinPixel(end-1);
        newBinPixel(end-1) = bitToInsert;
        isInserted = 1;   % the bit have been inserted
        isStillAvailable = 0;
        %%%%%%%%%%%%%%%%%%%%% case 3
    case 3
        if isempty(thisBitInd)
            if BP_Dir==1
                oldBit = newBinPixel(end);
                newBinPixel(end) = bitToInsert;
                thisBitInd = length(newBinPixel);
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            else
                oldBit = newBinPixel(end-1);
                newBinPixel(end-1) = bitToInsert;
                thisBitInd = length(newBinPixel)-1;
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            end
        else
            if BP_Dir==1
                thisBitInd = thisBitInd-1;
            else
                thisBitInd = thisBitInd+1;
            end
            oldBit = newBinPixel(thisBitInd);
            newBinPixel(thisBitInd) = bitToInsert;
            isInserted = 1;
            isStillAvailable = 0;
            thisBitInd = [];
        end
        %%%%%%%%%%%%%%%%%%%%%%% case 4 
    case 4
        oldBit = newBinPixel(end-2);
        newBinPixel(end-2) = bitToInsert;
        isInserted = 1;   % the bit have been inserted
        isStillAvailable = 0;
        %%%%%%%%%%%%%%%%%%%% case 5 
    case 5
        if isempty(thisBitInd)
            if BP_Dir==1
                oldBit = newBinPixel(end);
                newBinPixel(end) = bitToInsert;
                thisBitInd = length(newBinPixel);
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            else
                oldBit = newBinPixel(end-2);
                newBinPixel(end-2) = bitToInsert;
                thisBitInd = length(newBinPixel)-2;
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            end
        else
            if thisBitInd==length(newBinPixel)
                thisBitInd = length(newBinPixel)-2;
            else
                thisBitInd = length(newBinPixel);
            end
            oldBit = newBinPixel(thisBitInd);
            newBinPixel(thisBitInd) = bitToInsert;
            isInserted = 1;
            isStillAvailable = 0;
            thisBitInd = [];
        end
        %%%%%%%%%%%%%%%% case 6
    case 6
        if isempty(thisBitInd)
            if BP_Dir==1
                oldBit = newBinPixel(end-1);
                newBinPixel(end-1) = bitToInsert;
                thisBitInd = length(newBinPixel)-1;
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            else
                oldBit = newBinPixel(end-2);
                newBinPixel(end-2) = bitToInsert;
                thisBitInd = length(newBinPixel)-2;
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            end
        else
            if BP_Dir==1
                thisBitInd = thisBitInd-1;
            else
                thisBitInd = thisBitInd+1;
            end
            oldBit = newBinPixel(thisBitInd);
            newBinPixel(thisBitInd) = bitToInsert;
            isInserted = 1;
            isStillAvailable = 0;
            thisBitInd = [];
        end
        %%%%%%%%%%%%%%%%%%%%% case 7
    case 7
        if isempty(thisBitInd)
            if BP_Dir==1
                oldBit = newBinPixel(end);
                newBinPixel(end) = bitToInsert;
                thisBitInd = length(newBinPixel);
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            else
                oldBit = newBinPixel(end-2);
                newBinPixel(end-2) = bitToInsert;
                thisBitInd = length(newBinPixel)-2;
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            end
        else 
            if BP_Dir==1
               thisBitInd = thisBitInd-1;
               oldBit = newBinPixel(thisBitInd);
               newBinPixel(thisBitInd) = bitToInsert;
               isInserted = 1;  
               if thisBitInd-1 < length(newBinPixel)-2
                   isStillAvailable = 0;
                               thisBitInd = [];
               end
            else
             thisBitInd = thisBitInd+1;
             oldBit = newBinPixel(thisBitInd);
               newBinPixel(thisBitInd) = bitToInsert;
               isInserted = 1;  
               if thisBitInd+1 > length(newBinPixel)
                   isStillAvailable = 0;
                               thisBitInd = [];
               end
            end
        end
        %%%%%%%%%%%% case 8
    case 8
        oldBit = newBinPixel(end-3);
         newBinPixel(end-3) = bitToInsert;
        isInserted = 1;   % the bit have been inserted
        isStillAvailable = 0;
        %%%%%%%%%%%%%%%%%%%% case 9
    case 9
         if isempty(thisBitInd)
            if BP_Dir==1
                oldBit = newBinPixel(end);
                newBinPixel(end) = bitToInsert;
                thisBitInd = length(newBinPixel);
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            else
                oldBit = newBinPixel(end-3);
                newBinPixel(end-3) = bitToInsert;
                thisBitInd = length(newBinPixel)-3;
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            end
        else
            if thisBitInd==length(newBinPixel)
                thisBitInd = length(newBinPixel)-3;
            else
                thisBitInd = length(newBinPixel);
            end
            oldBit = newBinPixel(thisBitInd);
            newBinPixel(thisBitInd) = bitToInsert;
            isInserted = 1;
            isStillAvailable = 0;
            thisBitInd = [];
         end
        %%%%%%%%%%%%%% case 10
    case 10
        if isempty(thisBitInd)
            if BP_Dir==1
                oldBit = newBinPixel(end-1);
                newBinPixel(end-1) = bitToInsert;
                thisBitInd = length(newBinPixel)-1;
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            else
                oldBit = newBinPixel(end-3);
                newBinPixel(end-3) = bitToInsert;
                thisBitInd = length(newBinPixel)-3;
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            end
        else
            if thisBitInd==length(newBinPixel)-1
                thisBitInd = length(newBinPixel)-3;
            else
                thisBitInd = length(newBinPixel)-1;
            end
            oldBit = newBinPixel(thisBitInd);
            newBinPixel(thisBitInd) = bitToInsert;
            isInserted = 1;
            isStillAvailable = 0;
            thisBitInd = [];
        end
         %%%%%%%%%%%%%% case 11
    case 11
         if isempty(thisBitInd)
            if BP_Dir==1
                oldBit = newBinPixel(end);
                newBinPixel(end) = bitToInsert;
                thisBitInd = length(newBinPixel);
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            else
                oldBit = newBinPixel(end-3);
                newBinPixel(end-3) = bitToInsert;
                thisBitInd = length(newBinPixel)-3;
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            end
        else
            if BP_Dir==1
                if thisBitInd==length(newBinPixel)-1
               thisBitInd = length(newBinPixel)-3;
               oldBit = newBinPixel(thisBitInd);
               newBinPixel(thisBitInd) = bitToInsert;
               isInserted = 1;  
                   isStillAvailable = 0;
                   thisBitInd = [];
                else
                    thisBitInd = thisBitInd-1;
                    oldBit = newBinPixel(thisBitInd);
                    newBinPixel(thisBitInd) = bitToInsert;
                     isInserted = 1;  
                   isStillAvailable = 1;
                end
            else
                if thisBitInd==length(newBinPixel)-3
                    thisBitInd = length(newBinPixel)-1;
                    oldBit = newBinPixel(thisBitInd);
                    newBinPixel(thisBitInd) = bitToInsert;
               isInserted = 1;  
                   isStillAvailable = 1;
                else      
             thisBitInd = thisBitInd+1;
             oldBit = newBinPixel(thisBitInd);
               newBinPixel(thisBitInd) = bitToInsert;
               isInserted = 1;  
               if thisBitInd+1 > length(newBinPixel)
                   isStillAvailable = 0;
                   thisBitInd = [];
               end
                end
            end
         end
%%%%%%%%%%%%%%%%%%%%%% case 12
   case 12
        if isempty(thisBitInd)
            if BP_Dir==1
                oldBit = newBinPixel(end-2);
                newBinPixel(end-2) = bitToInsert;
                thisBitInd = length(newBinPixel)-2;
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            else
                oldBit = newBinPixel(end-3);
                newBinPixel(end-3) = bitToInsert;
                thisBitInd = length(newBinPixel)-3;
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            end
        else
            if BP_Dir==1
                thisBitInd = thisBitInd-1;
            else
                thisBitInd = thisBitInd+1;
            end
            oldBit = newBinPixel(thisBitInd);
            newBinPixel(thisBitInd) = bitToInsert;
            isInserted = 1;
            isStillAvailable = 0;
            thisBitInd = [];
        end
        %%%%%%%%%%% case 13
    case 13
        if isempty(thisBitInd)
            if BP_Dir==1
                oldBit = newBinPixel(end);
                newBinPixel(end) = bitToInsert;
                thisBitInd = length(newBinPixel);
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            else
                oldBit = newBinPixel(end-3);
                newBinPixel(end-3) = bitToInsert;
                
                thisBitInd = length(newBinPixel)-3;
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            end
        else
            if BP_Dir==1
                if thisBitInd==length(newBinPixel)
               thisBitInd = length(newBinPixel)-2;
               oldBit = newBinPixel(thisBitInd);
               newBinPixel(thisBitInd) = bitToInsert;
               isInserted = 1;  
                   isStillAvailable = 1;
                else
                    thisBitInd = thisBitInd-1;
                    oldBit = newBinPixel(thisBitInd);
                    newBinPixel(thisBitInd) = bitToInsert;
                     isInserted = 1;  
                   isStillAvailable = 1;
                   if thisBitInd-1 < length(newBinPixel)-3
                   isStillAvailable = 0;
                   thisBitInd = [];
               end
                end
            else
                if thisBitInd==length(newBinPixel)-2
                    thisBitInd = length(newBinPixel);
                    oldBit = newBinPixel(thisBitInd);
                    newBinPixel(thisBitInd) = bitToInsert;
               isInserted = 1;  
                   isStillAvailable = 0;
                   thisBitInd = [];
                else      
             thisBitInd = thisBitInd+1;
             oldBit = newBinPixel(thisBitInd);
               newBinPixel(thisBitInd) = bitToInsert;
               isInserted = 1;  
               
                   isStillAvailable = 1;
               
                end
            end
         end
        %%%%%%%%%%%%% case 14
    case 14
         if isempty(thisBitInd)
            if BP_Dir==1
                oldBit = newBinPixel(end-1);
                newBinPixel(end-1) = bitToInsert;
                thisBitInd = length(newBinPixel)-1;
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            else
                oldBit = newBinPixel(end-3);
                newBinPixel(end-3) = bitToInsert;
                thisBitInd = length(newBinPixel)-3;
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            end
        else 
            if BP_Dir==1
               thisBitInd = thisBitInd-1;
               oldBit = newBinPixel(thisBitInd);
               newBinPixel(thisBitInd) = bitToInsert;
               isInserted = 1;  
               if thisBitInd-1 < length(newBinPixel)-3
                   isStillAvailable = 0;
                   thisBitInd = [ ];
               else
                   isStillAvailable =  1;
               end
            else
             thisBitInd = thisBitInd+1;
             oldBit = newBinPixel(thisBitInd);
               newBinPixel(thisBitInd) = bitToInsert;
               isInserted = 1;  
               if thisBitInd+1 > length(newBinPixel)-1
                   isStillAvailable = 0;
                   thisBitInd = [ ];
                   else
                   isStillAvailable =  1;
               end
            end
         end
        %%%%%%%%%%%%%%%%%% case 15
    case 15
        if isempty(thisBitInd)
            if BP_Dir==1
                oldBit = newBinPixel(end);
                newBinPixel(end) = bitToInsert;
                thisBitInd = length(newBinPixel);
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            else
                oldBit = newBinPixel(end-3);
                newBinPixel(end-3) = bitToInsert;
                thisBitInd = length(newBinPixel)-3;
                isInserted = 1;   % the bit have been inserted
                isStillAvailable = 1;
            end
        else 
            if BP_Dir==1
               thisBitInd = thisBitInd-1;
               oldBit = newBinPixel(thisBitInd);
               newBinPixel(thisBitInd) = bitToInsert;
               isInserted = 1;  
               if thisBitInd-1 < length(newBinPixel)-3
                   isStillAvailable = 0;
                   thisBitInd = [];
               else
                   isStillAvailable = 1;
               end
            else
             thisBitInd = thisBitInd+1;
             oldBit = newBinPixel(thisBitInd);
               newBinPixel(thisBitInd) = bitToInsert;
               isInserted = 1;  
               if thisBitInd+1 > length(newBinPixel)
                   isStillAvailable = 0;
                   thisBitInd = [];
               else
                   isStillAvailable = 1;
               end
            end
        end
end
end
%%%%%%%%%% end switch
