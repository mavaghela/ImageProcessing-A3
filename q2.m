addpath('./sift-0.9.12/sift');
toyImg = imread('data/toy.jpg');
toyImg = rgb2gray(toyImg);

allTimeBestMatrix = [];
allTimeBestInliers = 0;

images=['data/01.jpg'; 'data/02.jpg'; 'data/03.jpg'; 'data/04.jpg'; 'data/05.jpg'; ...
    'data/06.jpg'; 'data/07.jpg'; 'data/08.jpg'; 'data/09.jpg'; 'data/10.jpg' ;'data/11.jpg'];
images = string(images);

for i = 1:11
    imTest = imread(char(images(i)));
    imgTest = rgb2gray(imTest);

    [fRef, dRef] = sift(im2double(toyImg));
    [fTest, dTest] = sift(im2double(imgTest));
    d = dist2(dRef.', dTest.');
    [n, m] = size(d);
    thresh = 0.8;

    counter = 1;
    [d_sorted, d_index] = sort(d, 2);
    for j = 1:n
        v_closest = d_index(j,1);
        v_second = d_index(j,2);
        ratio = d_sorted(j,1)/d_sorted(j,2);
        if ratio < thresh
            matches(counter, 1) = j;
            matches(counter, 2) = v_closest;
            counter = counter + 1;
        end
    end

    [numOfMatches, height] = size(matches);  
    imgBestMatrix =[];
    imgMaxInliers = 0;
    for f = 1: 400
        % generating 3 random matches
        X = randi(numOfMatches);
        Y = 0;
        Z = 0; 

       while (X == Y || X == Z || Y == Z)
          Y = randi(numOfMatches);
          Z = randi(numOfMatches);
       end
        
       rInd = [matches(X,1), matches(Y,1), matches(Z,1)];
       tInd = [matches(X,2), matches(Y,2), matches(Z,2)]; 
       
       % point matrices [x1, x2, x3; y1, y2, y3]
       pRef = [fRef(1:2, rInd(1):rInd(1)), fRef(1:2, rInd(2):rInd(2)), fRef(1:2, rInd(3):rInd(3))];
       pTest = [fTest(1:2, tInd(1):tInd(1)), fTest(1:2, tInd(2):tInd(2)), fTest(1:2, tInd(3):tInd(3))];
       matrix = fitgeotrans(pTest.', pRef.', 'affine');
        
       inliers = 0;
       for k = 1:numOfMatches 
          distance = dist2((matrix.T * [fRef(1:2, matches(k,1):matches(k,1));1]).', [fTest(1:2, matches(k,2):matches(k,2));1].');
          if(distance <= 100)
             inliers = inliers + 1;
          end
       end
       if(inliers > imgMaxInliers)
          imgMaxInliers = inliers;
          imgBestMatrix = matrix;
       end
    end

    if(imgMaxInliers > allTimeBestInliers)
        allTimeBestInliers = imgMaxInliers;
        allTimeBestMatrix = imgBestMatrix;
    end
end