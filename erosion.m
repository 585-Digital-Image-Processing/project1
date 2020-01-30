%%%%%%%%%%%%%  Function erosion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute erosion of an input image X with respect to an input 
%      structural element A. Note that the dimension of the structuring 
%      element must be odd, so that A = A^s is possible
%      
%
% Input Variables:
%      X       MxN input 2D binary image to be eroded
%      A       rxc structural element, r and c are both odd
%      
% Returned Results:
%      B       Result after erosion
%
% Processing Flow:
%      1.  Padding image with 0s, so that the border of the image could 
%          processed propery
%      2.  For each valid pixel (x,y) in X, check whether the stucturing 
%          element A can be included in X after translate with (x,y)
%             If yes, in the erosion image B, B(x,y) = 1
%             Otherwise, B(x,y) = 0
%
%  Restrictions/Notes:
%      This function only takes an structuring element of odd dimensions.  
%
%  The following functions are called:
%      none
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function B = erosion(X, A)

% padding X with 0s
[r, c] = size(A);
X = padarray(X, [floor(r/2) floor(c/2)],0);

% Find the original border position of the X
[m, n] = size(X);
rlow = floor(r/2)+1;
rhigh = m - floor(r/2);
clow = floor(c/2)+1;
chigh = n - floor(c/2);

% Compute the new erosion image B:

% Fill B with mxn zeros
B = zeros(m,n);

% For each pixel (x,y) in X, check whether A will be included in X after
% A being translated with (x,y) (A_(x,y) included in A or not)
% If yes, B(x,y) = 1, otherwise = 0
for i = rlow:rhigh
    for j = clow:chigh
        % take A_(x,y) out, and store it in region
        region = X(i-floor(r/2): i + floor(r/2), j - floor(c/2):j + floor(c/2));
        % check whether region is the the same with A using matric & operation
        temp = region&A;
        B(i,j) = all(temp(:) == A(:));
    end
end
% Remove all the paddings in B
B = B(rlow:rhigh, clow:chigh);
return

