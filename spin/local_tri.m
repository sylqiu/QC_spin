function loc_tri = local_tri(face,vertex,mu,coord)
%assume triangle is oriented counter_clockwisely (or consistently)
if isempty(coord);
    coord = face;
end
% rotate edge_21 to the x-axis and edge_31 counter-clockwise to
% edge coord_31 with angle given by that triangle
edge_21 = vertex(coord(:,2),:)-vertex(coord(:,1),:);
edge_31 = vertex(coord(:,3),:)-vertex(coord(:,1),:);
pre_angle_1 = acos((sum(edge_21.*edge_31,2)./(sqrt(sum(edge_21.*edge_21,2)).*sqrt(sum(edge_31.*edge_31,2)))));

%each local triangle has first and second vertices =(0,0), (1,0), so only record the 3rd vertex
pre_local_tri = [sqrt(sum(edge_31.*edge_31,2))./sqrt(sum(edge_21.*edge_21,2)).*cos(pre_angle_1),...
    sqrt(sum(edge_31.*edge_31,2))./sqrt(sum(edge_21.*edge_21,2)).*sin(pre_angle_1)];
% same with relative coordinate...

%compute new coordinate of the third vertex
re = real(mu);
im = imag(mu);
% fk = face(:,3);
% fi = face(:,1);
% fj = face(:,2);
%Ai is the negative of y-coord of vector edge i, etc
% A1 = vertex(fk,2) - vertex(fi,2); 
A1 = pre_local_tri(:,2);
% A2 = vertex(fi,2) - vertex(fj,2);
A2 = 0*ones(size(face,1),1);
% B1 = vertex(fi,1) - vertex(fk,1);
B1 = -pre_local_tri(:,1);
% B2 = vertex(fj,1) - vertex(fi,1);
B2 = ones(size(face,1),1);
%solve for v2'
A = sparse(length(face(:,1))*2,length(face(:,1))*2);
for i = 1:length(face(:,1))
    A(2*i-1,2*i-1) = re(i)*A2(i) +im(i)*B2(i) - A2(i);
    A(2*i-1,2*i) = re(i)*B2(i)  -im(i)*A2(i) + B2(i);
    A(2*i,2*i-1) = -re(i)*B2(i) +im(i)*A2(i) - B2(i);
    A(2*i,2*i) = re(i)*A2(i) +im(i)*B2(i) - A2(i);
end

b = zeros(length(face(:,1))*2,1);
b(1:2:end) = (1-re).*A1 - im.*B1;
b(2:2:end) = (1+re).*B1 - im.*A1;
v3_tilde = A\b;  
% v3_tilde = [v3_tilde(1:2:end),v3_tilde(2:2:end)];
%solve for v3_tilde = a*v1 + b*v2
BB = sparse(length(face(:,1))*2,length(face(:,1))*2);
for i = 1:length(face(:,1))
    BB(2*i-1,2*i-1) = 1;
    BB(2*i-1,2*i) = pre_local_tri(i,1);
    BB(2*i,2*i-1) = 0;
    BB(2*i,2*i) = pre_local_tri(i,2);
end
ab = BB\v3_tilde;
% ab = reshape(ab,2,size(face,1));

%converting back to edges
CC = sparse(3*size(face,1),2*size(face,1));
for i = 1:size(face,1)
    CC(3*i-2,2*i-1) = edge_21(i,1);
    CC(3*i-1,2*i-1) = edge_21(i,2);
    CC(3*i,2*i-1) = edge_21(i,3);
    CC(3*i-2,2*i) = edge_31(i,1);
    CC(3*i-1,2*i) = edge_31(i,2);
    CC(3*i,2*i) = edge_31(i,3);
end
new_edge_31 = CC*ab;
new_edge_31 = reshape(new_edge_31,3,size(face,1))';
new_edge_32 = new_edge_31 - edge_21;
loc_tri = [-new_edge_32, new_edge_31,-edge_21];
loc_tri = reshape(loc_tri',3,3*size(face,1))';
loc_tri = [zeros(3*size(face,1),1),loc_tri];
end