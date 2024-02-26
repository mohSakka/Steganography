clear;
clc;
close all;
rng(1);
Ih = round(unifrnd(0,255,256,256));
Ihd = Ih;
for i=1:size(Ih,1)
for j=1:size(Ih,2)
Ihb{i,j}=dec2bin(Ih(i,j),8);
end
end

[pop,tmp] = generateFirstPop(Ihd,Ihb,'Hello world',50,20,200);
pop=pop';
