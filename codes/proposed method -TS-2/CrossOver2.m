function [child1,child2] = CrossOver2(ratio,A,B,Ih,QL,trueMesgBitsNum)
% concatenation of the 2 Elites
% Z = {};
% cnt=1;
% for i=1:length(Elite1.chrom)
%     Z{cnt} = [Elite1.chrom{i}];
%     cnt = cnt+1;
% end
% for i=1:length(Elite2.chrom)
%     Z{cnt} = [Elite2.chrom{i}];
%     cnt = cnt+1;
% end
% %%%%%%%%%%%
ch1Length = length(A.chrom);
ch2Length = length(B.chrom);

cross2SubProcedureA;
cross2SubProcedureB;
% find the child1 blocks inds 
[m,n] = size(Ih);
 nb = ceil(n/ QL); % blocks along the coloumns
    mb = ceil(m/ QL); % blocks along the rows
for m = 1:length(child1.chrom)
    meta = child1.chrom{m};
    inds(m) = sub2ind([mb nb],meta(1),meta(2));
end
while(length(unique(inds))~=length(inds))
 cross2SubProcedureA;
for m = 1:length(child1.chrom)
    meta = child1.chrom{m};
    inds(m) = sub2ind([mb nb],meta(1),meta(2));
end
end
% find the child2 blocks inds 
for m = 1:length(child2.chrom)
    meta = child2.chrom{m};
    inds2(m) = sub2ind([mb nb],meta(1),meta(2));
end
while(length(unique(inds2))~=length(inds2))
   cross2SubProcedureB;
for m = 1:length(child2.chrom)
    meta = child2.chrom{m};
    inds2(m) = sub2ind([mb nb],meta(1),meta(2));
end
end
end