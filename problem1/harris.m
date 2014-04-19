function [feature_row, feature_col] = harris(image)
	
	feature_row = [];
	feature_col = [];

	image = im2double(rgb2gray(image));

	mask1 = [-2 -1 0 1 2];
	mask2 = [-2; -1; 0; 1; 2];

	Ix = filter2(mask1, image);
	Iy = filter2(mask2, image);
	Ixx = Ix .* Ix;
	Iyy = Iy .* Iy;
	Ixy = Ix .* Iy;

	mask3 = double(ones(15))/225;

	Ixx = filter2(mask3, Ixx);
	Ixy = filter2(mask3, Ixy);
	Iyy = filter2(mask3, Iyy);

	[row, col] = size(Ixx);

	R = double(zeros(row, col));
	R_threshold = zeros(row, col);

	for i=1:1:row
		for j=1:1:col
			R(i,j) = Ixx(i,j)*Iyy(i,j)-Ixy(i,j)^2 - 0.04*(Ixx(i,j)+Iyy(i,j))^2;
			if (R(i,j) > 0.2)
				R_threshold(i,j) = 255;
			end
		end
	end
	
	for i=1:1:row
		for j=1:1:col
			r_from = max(1, i-7);
			r_to = min(row, i+7);
			c_from = max(1, j-7);
			c_to = min(col, j+7);

			%find min of
			flag = true; 
			for r=r_from:1:r_to
				for c=c_from:1:c_to
					if (R(i,j) < R(r,c))
						flag = false;
						break;
					end
				end
			end

			if (flag == true & R_threshold(i,j) == 255)
				feature_row = [feature_row i];
				feature_col = [feature_col j];
			else
				R_threshold(i,j)=0;
			end

		end
	end

	%imwrite(R_threshold, 'image2_feature_points.jpg');

end