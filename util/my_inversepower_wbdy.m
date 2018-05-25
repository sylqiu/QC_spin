function eigvec = my_inversepower_wbdy(M, v, maxiter, bdy_ind)

eigvec = sparse(4*size(v,1)-2*length(bdy_ind),1);
%     L = 1:length(bdy_ind);
    if ismember(1,bdy_ind)
        J = [1,2];
    else
        J = [1,4];
    end
    
    for i = 2:size(v,1)
        if ismember(i,bdy_ind)
            J = [J;J(end,2)+1,J(end,2)+2];
        else
            J = [J;J(end,2)+1,J(end,2)+4];
        end
    end
    
    for i = 1:size(v,1)
         if ismember(i,bdy_ind)
%              which = L(bdy_ind == i);
             eigvec(J(i,1):J(i,2)) = [1;1];
         else
             eigvec(J(i,1):J(i,2)) = [1,0,0,0]';
         end
    end
% eigvec = repmat([1;0;0;0],size(M,1)/4,1);
for i = 1:maxiter
    eigvec = eigvec./norm(eigvec);
    eigvec = M\eigvec;
end
eigvec = eigvec./norm(eigvec);
end