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


% Step1: Load the image f
f=imread('RandomDisks-P10.jpg');
figure()
imshow(f);
title('Original Image');

% Step 2: Convert the original rgb image to gray level
f1 = f(:,:,1);
% convert gray image to binary image
f2= biImageConv(f1); 
figure()
imshow(f2);
title('Binary image');

% Step3: use opening and closing to remove noise at the background and
% inside circles

% Opening: Remove the noise outside circles at the background with 
% structural element {(-1,-1), (-1,0)}
B_open = opening(f2);
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
% in B biggest (radius = 10), then we can detect the smallest circles which
% are not round enough.
% generate structure element A
[r1, c1]=meshgrid(1:19);
A=sqrt((r1-floor(19/2)).^2+(c1-floor(19/2)).^2)<8;
% generate structure element B
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

% generate structuring element A_biggest
[r1, c1]=meshgrid(1:65);
A_biggest=sqrt((r1-floor(65/2)).^2+(c1-floor(65/2)).^2)<31;
% generate structuring element B_biggest
[r2, c2]=meshgrid(1:69);
B_biggest_temp=sqrt((r2-floor(69/2)).^2+(c2-floor(69/2)).^2)<33;
B_biggest=xor(B_biggest_temp,1);


% show structuring elements in finding smallest and biggest disks
figure()
subplot(1,4,1);
imshow(A);
title('A-smallest');
subplot(1,4,2);
imshow(B);
title('B-smallest');
subplot(1,4,3);
imshow(A_biggest);
title('A-biggest');
subplot(1,4,4);
imshow(B_biggest);
title('B-biggest');

% Find the biggest circles and show their positions
left_biggest=erosion(new_B,A_biggest);
right_biggest=erosion(new_B_c,B_biggest);
biggest=bitand_s(left_biggest,right_biggest);
figure()
imshow(biggest);
title('Position of Biggest Disks');








