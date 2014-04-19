i1 = imread('prob1image1.jpg');
i2 = imread('prob1image2.jpg');
imgA = rgb2gray(i1);
imgB = rgb2gray(i2);
maxPts = 150;
ptThresh = 1e-3;
hCD = vision.CornerDetector( ...
    'Method','Local intensity comparison (Rosen & Drummond)', ...
    'MaximumCornerCount', maxPts, ...
    'CornerThreshold', ptThresh, ...
    'NeighborhoodSize', [9 9]);
pointsA = step(hCD, imgA);
pointsB = step(hCD, imgB);

%cvexShowImagePair(imgA, imgB, 'Corners in A', 'Corners in B', ...
%    'SingleColor', pointsA, pointsB);

 % Extract features for the corners
blockSize = 9; % Block size.
[featuresA, pointsA] = extractFeatures(imgA, pointsA, ...
    'BlockSize', blockSize);
[featuresB, pointsB] = extractFeatures(imgB, pointsB, ...
    'BlockSize', blockSize);

% Match features which were found in the current and the previous frames
indexPairs = matchFeatures(featuresA, featuresB, 'Metric', 'SSD');
numMatchedPoints = cast(size(indexPairs, 2), 'int32');
pointsA = pointsA(:, indexPairs(1, :));
pointsB = pointsB(:, indexPairs(2, :));
cvexShowMatches(imgA, imgB, pointsA, pointsB, 'A', 'B', 'RC');