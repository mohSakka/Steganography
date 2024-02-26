function smoothness = calcSmoothness(image)
[dx,dy] = gradient(double(image));
grad =  mean(mean((dy+dx).^2)/255);
smoothness = 1-grad;
end