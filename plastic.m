clear, close all; tic;
%%
----------------------------------------------------------------------------
%%
clear;

% addpath(genpath('My_library'));
% addpath('mesh');
% addpath('spin');

% [f,v] = read_obj('moon_original.obj');
% [f,v] = read_obj('smalldisk.obj');
[f, v] = read_obj('face.obj');
figure(1);
gpp_plot_mesh(f, v);
[bdy_ind,T,N,B,component_ind] = boundary_frame(f, v);

vind = [434;445;394];
%%

h = 50;
tt = linspace(-0.05, 0.15, h);
for i = 1:h
%   fprintf('#%d: %f\n', i, tt(i));
  ic = incenter(triangulation(f, v));
  rr = zeros(size(f, 1), 1);
%   vind = [954; 999; 1006; 1024];
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
  %
%   figure(3);
% %   gpp_plot_mesh(f, new_vertex, 'facealpha', 0.7);
%   trisurf(f, new_vertex(:, 1), new_vertex(:, 2), new_vertex(:, 3),
% sum(face_normal, 2));
%   view([-2, 0.25, 3]);
%   axis equal;
% %   view([-1, -1, 0.5]);
% %   axis([-1, 1, -1, 1, -1, 1]*100);
%   drawnow;
  %
  img = imread('smalldicaprio.png');
%   [f, v] = gpp_read_obj('data\face.obj');
  b = [ 863 % eye (left)
        244 % right eye
%         525 % nose tip
        801 % left mouth corner
        238 % right mouth corner
        1072 % left sun spot
       119 % right eye corner end
        984 % left chin
        175 % right chin
        322 % right nose corner
        575 % man center
        80 % right eyebrow end
        976% left eyebrow end
        128 % right eye end
        464 % left of right eyebrow 
        ];

  c = [ 180 224
        317 219
%         247 310
        200 362
        305 362
        95 223
        343 221
        134 349
        354 358
        291 306
        247 329
        341 199
        145 199
        339 200
        269 199];
  c(:, 1) = c(:, 1) / 490;
  c(:, 2) = c(:, 2) / 490;
  c = c(:, [2, 1]);
  c = 1-c;
  u = dcp(f, new_vertex, b, c);

%   fixfig(8);
%   gpp_plot_mesh(f, u);

%   fixfig(12);
  figure(2);
  quadtexture(f, u, new_vertex, img);
  view([0.25, -2, 3]);
  axis equal;

%
%   figure(2);
%   trisurf(f, v(:, 1), v(:, 2), v(:, 3), rr);
%   axis equal;
%   view(2);
%   shading flat;
%   colorbar;

  saveas(gcf, sprintf('plastic2/frame%04d.jpg', i));
end

%%
for i = 1 : 38
    vidFrames(:,:,:,i) = imread(sprintf('plastic2/frame%04d.jpg', i));
end
w = VideoWriter('plastic2\video.avi');
w.FrameRate = 15;
open(w);
writeVideo(w,vidFrames);
close(w);


%%
% clear, close all;
%
% img = imread('texture/smalldicaprio.png');
% [f, v] = gpp_read_obj('data/face.obj');
% % b = [ 262
% %       882
% %       471
% %       270
% %       757 ];
% % c = [ 136 183
% %       237 179
% %       182 246
% %       139 298
% %       231 295 ];
% % c(:, 1) = c(:, 1) / 380;
% % c(:, 2) = c(:, 2) / 380;
% b = [ 843
%         235
%         525
%         801
%         304
%         1130
%         55
%         984
%         175];
%   c = [ 180 224
%         317 219
%         247 300
%         200 362
%         305 362
%         95 223
%         382 221
%         134 349
%         354 358];
% c(:, 1) = c(:, 1) / 490;
% c(:, 2) = c(:, 2) / 490;
% c = c(:, [2, 1]);
% c = 1-c;
% u = dcp(f, v, b, c);
% % u = u(:, [2, 1]);
% % u = 1 - u;
% % u = dncp(f, v);
%
% fixfig(11);
% gpp_plot_mesh(f, u);
%
% fixfig(12);
% quadtexture(f, u, v, img);
% axis equal;