function [messPixelSeq,chromPixelSeq]=CreateHostPixelSeq(oldChromPixelsInds,xOff,yOff,direction,messReq,chromReq)

global imCover
messPixelSeq=-1*zeros(1,messReq);
chromPixelSeq=zeros(1,chromReq);


row=1+yOff;
col=1+xOff;

numOfRows=size(imCover,1);
numOfCols=size(imCover,2);

for i=0:chromReq-1
    try
    chromPixelSeq(i+1)=sub2ind(size(imCover),numOfRows,numOfCols-length(oldChromPixelsInds));
    catch
        disp('error');
    end
    end

counter=0;
if direction==0
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        col=col+1;
        if col>numOfCols
            col=1;
            row=row+1;
            if row>numOfRows
               row=1; 
            end
        end
    end
elseif direction==1
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        col=col-1;
        if col<1
            col=numOfCols;
            row=row+1;
            if row>numOfRows
               row=1; 
            end
        end
    end
elseif direction==2
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        col=col+1;
        if col>numOfCols
            col=1;
            row=row-1;
            if row<1
               row=numOfRows; 
            end
        end
    end
elseif direction==3
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        col=col-1;
        if col<1
            col=numOfCols;
            row=row-1;
            if row<1
               row=numOfRows; 
            end
        end
    end
elseif direction==4
    key=1;
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        col=col+key;
        if col<1 || col>numOfCols
            col=col-key;
            row=row+1;row(row>numOfRows)=1;
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
        if col<1 || col>numOfCols
            col=col-key;
            row=row+1;row(row>numOfRows)=1;
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
        if col<1 || col>numOfCols
            col=col-key;
            row=row-1;row(row==0)=numOfRows;
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
        if col<1 || col>numOfCols
            col=col-key;
            row=row-1;row(row==0)=numOfRows;
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
        if row>numOfRows
            row=1;
            col=col+1;
            if col>numOfCols
               col=1; 
            end
        end
    end
elseif direction==9
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        row=row+1;
        if row>numOfRows
            row=1;
            col=col-1;
            if col<1
               col=numOfCols; 
            end
        end
    end
elseif direction==10
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        row=row-1;
        if row<1
            row=numOfRows;
            col=col+1;
            if col>numOfCols
               col=1; 
            end
        end
    end
elseif direction==11
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        row=row-1;
        if row<1
            row=numOfRows;
            col=col-1;
            if col<1
               col=numOfCols; 
            end
        end
    end
elseif direction==12
    key=1;
    while counter<messReq
        counter=counter+1;
        messPixelSeq(counter)=sub2ind(size(imCover),row,col);
        row=row+key;
        if row<1 || row>numOfRows
            row=row-key;
            col=col+1;col(col>numOfCols)=1;
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
        if row<1 || row>numOfRows
            row=row-key;
            col=col-1;col(col<1)=numOfCols;
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
        if row<1 || row>numOfRows
            row=row-key;
            col=col+1;col(col>numOfCols)=1;
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
        if row<1 || row>numOfRows
            row=row-key;
            col=col-1;col(col<1)=numOfCols;
            if key==1 
                key=-1 ;
            elseif key==-1
                key=1;
            end
        end
    end
end

end