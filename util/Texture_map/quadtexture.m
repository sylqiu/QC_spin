function quadtexture(f, u, v, img)

%  QUADTEXTURE Texture Mapping
%     QUADTEXTURE(f, u, v, img) maps texture via quad mesh

[h, w, ~] = size(img);
[y, x] = meshgrid(0:h, 0:w);
p = [x(:)/w, y(:)/h];
if size(v, 2) == 2
  v(:, 3) = 0;
end
[q, ~] = pullback(f, u, v, p);
z = reshape(q, h+1, w+1, 3);
Y = z(:, :, 1);
X = z(:, :, 2);
Z = z(:, :, 3);
C = flipud(img);
C(:, end+1, :) = C(:, end, :);
C(end+1, :, :) = C(end, :, :);
s = surf(X, Y, Z, C);
s.EdgeColor = 'none';
end

function [q, p] = pullback(f, u, v, p)

%  PULLBACK Pullback Mapping
%     [q, p] = PULLBACK(f, u, v, p) maps p from u to v

pf = zeros(size(p, 1), 1);
for i = 1 : size(f, 1)
  pf(inpolygon(p(:, 1), p(:, 2), u(f(i, :), 1), u(f(i, :), 2))) = i;
end
utr = triangulation(f, u);
vtr = triangulation(f, v);
b = utr.cartesianToBarycentric(pf(pf > 0), p(pf > 0, :));
q = nan * zeros(size(p, 1), size(v, 2));
q(pf > 0, :) = vtr.barycentricToCartesian(pf(pf > 0), b);
p(pf == 0, :) = nan;
end
