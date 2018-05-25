function u = dcp(f, v, b, c)

%  DCP Discrete Conformal Parameterization
%     u = DCP(f, v, b, c) conformal mapping with constraints

A = vector_area_matrix(f);
L = blkdiag(cotmatrix(v, f), cotmatrix(v, f));
nv = size(v, 1);
u = reshape(laprow(L+2*A, [b(:); b(:)+nv], c(:)), nv, 2);
% u = lsqc_solver(f,v,100000*ones(nf,1),b,c);
end

function u = laprow(L, b, c)

%  LAPROW Laplacian with constraints
%     u = LAPROW(L, b, c) solves laplace equation with constraint

nv = size(L, 2);
u = zeros(nv, 1);
u(b) = c;
v = L * u;
v(b) = [];
L(:, b) = [];
L(b, :) = [];
z = - L \ v;
a = 1 : nv;
a(b) = [];
u(a) = z;
end
