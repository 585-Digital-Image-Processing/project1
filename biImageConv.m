%%%%%%%%%%%%%  Function biImageConv %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Convert the grey image to a binary image
%      
% Input Variables:
%      A       MxN input 2D grey image 
%      
% Returned Results:
%      B       MxN output 2D binary image
%
% Processing Flow:
%      1. Set the threshold to divide each pixel into 0 or 1. 
%      2. If A(x,y)<threshold, then in the result image B, B(x,y) = 1,which 
%         represents the foreground (i.e. the circles).
%         Otherwise, B(x,y) = 0, which represents the background.
%
%  Restrictions/Notes:
%      The input image should be 2D grey image 
%
%  The following functions are called:
%      none
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function B = biImageConv(A)

% Set the threshold of gray level
level = 0.5;
value = level * 255;

%turn rgb gray picture to binary picture
% set the black and white color inversed
[m, n] = size(A);
B = zeros(m,n); 
for i = 1:m
    for j = 1:n
        if A(i,j) < value
            B(i,j) = 1;
        else
            B(i,j) = 0;
        end
    end
end
return