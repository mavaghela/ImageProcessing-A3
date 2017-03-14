addpath('./sift-0.9.12/sift');
toyImg = imread('data/toy.jpg');
toyImg = rgb2gray(toyImg);

images=['data/01.jpg'; 'data/02.jpg'; 'data/03.jpg'; 'data/04.jpg'; 'data/05.jpg'; ...
    'data/06.jpg'; 'data/07.jpg'; 'data/08.jpg'; 'data/09.jpg'; 'data/10.jpg' ;'data/11.jpg'];
images = string(images);
%for i = 1:10
   % threshold is 0.8 
   matches = a2q2b('./data/toy.jpg', './data/01.jpg'); 
   
%end