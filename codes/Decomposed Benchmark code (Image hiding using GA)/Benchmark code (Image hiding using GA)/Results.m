figure
imshow(uint8(imCover));
xlabel('The cover image');

figure
imshow(uint8(stego));
xlabel('The stego image');

format long
MSE=mse(stego(:)-imCover(:))
correlation=corr(stego(:),imCover(:))
stego1=uint8(stego);
imCover1=uint8(imCover);
ssimval=ssim(stego1,imCover1)
format short

fusedMeasure1=correlation*ssimval
fusedMeasure2=(correlation*ssimval)/MSE
