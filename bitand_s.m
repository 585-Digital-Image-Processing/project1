
function C = bitand_s(A, B)

C=(zeros(size(A)));
for i=1:size(A,1)
    for j=1:size(A,2)
        if A(i,j)==B(i,j)
            C(i,j)=A(i,j);
        else
            C(i,j)=0;
        end
    end
end

return

