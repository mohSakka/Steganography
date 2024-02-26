function [Rm,Sm,R_m,S_m] = find_RS(stegno,n)

mask = [1 -1];
countCond1 = 0;
countCond2 = 0;
countCondm1 = 0;
countCondm2 = 0;

CountAll = length(stegno(:))/n;
for i=1:size(stegno,1)
for j=1:n:size(stegno,2)
    G = stegno(i,j:j+n-1);
    cv = conv2(double(mask),double(G));
    cv = cv(2:end-1);
    smoothness = sum(abs(cv));  
    
    F1_G =  F1(G);
    F1_G_cv = conv2(double(mask),double(F1_G));
    F1_G_cv = F1_G_cv(2:end-1);
    F1_G_smoothness = sum(abs(F1_G_cv)); 
    cond1 = F1_G_smoothness>smoothness;
    if (cond1)
        countCond1 = countCond1+1;
    end
    cond2 = F1_G_smoothness<smoothness;
    if (cond2)
        countCond2 = countCond2+1;
    end
    %%%%%%%%%5
    F_minus1_G = F_minus_1(G);
    F_minus1_G_cv = conv2(double(mask),double(F_minus1_G));
    F_minus1_G_cv = F_minus1_G_cv(2:end-1);
    F_minus1_G_smoothness = sum(abs(F_minus1_G_cv)); 
    cond1 = F_minus1_G_smoothness>smoothness;
    if (cond1)
        countCondm1 = countCondm1+1;
    end
    cond2 = F_minus1_G_smoothness<smoothness;
    if (cond2)
        countCondm2 = countCondm2+1;
    end
end
end
Rm = countCond1/CountAll;
Sm = countCond2/CountAll;
R_m = countCondm1/CountAll;
S_m = countCondm2/CountAll;
end


function F1_Output = F1(G)
F1_Output = G;
evenInds = find(G(rem(G,2)==0));
oddInds = find(G(rem(G,2)~=0));
F1_Output(evenInds) = G(evenInds)+1;
F1_Output(oddInds) = G(oddInds)-1;
end

function F1_minus1_Output = F_minus_1(G)
F1_minus1_Output = G;
evenInds = find(G(rem(G,2)==0));
oddInds = find(G(rem(G,2)~=0));
F1_minus1_Output(evenInds) = G(evenInds)-1;
F1_minus1_Output(oddInds) = G(oddInds)+1;
end