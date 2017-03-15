% Solve affine transformation between features using top 3 corresp. from a2q2b
function out = a2q2c(keypoints)
 
% entire reference sets
fRef = keypoints('fRef');
fTest = keypoints('fTest');
 
% keypoint indices
rInd = keypoints('rInd');
tInd = keypoints('tInd');
 
% point matrices [x1, x2, x3; y1, y2, y3]
pRef = [fRef(1:2, rInd(1):rInd(1)), fRef(1:2, rInd(2):rInd(2)), fRef(1:2, rInd(3):rInd(3))];
pTest = [fTest(1:2, tInd(1):tInd(1)), fTest(1:2, tInd(2):tInd(2)), fTest(1:2, tInd(3):tInd(3))];
 
tform = fitgeotrans(pTest.',pRef.','affine');


% We are using only 3 keypoints, so we will get the affine transformation a = P^-1 * P'
% P = []
% for i = 1:3
%     r1 = [pRef(1, i), pRef(2, i), 0, 0, 1, 0];
%     r2 = [0, 0, pRef(1, i), pRef(2, i), 0, 1];
%     P = [P; r1; r2];
% end
%  
% P_prime = [pTest(1,1); pTest(2,1); pTest(1,2); pTest(2,2); pTest(1,3); pTest(2,3)];
%  
% out = inv(P)*P_prime;
out = tform;
end