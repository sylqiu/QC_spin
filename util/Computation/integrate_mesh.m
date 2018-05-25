function new_vertex = integrate_mesh(v,f,omega)%,landmark,target)
L = cotmatrix(v,f);
%if isempty(landmark)
    LL = [L,ones(size(L,1),1);ones(1,size(L,1)),0];
    Omega = [omega;0,0,0,0];
    new_vertex = LL\Omega;
    new_vertex = full(new_vertex);
    new_vertex = new_vertex(1:end-1,2:end);
    
% else
%     LL = L;
%     Omega = omega - LL(:,landmark)*target;
%     Omega(landmark,:) = target;
%     LL(landmark,:) = 0; 
%     LL(:,landmark) = 0; 
%     LL = LL + sparse(landmark,landmark,ones(length(landmark),1), size(LL,1), size(LL,2));
%     new_vertex = LL\Omega;
%     new_vertex = full(new_vertex);
%     new_vertex = new_vertex(1:end,2:end);
end