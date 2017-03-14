% SIFT features for reference.png and test.png
function out = a2q2b(DESCR1, DESCR2)
addpath('./sift-0.9.12/sift');
% read images and grayscale
imRef = imread(char(DESCR1));
imgRef = rgb2gray(imRef);
imTest = imread(char(DESCR2));
imgTest = rgb2gray(imTest);
 
% get frames and descriptors for images
    [fRef, dRef] = sift(im2double(imgRef));
    [fTest, dTest] = sift(im2double(imgTest));

 
% find matches
d = dist2(dRef.', dTest.');
[n, m] = size(d);
thresh = 0.8;


% calculate ratios and closest matches
[d_sorted, d_index] = sort(d, 2);

counter = 1;
for i = 1:n
    v_closest = d_index(i,1);
    v_second = d_index(i,2);
    ratio = d_sorted(i,1)./d_sorted(i,2);
    if ratio < thresh
        matches(counter, 1) = i;
        matches(counter, 2) = v_closest;
        counter = counter + 1;
      %  matches(i) = v_closest;
        ratios(i) = ratio;
    end
%     else
%         matches(i) = 0;
%         ratios(i) = Inf; % large number - we will be looking at minimums anyway
%     end
end
 
% get top 3 correspondences by choosing matches with lowest ratio
% [r_sorted, r_index] = sort(ratios);
% index = 1;
% top = [];
% for index = 1:3
%     ind = r_index(1, index);
%     top(ind) = matches(ind);
% end
%  
% indices = find(top > 0);
 
out = matches;
end