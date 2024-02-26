function [commonA commonB] = findAandBintersection(A,B,Ih,QL)
AblocksInds = findBlocksInds(A,Ih,QL);
BblockInds = findBlocksInds(B,Ih,QL);
commonA = ismember(AblocksInds,BblockInds);
commonB = ismember(BblockInds,AblocksInds);
end
