% Read biometric image
imSec=double(message);                            

% Read the cover image
% global imCover
% imCover=imread(coverImageName);
% imCover=double(imCover);


global imCover
imCover=imread(coverImageName);
if(size(imCover,3)==3)
    imCover=imresize (imCover,[512 512]);
    imCover=rgb2gray(imCover);
end
    imCover=double(imCover);
