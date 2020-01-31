%%%%%%%%%%%%% main.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Realize Hit-or-miss  
%
% Input Variables:
%      f            input 2D rgb image
%
%      
% Returned Results:
%      B            A binary image of f
%      new_B        Image B after noise removal
%      smallest     An image indicating locations of smallest circles in B
%      biggest      An image indicating locations of biggest circles in B
%
% Processing Flow:
%      1.  Load and display input image
%      2.  Compute and write clipped version of input image
%      3.  Compute and display 3x3 neighborhood-average of input image
%          
%
%  Restrictions/Notes:
%      This function requires an 8-bit image as input.  
%
%  The following functions are called:
%      zero.m       create an image full of zeroes
%      mean3x3.m    filter with a 3x3 mean filter
%          worked into the code below - try to do this yourself
%
%  Author:      Yanxi Yang, Jiuchao Yin, Hongjie Liu
%  Date:        1/30/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Step1: Load the image f, and take its gray layer
f=imread('RandomDisks-P10.jpg');
f1 = f(:,:,1);
imshow(f1);
title('Original Image');

% Step 2: Convert the gray image to binary image B and show it
B = biImageConv(f1); 
figure()
imshow(B);
title('Binary image');

% Step3: use opening and closing to remove noise at the background and
% inside circles

% Opening: Remove the noise outside circles at the background with 
% structural element {(-1,-1), (-1,0)}
B_open = opening(B);
figure();
imshow(B_open);
title('Opening')

% closing: fill the cavities inside circles with structural element
%{(-1,-1), (-1,0), (0,0), (0, -1)}, and show it
new_B = closing(B_open);
figure();
imshow(new_B);
title('closing')

% Step 4: find all circles in the image and get their centers and radius
% with imfindcircles
figure()
imshow(new_B);
title('radius identification');
[c, r]=imfindcircles(new_B, [3, 50], 'Sensitivity', 0.9);
viscircles(c, r, 'EdgeColor', 'b');
% Extract the max radius and min radius
max_r=round(max(r));
min_r=round(min(r));

% Step 5: Find the smallest circles

% First: generate structuring element A and B
% because of the deviation, so we make A smaller (radius = 8), and the hole 
% in B bigger (radius = 10), then we can detect the smallest circles which
% are not round enough.
% generate A
[r1, c1]=meshgrid(1:19);
A=sqrt((r1-floor(19/2)).^2+(c1-floor(19/2)).^2)<8;
% generate B
[r2, c2]=meshgrid(1:21);
B_temp=sqrt((r2-floor(21/2)).^2+(c2-floor(21/2)).^2)<10;
B=xor(B_temp,1);

% Second: generate the complement of the image
new_B_c=xor(new_B,1);

% find the smallest circles and show their positions
left=erosion(new_B,A);
right=erosion(new_B_c,B);
smallest=bitand_s(left,right);
figure()
imshow(smallest);
title('Position of Smallest Disks');

% Step 6: find the biggest circles

% generate A
[r1, c1]=meshgrid(1:65);
A_bigger=sqrt((r1-floor(65/2)).^2+(c1-floor(65/2)).^2)<31;
% generate B
[r2, c2]=meshgrid(1:69);
B_bigger_temp=sqrt((r2-floor(69/2)).^2+(c2-floor(69/2)).^2)<33;
B_bigger=xor(B_bigger_temp,1);

% Find the biggest circles and show their positions
left_bigger=erosion(new_B,A_bigger);
right_bigger=erosion(new_B_c,B_bigger);
biggest=bitand_s(left_bigger,right_bigger);
figure()
imshow(biggest);
title('Position of Biggest Disks');








