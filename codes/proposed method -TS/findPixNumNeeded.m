function pixNumNeeded = findPixNumNeeded(meta,differ)
dbp = mappingBitPlanes(meta(6));
bp = dec2bin(dbp,8);
len = length(find(bp=='1'));
pixNumNeeded = ceil(differ/len);
end