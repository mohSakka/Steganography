function stego=EmbeddingTheMessage(reqBitSeq,chromBitSeq,bitPlanes,bpDir,imCover,messPixelSeq,chromPixelSeq)

stego=imCover;

% Embedding chromosome bits
counter=0;
% for i=1:length(chromPixelSeq)
%     pixelVal=dec2bin(stego(chromPixelSeq(i)),8);
%     pixelVal(8)=chromBitSeq(i);
%     stego(chromPixelSeq(i))=bin2dec(pixelVal);
% end


% Embedding message bits
if bpDir==0
    for i=1:length(messPixelSeq)
        pixelVal=dec2bin(stego(messPixelSeq(i)),8);
        nibble=pixelVal(5:8);
        
        for j=1:4
            if bitPlanes(j)=='1'
                counter=counter+1;
                if counter>length(reqBitSeq)
                    continue;
                end
                nibble(j)=reqBitSeq(counter);
            end
        end
        pixelVal(5:8)=nibble;
        stego(messPixelSeq(i))=bin2dec(pixelVal);
    end
elseif bpDir==1
    for i=1:length(messPixelSeq)
        pixelVal=dec2bin(stego(messPixelSeq(i)),8);
        nibble=pixelVal(5:8);
        
        for j=4:-1:1
            if bitPlanes(j)=='1'
                counter=counter+1;
                if counter>length(reqBitSeq)
                    continue;
                 end
                nibble(j)=reqBitSeq(counter);
            end
        end
        pixelVal(5:8)=nibble;
        stego(messPixelSeq(i))=bin2dec(pixelVal);
    end
end


end