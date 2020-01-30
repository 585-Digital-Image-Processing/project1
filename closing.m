function A = closing(B)

% closing: to fill the white noise in the black disks
% [(-1,-1), (-1,0), (0,0), (0, -1)]
[m, n] = size(B);
B_dil= B;
A = B;
for i=2:m
    for j=2:n
        if ( B(i-1,j-1)==1 || B(i-1,j)==1 || B(i,j) == 1 || B(i, j-1) == 1)
            B_dil(i,j)=1;
        else
            B_dil(i,j)=0;
        end
    end
end


% Dilation
for i=1:m-1
    for j=1:m-1
        if (B_dil(i+1,j+1)==1 && B_dil(i+1,j)==1 && B_dil(i,j) == 1 && B_dil(i, j+1) == 1 )
            A(i,j)=1;
        else
            A(i,j)=0;
        end
    end
end
return