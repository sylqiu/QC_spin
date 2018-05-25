function [mu_grid,grid_face_ind]= face2grid(mu,face,vertex,sx,sy)
vertex = [vertex(:,1),-vertex(:,2)+sy-1];
Tr = triangulation(face,vertex);
[x,y] = meshgrid(linspace(0.1,sx-1.1,sx),linspace(0.1,sy-1.1,sy));
grid_pt_vec = [x(:),y(:)];
grid_face_ind = pointLocation(Tr,grid_pt_vec);
mu_vec = mu(grid_face_ind);
mu_grid = reshape(mu_vec,sx,sy);
end