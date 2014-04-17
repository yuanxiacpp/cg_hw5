	function blend = multiresolution_blend(left, right)
	left = im2double(left);
	right = im2double(right);

	H = fspecial('gaussian', [800, 800], 50);
	left_high1 = imfilter(left, H);
	left_low1 = left - left_high1;
	left_high2 = imfilter(left_high1, H);
	left_low2 = left_high1 - left_high2;


	right_high1 = imfilter(right, H);
	right_low1 = right - right_high1;
	right_high2 = imfilter(right_high1, H);
	right_low2 = right_high1 - right_high2;

	[row, col, a] = size(left);

	col_left = round(col/2);
	col_right = col - col_left;	

	l_pyramid = [ones(row, col_left, 3) zeros(row, col_right, 3)];
	r_pyramid = [zeros(row, col_right, 3) ones(row, col_left, 3)];

	l_pyramid1 = imfilter(l_pyramid, H);
	l_pyramid2 = imfilter(l_pyramid1, H);

	r_pyramid1 = imfilter(r_pyramid, H);
	r_pyramid2 = imfilter(r_pyramid1, H);

	blend_high1 = left_high1.*l_pyramid1 + right_high1.*r_pyramid1;
	blend_low1 = left_low1.*l_pyramid1 + right_low1.*r_pyramid1;

	blend_high2 = left_high2.*l_pyramid2 + right_high2.*r_pyramid2;
	blend_low2 = left_low2.*l_pyramid2 + right_low2.*r_pyramid2;

	blend = blend_low1 + blend_high2 + blend_low2;

	%imshow(blend);
	imwrite(blend, 'blend-800-50.jpg');
end
