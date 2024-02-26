function blockInds = findBlocksInds(chrom,Ih,QL)
[m,n] = size(Ih);
nb = ceil(n/ QL); % blocks along the coloumns
mb = ceil(m/ QL); % blocks along the rows
for m = 1:length(chrom)
    meta = chrom{m};
    row = meta(1);
    col = meta(2);
    blockInds(m) = sub2ind([mb nb],row,col);
end
end