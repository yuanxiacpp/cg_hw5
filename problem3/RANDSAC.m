function [t_row, t_col, inlyers] = RANDSAC(image1, points_image1, image2, points_image2)
  [a, leng] = size(points_image1);
  points_image1 = int16(points_image1);
  points_image2 = int16(points_image2);
  maxCount = 0;
  for track=1:1:5
	 idx = randi([1,leng]);
	 tx = points_image2(1,idx)-points_image1(1,idx);
	 ty = points_image2(2,idx)-points_image1(2,idx);
     
	 tinlyers = [];
	 for i=1:1:20
     	if ((points_image1(1,i)+tx == points_image2(1,i)) & (points_image1(2,i)+ty == points_image2(2,i)))
		    tinlyers=[tinlyers i];
		end
	 end
	 [a, count] = size(tinlyers);
	 if (count > maxCount)
     	maxCount = count;
	    t_row = tx;
	    t_col = ty;
		inlyers = tinlyers;
     end
  end
  
  [t_col, t_row]  

  inlyers
end
