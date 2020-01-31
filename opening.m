%%%%%%%%%%%%%  Function opening %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute opening of an input image X with respect to the defined
%      structural element B {(-1,-1), (-1,0)}.
%      
% Input Variables:
%      X       MxN input 2D binary image
%      
% Returned Results:
%      A       image X after openning by the structure element
%              B = {(-1,-1), (-1,0)}
%
% Processing Flow:
%      1.  Compute erosion of image X with respect to the structure
%      element B. The basic idea is: 
%           - for each pixel (i,j) in X, check whether B translated by (i,j), 
%           which is B_(i,j), is included in X or not.
%           - If yes, pixel (i,j) is in the new image X_ero after erosion.
%           Otherwise, pixel (i,j) is not in X_ero.
%      2. Compute dilation of X_ero with respect to B_s. The basic idea is: 
%           - for each pixel (i,j) in X, check whether B translated by (i,j), 
%           which is B_(i,j), hits X or not.
%           - If yes, pixel (i,j) is present in the new image A after dilation.
%           Otherwise, it is not in A. 
%
%  Restrictions/Notes:
%      X should be binary image.  
%
%  The following functions are called:
%      none
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function A = opening(X)

% Get the size of X
[m, n] = size(X);

% Compute erosion of X by the structure element 
% B = {(-1,-1), (-1,0)}, and store it in X_ero

X_ero= X;
for i=2:m
    for j=2:n
        % check whether B_(i,j) is included in X or not
        % If yes, X_ero(i,j) is 1; otherwise X_ero(i,j) is 0.
        if ( X(i-1,j-1)==1 && X(i-1,j)==1)
            X_ero(i,j)=1;
        else
            X_ero(i,j)=0;
        end
    end
end

% Compute dilation of X_ero by the structure element 
% B = {(1,1), (1,0)}, and store it in A
A = X;
for i=1:m-1
    for j=1:n-1
        % check whether B_(i,j) hits X or not
        % If yes, A(i,j) is 1; otherwise A(i,j) is 0.
        if (X_ero(i+1,j+1)==1 || X_ero(i+1,j)==1 )
            A(i,j)=1;
        else
            A(i,j)=0;
        end
    end
end
return
