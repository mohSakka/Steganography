function [bitSeq,combBitSeq,reversBitSeq,reversCombBitSeq]=ConvertSecretImToBitSeq(imSec)

% Original bits sequence
bitSeq=dec2bin(imSec,8);
bitSeq=bitSeq(:);

% Reverse of original bits sequence
reversBitSeq=wrev(bitSeq);

% Complement of bits sequence
combBitSeq=bitSeq;
for i=1:size(combBitSeq,1)
    for j=1:size(combBitSeq,2)
        if combBitSeq(i,j)=='0'
            combBitSeq(i,j)='1';
        elseif combBitSeq(i,j)=='1'
            combBitSeq(i,j)='0';
        end
    end
end
combBitSeq=combBitSeq(:);

% Reverse of complement of bits sequence
reversCombBitSeq=wrev(combBitSeq);


end