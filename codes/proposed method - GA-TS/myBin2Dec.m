function x = myBin2Dec(s)
% Lean version of Matlab's BIN2DEC, see: help bin2dec
n     = size(s, 2);
v     = s - '0'; 
twos  = pow2(n-1:-1:0);
x     = v * twos.';
end