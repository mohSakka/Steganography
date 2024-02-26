row =3;
col = 3;
rowsNum = 3;
colNum = 3;
dir = 13;
    figure;
while 1
    if ~exist('key','var')
        key = -1;
    end
    [row,col,key] = determineNextPixel(row,col,dir,rowsNum,colNum,key);
    visValidate;
end