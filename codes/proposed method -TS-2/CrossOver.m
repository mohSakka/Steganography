function [child1,child2] = CrossOver(Elite1,Elite2,Ih,QL)
% concatenation of the 2 Elites
Z = {};
cnt=1;
for i=1:length(Elite1.chrom)
    Z{cnt} = [Elite1.chrom{i}];
    cnt = cnt+1;
end
for i=1:length(Elite2.chrom)
    Z{cnt} = [Elite2.chrom{i}];
    cnt = cnt+1;
end
ch1Length = length(Elite1.chrom);
ch2Length = length(Elite2.chrom);
% generate child1
randomMetaInds = randperm(length(Z),ch1Length);
child1.chrom = Z(randomMetaInds);
% generate child2
randomMetaInds = randperm(length(Z),ch2Length);
child2.chrom = Z(randomMetaInds);
% find the child1 blocks inds 
[m,n] = size(Ih);
 nb = ceil(n/ QL); % blocks along the coloumns
    mb = ceil(m/ QL); % blocks along the rows
for m = 1:length(child1.chrom)
    meta = child1.chrom{m};
    inds(m) = sub2ind([mb nb],meta(1),meta(2));
end
while(length(unique(inds))~=length(inds))
    randomMetaInds = randperm(length(Z),ch1Length);
child1.chrom = Z(randomMetaInds);
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
    randomMetaInds = randperm(length(Z),ch2Length);
child2.chrom = Z(randomMetaInds);
for m = 1:length(child2.chrom)
    meta = child2.chrom{m};
    inds2(m) = sub2ind([mb nb],meta(1),meta(2));
end
end
end