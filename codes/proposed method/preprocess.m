function newImg = preprocess(img)
newImg = img;
newImg = imresize (newImg,[512 512]);
if(size(img,3)==3)  
    newImg = rgb2gray(newImg);
end
    newImg = double(newImg);
     m = max(max(newImg));
     n = min(min(newImg));
     d = m-n;
     newImg = newImg - n;
     newImg = newImg * 255;
     newImg = newImg/d;
     newImg = uint8(newImg);
end