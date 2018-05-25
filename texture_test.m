% function t111
clear, close all; tic;
%% ----------------------------------------------------------------------------

img = imread('obama.png');
[f, v] = read_obj('face.obj');
b = [ 262
      882
      471
      270
      757 ];
c = [ 136 183
      237 179
      182 246
      139 298
      231 295 ];
c(:, 1) = c(:, 1) / 380;
c(:, 2) = c(:, 2) / 380;

u = dcp(f, v, b(1:2), c(1:2, :));
u = u(:, [2, 1]);
u = 1 - u;
% u = dncp(f, v);

% fixfig(11); 
figure(1);
gpp_plot_mesh(f, u);
%%
% fixfig(12);
figure(2);
quadtexture(f, u, v, img);
axis equal;