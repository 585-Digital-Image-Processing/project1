%%%%%%%%%%%%%  Function opening %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute opening of an input image X with respect to an input 
%      structural element A. Note that the dimension fo the  structural 
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
%      2.  For each valid pixel (x,y) in X, check whether the stuctural 
%          element A can be included in X after translate with (x,y)
%             If yes, in the erosion image B, B(x,y) = 1
%             Otherwise, B(x,y) = 0
%
%  Restrictions/Notes:
%      This function only takes an structural element of odd dimensions.  
%
%  The following functions are called:
%      none
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function X = opening(B)

[m, n] = size(B);
B_ero= B;
X = B;
% opening: to remove the black noise in background
% B = [(-1,-1), (-1,0)]
% Bs = [(1,1), (1,0)]
% close
% erosion
for i=2:m
    for j=2:n
        if ( B(i-1,j-1)==1 && B(i-1,j)==1)
            B_ero(i,j)=1;
        else
            B_ero(i,j)=0;
        end
    end
end

% Dilation
for i=1:m-1
    for j=1:n-1
        if (B_ero(i+1,j+1)==1 || B_ero(i+1,j)==1 )
            X(i,j)=1;
        else
            X(i,j)=0;
        end
    end
end
return
