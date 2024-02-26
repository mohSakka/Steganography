function chromBitSeq=ConvertChromToBitSeq(chrom)



binVal1=dec2bin(chrom(1),4);
binVal2=dec2bin(chrom(2),9);   % Resolution of image is 512*512
binVal3=dec2bin(chrom(3),9);
binVal4=dec2bin(chrom(4),4);
binVal5=dec2bin(chrom(5),1);
binVal6=dec2bin(chrom(6),1);
binVal7=dec2bin(chrom(7),1);

chromBitSeq=[binVal1 binVal2 binVal3 binVal4 binVal5 binVal6 binVal7];
end