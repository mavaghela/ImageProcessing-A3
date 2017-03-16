im = imread('shoe.jpg');

% The points of the bill
xImgBill = [1067.1, 1367.0, 1164.6, 774.8]';
yImgBill = [511.0, 584.8, 1130.3, 981.8]';

% Actual size of the bill
xActualBill = [1, 1524, 1524, 1]';
yActualBill = [1, 1, 698, 698]';

tform = maketform('projective',[xImgBill,yImgBill],[xActualBill,yActualBill]);

[imrec] = imtransform(im, tform, 'bicubic','XYScale',1);

imshow(imrec);
disp('Click on the length of the shoe. Double click the last point');
[xLength,yLength] = getpts();
disp('Click on the width of the shoe. Double click the last point');
[xWidth,yWidth] = getpts();

length = sqrt((xLength(1) - xLength(2))^2 + (yLength(1) - yLength(2))^2)/100;
width = sqrt((xWidth(1) - xWidth(2))^2 + (yWidth(1) - yWidth(2))^2)/100;
