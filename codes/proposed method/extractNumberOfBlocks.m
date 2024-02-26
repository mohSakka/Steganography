function R = extractNumberOfBlocks(N)
R = 0;
nDigits = 1;
while R==0
R = cast(floor(10^nDigits*N),'int32') - cast(10^nDigits*floor(N),'int32');
R = cast(R,'double'); % If double is important then cast it back
nDigits = nDigits + 1;
end