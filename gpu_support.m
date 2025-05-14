X = [-15:15 0 -15:15 0 -15:15];
gpuX = gpuArray(X);
whos gpuX


gpuE = expm(diag(gpuX,-1)) * expm(diag(gpuX,1));
gpuM = mod(round(abs(gpuE)),2);
gpuF = gpuM + fliplr(gpuM);


imagesc(gpuF);
colormap(flip(gray));


result = gather(gpuF);
whos result


