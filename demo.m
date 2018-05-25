%%
clear;

addpath(genpath('My_library'));
addpath('mesh');
addpath('spin');

% [f,v] = read_obj('moon_original.obj');
% [f,v] = read_obj('smalldisk.obj');
[f, v] = read_obj('cleanface.obj');
gpp_plot_mesh(f, v);
[bdy_ind,T,N,B,component_ind] = boundary_frame(f, v);

%% single
ic = incenter(triangulation(f, v));
  rr = zeros(size(f, 1), 1);
  vind = [688; 748; 751; 782];
  f_cells = find_tri_by_vertex(f, vind);
  f_select = unique(cell2mat(f_cells'));
  rr(f_select) = -0.01;
  rho = rr;
%   rho = 0*ones(size(f,1),1);
  mu = 0*ones(size(f,1),1);
  mu_edge = local_tri(f,v,mu,[]);

  V = B; V_tilde = B;
  % theta = pi/4*ones(size(bdy_ind,1),1);
  theta = real(acos(dot(V,V_tilde,2)./(sqrt(dot(V,V,2)).*sqrt(dot(V_tilde,V_tilde,2)))));

  new_vertex = spin_wbdy(f,v,theta,V,V_tilde,bdy_ind,mu_edge,rho);
  
  face_normal = faceNormal(triangulation(f, new_vertex));
  figure(1);
%   gpp_plot_mesh(f,new_vertex, 'facealpha', 0.7);
  trisurf(f, new_vertex(:, 1), new_vertex(:, 2), new_vertex(:, 3), sum(face_normal, 2));
  view([-1, 1, 3]);
  axis equal;
%% sequencetial

h = 50;
tt = linspace(-0.1, 0.1, h);
for i = 1 : h
%   fprintf('#%d: %f\n', i, tt(i));
  ic = incenter(triangulation(f, v));
  rr = zeros(size(f, 1), 1);
  vind = [688; 748; 751; 782];
  f_cells = find_tri_by_vertex(f, vind);
  f_select = unique(cell2mat(f_cells'));
  rr(f_select) = tt(i);
  rho = rr;
%   rho = 0*ones(size(f,1),1);
  mu = 0*ones(size(f,1),1);
  mu_edge = local_tri(f,v,mu,[]);

  V = B; V_tilde = B;
  % theta = pi/4*ones(size(bdy_ind,1),1);
  theta = real(acos(dot(V,V_tilde,2)./(sqrt(dot(V,V,2)).*sqrt(dot(V_tilde,V_tilde,2)))));

  new_vertex = spin_wbdy(f,v,theta,V,V_tilde,bdy_ind,mu_edge,rho);
  
  face_normal = faceNormal(triangulation(f, new_vertex));
  figure(1);
%   gpp_plot_mesh(f,new_vertex, 'facealpha', 0.7);
  trisurf(f, new_vertex(:, 1), new_vertex(:, 2), new_vertex(:, 3), sum(face_normal, 2));
  view([-1, 1, 3]);
  axis equal;
%   view([-1, -1, 0.5]);
%   axis([-1, 1, -1, 1, -1, 1]*100);
  drawnow;
  
%   figure(2);
%   trisurf(f, v(:, 1), v(:, 2), v(:, 3), rr);
%   axis equal;
%   view(2);
%   shading flat;
%   colorbar;
  
%    saveas(gcf, sprintf('plastic1/frame%04d.jpg', i));
end

% for i = 1 : h
%     vidFrames(:,:,:,i) = imread(sprintf('plastic1/frame%04d.jpg', i));
% end
% w = VideoWriter('plastic1\video.avi');
% w.FrameRate = 15;
% open(w);
% writeVideo(w,vidFrames);
% close(w);
