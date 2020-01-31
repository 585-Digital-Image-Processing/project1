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