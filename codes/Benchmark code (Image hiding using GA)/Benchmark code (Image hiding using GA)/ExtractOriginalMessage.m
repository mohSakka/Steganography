function [message]=ExtractOriginalMessage(stego,chromPixelSeq,nvar,messageLength,chrom)

chromBitSeq=repmat('0',1,length(chromPixelSeq));

for i=1:length(chromBitSeq)
    pixelVal=dec2bin(stego(chromPixelSeq(i)),8);
    chromBitSeq(i)=pixelVal(8);
end

% chrom=zeros(1,nvar);
% chrom(1)=bin2dec(chromBitSeq(1:4));chromBitSeq(1:4)=[];
% chrom(2)=bin2dec(chromBitSeq(1:9));chromBitSeq(1:9)=[];
% chrom(3)=bin2dec(chromBitSeq(1:9));chromBitSeq(1:9)=[];
% chrom(4)=bin2dec(chromBitSeq(1:4));chromBitSeq(1:4)=[];
% chrom(5)=bin2dec(chromBitSeq(1));chromBitSeq(1)=[];
% chrom(6)=bin2dec(chromBitSeq(1));chromBitSeq(1)=[];
% chrom(7)=bin2dec(chromBitSeq(1));chromBitSeq(1)=[];

direction=chrom(1);
xOff=chrom(2);
yOff=chrom(3);
bitPlanes=mappingBitPlanes(chrom(4));bitPlanes=dec2bin(bitPlanes,4);numOfUsedBits=length(find(bitPlanes=='1'));
bpDir=chrom(7);

[messReq,chromReq,status]=DetermineRequiredNumberOfPixels(messageLength,length(chromPixelSeq),numOfUsedBits,length(stego(:)));
try
[messPixelSeq,chromPixelSeq]=CreateHostPixelSeq(xOff,yOff,direction,messReq,chromReq);
catch
    disp('ddd')
end
message=repmat('0',messageLength,1);
counter=0;

if bpDir==0
    for i=1:length(messPixelSeq)
        pixelVal=dec2bin(stego(messPixelSeq(i)),8);
        nibble=pixelVal(5:8);
        
        for j=1:4
            if bitPlanes(j)=='1'
                counter=counter+1;
                if counter>messageLength
                    continue;
                end
                message(counter)=nibble(j);
            end
        end
    end
elseif bpDir==1
    for i=1:length(messPixelSeq)
        pixelVal=dec2bin(stego(messPixelSeq(i)),8);
        nibble=pixelVal(5:8);
        
        for j=4:-1:1
            if bitPlanes(j)=='1'
                counter=counter+1;
                if counter>messageLength
                    continue;
                 end
                message(counter)=nibble(j);
            end
        end
    end

end