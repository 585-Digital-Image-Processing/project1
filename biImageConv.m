function B = biImageConv(A)

% Set the threshold
level = 0.5;
value = level * 255;

%turn gray picture to binary picture
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