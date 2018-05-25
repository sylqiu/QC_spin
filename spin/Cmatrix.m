function C = Cmatrix(v,V_tilde,bdy_ind)
% C is 4#v x(4#v-2#bdy_ind) matrix
    C = sparse(4*size(v,1),4*size(v,1)-2*length(bdy_ind));
    L = 1:length(bdy_ind);
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
             which = L(bdy_ind == i);
             C(4*(i-1)+1:4*i,J(i,1):J(i,2)) = [1,0;0,V_tilde(which,1);...
                 0,V_tilde(which,2);0,V_tilde(which,3)];
         else
             C(4*(i-1)+1:4*i,J(i,1):J(i,2)) = toReal([1,0,0,0]);
         end
    end
end