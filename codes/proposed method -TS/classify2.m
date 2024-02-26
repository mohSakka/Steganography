function [subCommA subCommB] = classify2(sharedA,sharedB,Ih,QL)
m = ceil(size(Ih,1)/QL);
n = ceil(size(Ih,2)/QL);
for i=1:length(sharedA)
    rA = sharedA{i}(1);
    cA = sharedA{i}(2);
    rB = sharedB{i}(1);
    cB = sharedB{i}(2);
    indA(i) = sub2ind([m n],rA,cA);
    indB(i) = sub2ind([m n],rB,cB);
end
for i = 1:length(indA)
    tmp = indB==indA(i);
    subCommA{i,1} =sharedA{i};
    subCommB{i,1} = sharedB{tmp};
end
end
    
