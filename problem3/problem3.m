data=load('match_points.mat');
image1=imread('prob3image1.tif');
image2=imread('prob3image2.tif');
[t_row, t_col, inlyers] = RANDSAC(image1, data.points_image_1, image2, data.points_image_2);
