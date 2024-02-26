function [child1,child2] = crossover4(E1,E2,crossRatio,trueBitsNum)
global Ih;
global QL; 
child1 = E1;
child2 = E2;
A = E1.chrom;
B = E2.chrom;
CLength = length(A);
DLength = length(B);
[commonA commonB] = findAandBintersection(A,B);
newA = A;
newA(commonA) = [];
newB = B;
newB(commonB) = [];
C = B(commonB);
D = A(commonA);
remainedCLength = CLength - length(C);
remainedDLength = DLength - length(D);
% if remainedCLength<=0 || remainedDLength<=0
%     disp('err');
% end
% generate the remained part of C
generatingRemaindC;
% generate the remained part of D
generatingRemaindD;

child1.chrom = C;
child2.chrom = D;
end
        