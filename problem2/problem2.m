image=imread('prob2.tiff');
image=rgb2gray(image(:,:,1:3));
C = corner(image);


im_double = im2double(iamge);
mask1 = [-1 0 1];
mask2 = [-1; 0; 1];

Ix = filter2(mask1, im_double);
Iy = filter2(mask2, im_double);

[row, col] = size(image);
[leng, a] = size(C);

for i=1:1:leng
	r = C(i, 1);
	c = C(i, 2);

	r_from = max(1, r-2);
	r_to = min(row, r+2);
	c_from = max(1, c-2);
	c_to = min(col, c+2);
    
end
