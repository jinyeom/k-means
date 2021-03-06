function [labelIm] = quantizeFeats(featIm, meanFeats)
% Given an (h, w, d) matrix featIm, where h and w are the height and width of 
% the original image and d denotes the dimensionality of the feature vector 
% already computed for each of its pixels, and given a (k, d) matrix meanFeats
% of k cluster centers, each of which is a d-dimensional vector (a row in the 
% matrix), map each pixel in the input image to its appropriate k-means center.
  if size(featIm , 3) ~= size(meanFeats, 2)
    error('featIm and meanFeats must have the same feature length.')
  end

  [h, w, d] = size(featIm);
  [k, d] = size(meanFeats);
  
  % For each feature at (i, j), assign the index of the closest mean.
  labelIm = zeros(h, w);
  for i = 1:h
    for j = 1:w
      F = reshape(featIm(i, j, :), 1, d);
      dists = dist2(meanFeats, F);
      [minval, row] = min(dists);
      labelIm(i, j) = row;
    end
  end
return