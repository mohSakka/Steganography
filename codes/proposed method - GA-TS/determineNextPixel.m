function [row,col,key] = determineNextPixel(row,col,direction,numOfRows,numOfCols,currBlockCol,currBlockRow,QL,key)
currPixelCol = (currBlockCol-1) * QL + 1;
    currPixelRow = (currBlockRow-1) * QL + 1;
    colHB = currPixelCol + numOfCols -1;
    colLB = currPixelCol;
     rowHB = currPixelRow + numOfRows - 1;
    rowLB = currPixelRow  ;
if direction==0
    col=col+1;
    if col>colHB
        col=colLB;
        row=row+1;
        if row>rowHB
            row=rowLB;
        end
    end
elseif direction==1
    col=col-1;
    if col<colLB
        col=colHB;
        row=row+1;
        if row>rowHB
            row=rowLB;
        end
    end
elseif direction==2
    col=col+1;
    if col>colHB
        col=colLB;
        row=row-1;
        if row<rowLB
            row=rowHB;
        end
    end
elseif direction==3
    col=col-1;
    if col<colLB
        col=colHB;
        row=row-1;
        if row<rowLB
            row=rowHB;
        end
    end
elseif direction==4 
%      key = 1;
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
elseif direction==5
%     key=-1;
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
elseif direction==6
%     key=1;
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
elseif direction==7
%     key=-1;
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
elseif direction==8
    row=row+1;
    if row>rowHB
        row=rowLB;
        col=col+1;
        if col>colHB
            col=colLB;
        end
    end
elseif direction==9
    row=row+1;
    if row>rowHB
        row=rowLB;
        col=col-1;
        if col<colLB
            col=colHB;
        end
    end
elseif direction==10
    row=row-1;
    if row<rowLB
        row=rowHB;
        col=col+1;
        if col>colHB
            col=colLB;
        end
    end
elseif direction==11
    row=row-1;
    if row<rowLB
        row=rowHB;
        col=col-1;
        if col<colLB
            col=colHB;
        end
    end
elseif direction==12
%     key=1;
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
elseif direction==13
%     key=1;
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
elseif direction==14
%     key=-1;
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
elseif direction==15
%     key=-1;
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