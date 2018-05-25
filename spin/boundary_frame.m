function [ind,T,N,B,component_index] = boundary_frame(f,v)
% create a frame for each vertex on the boundary
% f = adjust_orientation(f);
[ind,~,component_index,num_bdycomp] = correct_boundary_faces(f);
bdy_v = v(ind,:);
T = [];
N = zeros(size(ind,1),3);
for j = 1:num_bdycomp
    T = [T; 0.5*(- bdy_v([component_index(j+1),component_index(j)+1:component_index(j+1)-1],:)+...
        bdy_v([(component_index(j)+2):component_index(j+1),component_index(j)+1],:))];
    
    %to find the normal, first find the faces that contain the boudnary
    %vertices
    bdy_f_ind = find_tri_by_vertex(f,ind);
    
    for i = component_index(j)+1:component_index(j+1)
        pre_N = normals(v,f(bdy_f_ind{i},:));
        pre_N = pre_N./repmat(sqrt(sum(pre_N.^2,2)),1,size(pre_N,2));
        N(i,:) = sum(pre_N,1)/size(pre_N,1);
    end
end
T = T./repmat(sqrt(sum(T.^2,2)),1,size(T,2));
B = cross(T,N,2);

figure(1);axis equal;hold on;
quiver3(bdy_v(:,1),bdy_v(:,2),bdy_v(:,3),T(:,1),T(:,2),T(:,3));
quiver3(bdy_v(:,1),bdy_v(:,2),bdy_v(:,3),N(:,1),N(:,2),N(:,3));
quiver3(bdy_v(:,1),bdy_v(:,2),bdy_v(:,3),B(:,1),B(:,2),B(:,3));
hold off;
end