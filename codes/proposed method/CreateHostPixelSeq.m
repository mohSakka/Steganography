function [messPixelSeq]=CreateHostPixelSeq(blockSize,col,row,xOff,yOff,direction,messReq,imCover)

try
messPixelSeq=-1*zeros(1,messReq);
catch
    disp('stop');
end


currPixelCol = col;
    currPixelRow = row;
    numOfCols = blockSize(2);
    numOfRows = blockSize(1);
    colHB = currPixelCol + numOfCols -1;
    colLB = currPixelCol;
     rowHB = currPixelRow + numOfRows - 1;
    rowLB = currPixelRow  ;
row=row + yOff;
col=col + xOff;

counter=0;
if direction==0
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        col=col+1;
        if col>colHB
            col=colLB;
            row=row+1;
            if row>rowHB
               row=rowLB; 
            end
        end
    end
elseif direction==1
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        col=col-1;
        if col<colLB
            col=colHB;
            row=row+1;
            if row>rowHB
               row=rowLB; 
            end
        end
    end
elseif direction==2
    while counter<messReq
        counter=counter+1;
        try
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        catch
            disp('stop');
        end
        col=col+1;
        if col>colHB
            col=colLB;
            row=row-1;
            if row<rowLB
               row=rowHB; 
            end
        end
    end
elseif direction==3
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        col=col-1;
        if col<colLB
            col=colHB;
            row=row-1;
            if row<rowLB
               row=rowHB; 
            end
        end
    end
elseif direction==4
    key=1;
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        col=col+key;
        if col<colLB || col>colHB
            col=col-key;
            row=row+1;row(row>rowHB)=rowLB;
            if key==1 
                key=-1 ;
            elseif key==-1
                key=1;
            end
        end
    end
elseif direction==5
    key=-1;
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        col=col+key;
        if col<colLB || col>colHB
            col=col-key;
            row=row+1;
            row(row>rowHB)=rowLB;
            if key==1 
                key=-1 ;
            elseif key==-1
                key=1;
            end
        end
    end
elseif direction==6
    key=1;
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        col=col+key;
        if col<colLB || col>colHB
            col=col-key;
            row=row-1;
            row(row<rowLB)=rowHB;
            if key==1 
                key=-1 ;
            elseif key==-1
                key=1;
            end
        end
    end
elseif direction==7
    key=-1;
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        col=col+key;
        if col<colLB || col>colHB
            col=col-key;
            row=row-1;
            row(row<rowLB)=rowHB;
            if key==1 
                key=-1 ;
            elseif key==-1
                key=1;
            end
        end
    end
elseif direction==8
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        row=row+1;
        if row>rowHB
            row=rowLB;
            col=col+1;
            if col>colHB
               col=colLB; 
            end
        end
    end
elseif direction==9
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        row=row+1;
        if row>rowHB
            row=rowLB;
            col=col-1;
            if col<colLB
               col=colHB; 
            end
        end
    end
elseif direction==10
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        row=row-1;
        if row<rowLB
            row=rowHB;
            col=col+1;
            if col>colHB
               col=colLB; 
            end
        end
    end
elseif direction==11
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        row=row-1;
        if row<rowLB
            row=rowHB;
            col=col-1;
            if col<colLB
               col=colHB; 
            end
        end
    end
elseif direction==12
    key=1;
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        row=row+key;
        if row<rowLB || row>rowHB
            row=row-key;
            col=col+1;
            col(col>colHB)=colLB;
            if key==1 
                key=-1 ;
            elseif key==-1
                key=1;
            end
        end
    end
elseif direction==13
    key=1;
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        row=row+key;
        if row<rowLB || row>rowHB
            row=row-key;
            col=col-1;
            col(col<colLB)=colHB;
            if key==1 
                key=-1 ;
            elseif key==-1
                key=1;
            end
        end
    end
elseif direction==14
    key=-1;
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        row=row+key;
        if row<rowLB || row>rowHB
            row=row-key;
            col=col+1;
            col(col>colHB)=colLB;
            if key==1 
                key=-1 ;
            elseif key==-1
                key=1;
            end
        end
    end
elseif direction==15
    key=-1;
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        row=row+key;
        if row<rowLB || row>rowHB
            row=row-key;
            col=col-1;
            col(col<colLB)=colHB;
            if key==1 
                key=-1 ;
            elseif key==-1
                key=1;
            end
        end
    end
end

end