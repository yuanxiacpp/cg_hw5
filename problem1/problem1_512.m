imgA=imread('prob1image1.jpg');
[featuresA, pointsA] = harris_512(imgA);

imgB=imread('prob1image2.jpg');
[featuresB, pointsB] = harris_512(imgB);

imgA = rgb2gray(imgA);
imgB = rgb2gray(imgB);

% maxPts = 150;
% ptThresh = 1e-3;
% hCD = vision.CornerDetector( ...
%     'Method','Local intensity comparison (Rosen & Drummond)', ...
%     'MaximumCornerCount', maxPts, ...
%     'CornerThreshold', ptThresh, ...
%     'NeighborhoodSize', [15 15]);
% pointsA = step(hCD, imgA);
% pointsB = step(hCD, imgB);

%cvexShowImagePair(imgA, imgB, 'Corners in A', 'Corners in B', ...
%    'SingleColor', pointsA, pointsB);

 % Extract features for the corners
% blockSize = 15; % Block size.
% [featuresA, pointsA] = extractFeatures(imgA, pointsA, ...
%     'BlockSize', blockSize);
% [featuresB, pointsB] = extractFeatures(imgB, pointsB, ...
%     'BlockSize', blockSize);

% Match features which were found in the current and the previous frames

indexPairs = matchFeatures(featuresA, featuresB, 'Metric', 'SSD');
numMatchedPoints = cast(size(indexPairs, 2), 'int32');
pointsA = pointsA(:, indexPairs(1, :));
pointsB = pointsB(:, indexPairs(2, :));
cvexShowMatches(imgA, imgB, pointsA, pointsB, 'A', 'B', 'RC');