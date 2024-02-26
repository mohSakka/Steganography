function bp = mappingBitPlanes(nonMappedBP)
trueBP = 1:15;
try
bp = trueBP(nonMappedBP);
catch
    disp('vsg');
end
end