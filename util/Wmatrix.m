function W = Wmatrix(v,bdy_ind,theta,V,V_tilde)
    W = sparse(4*size(v,1),4*size(v,1));
    w = zeros(size(V));
    for j = 1:size(V,1)
        if sum(cross(V(j,:),V_tilde(j,:)).^2)~=0 && theta(j)~=0
            w(j,:) = cross(V(j,:),V_tilde(j,:))./repmat(sin(theta(j)),1,3);
        else
            w(j,:) = [0,0,1];
        end   
    end
    
    L = 1:length(bdy_ind);
    for i = 1:size(v,1)
       if ismember(i,bdy_ind)
           which = L(bdy_ind == i);
           c = cos(0.5*theta(which));
           s = sin(0.5*theta(which));
           W(4*(i-1)+1:4*i,4*(i-1)+1:4*i) = toReal([c, s*w(which,:)]);
       else
           W(4*(i-1)+1:4*i,4*(i-1)+1:4*i) = toReal([1,0,0,0]);
       end
    end
end

