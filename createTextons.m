function [textons] = createTextons(imStack, bank, k)
% Given a cell array imStack of length n containing a series of n grayscale 
% images and a filter bank, compute a texton "codebook" (i.e., set of quantized 
% filter bank responses) based on a sample of filter responses from all n 
% images.
  [h, w, n] = size(imStack);
  [m, m, d] = size(bank);
  
  % Create a stack of filter responses.
  % Each pixel in each of n images has a feature vector of size d.
  R = zeros(h, w, n, d);
  for i = 1:n
    I = imStack(:, :, i);
    R(:, :, i) = imfilter(I, bank);
  end
  npixel = h * w * n;
  R = reshape(R, [npixel d]);
  
  % k-means clustering of features.
  % Sample a subset, in order to reduce complexity.
  samplesize = int32(npixel * 0.7);
  S = R(randperm(npixel, samplesize), :); 
  [idx, C] = kmeans(S, k, 'MaxIter', 1000);
  textons = C;
return
