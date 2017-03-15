addpath('./sift-0.9.12/sift');
toyImg = imread('data/toy.jpg');
toyImg = rgb2gray(toyImg);

images=['data/01.jpg'; 'data/02.jpg'; 'data/03.jpg'; 'data/04.jpg'; 'data/05.jpg'; ...
    'data/06.jpg'; 'data/07.jpg'; 'data/08.jpg'; 'data/09.jpg'; 'data/10.jpg' ;'data/11.jpg'];
images = string(images);
%for i = 1:10
   % threshold is 0.8 
% matches = a2q2b('./data/toy.jpg', './data/01.jpg'); 

imTest = imread('./data/01.jpg');
imgTest = rgb2gray(imTest);

[fRef, dRef] = sift(im2double(toyImg));
[fTest, dTest] = sift(im2double(imgTest));
d = dist2(dRef.', dTest.');
[n, m] = size(d);
thresh = 0.8;

counter = 1;
[d_sorted, d_index] = sort(d, 2);
for i = 1:n
    v_closest = d_index(i,1);
    v_second = d_index(i,2);
    ratio = d_sorted(i,1)./d_sorted(i,2);
    if ratio < thresh
        matches(counter, 1) = i;
        matches(counter, 2) = v_closest;
        counter = counter + 1;
    end
end

[numOfMatches, height] = size(matches);  

   % generating 3 random matches
   X = randi(numOfMatches);
   Y = 0;
   Z = 0; 
   
   while (X == Y || X == Z || Y == Z)
      Y = randi(numOfMatches);
      Z = randi(numOfMatches);
   end
   
  someMap = containers.Map({'fRef', 'fTest', 'rInd', 'tInd'}, {fRef, fTest, [matches(X,1), matches(Y,1), matches(Z,1)],[matches(X,2), matches(Y,2), matches(Z,2)]});
  P = affineMatrix(someMap); 
  P
%end