image=imread('prob2.tiff');
image=double(rgb2gray(image(:,:,1:3)));
C = corner(image);


im_double = im2double(image);
mask1 = [-1 0 1];
mask2 = [-1; 0; 1];

Ix = filter2(mask1, im_double);
Iy = filter2(mask2, im_double);

%theta = atan2(Iy, Ix);


[row, col] = size(image);
[leng, a] = size(C);

bin_all = [];


for i=1:1:leng
	c = C(i, 1);
	r = C(i, 2);

	r_from = max(1, r-2);
	r_to = min(row, r+2);
	c_from = max(1, c-2);
	c_to = min(col, c+2);
    
    bin = double(zeros(10,1));
    
    for x=r_from:1:r_to
        for y=c_from:1:c_to
            radian = atan2(Iy(x,y), Ix(x,y));
            theta = double(0);
            if (radian >= 0)
                theta = radian*360/(2*pi);
            else
                theta = (2*pi+radian)*360/(2*pi);
            end

        	mag = sqrt(Ix(x,y)^2+Iy(x,y)^2);
        	%[radian theta]

            idx = int8(round(theta/36.0));
            if (idx== 0)
                idx = int8(1);
            end
            
            bin(idx) = bin(idx) + mag;
        end
    end
    bin_all = [bin_all bin];
end

transpose(bin_all)

% [bin_length, C_length] = size(bin_all);

% imshow(image);
% hold on;
% for p=1:1:C_length
%     bin = bin_all(:,[p]);

%     for i=1:1:bin_length
%         w = bin(i)/23;
%         quiver(C(p,1), C(p,2), w*cosd(i*36), w*sind(i*36));
%     end
% end
% hold off;


%[leng count]
