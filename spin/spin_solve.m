% landmark is the index of the vertex to be fixed, target is the N by 4
% coordinate of the target vertices
function new_vertex = spin_solve(f,v,rho,edge)%landmark,target)
D = my_dirac(edge,f,v);
Rho = mean_curvhalfdensity(f,rho);
A = D-Rho;
% mV = vertex_invmass_matrix(v,f);
% mV = rconvq(mV);
B = B_matrix(f);
B = rconvq(B);
B = qadjoint(B,v,f);
K = A;
KK = qadjoint(K,v,f)*K;
% KK = qadjoint(K,v,f)*K;
% maxiter = 3;
% eigVec = my_inversepower(KK,maxiter);
[eigVec,D] = eigs(KK,B*K,48,'SM');
D = diag(D);
lambda = eigVec(:,48);
% lambda = repmat([1;0;0;0],size(v,1),1);
etilde = new_edge(v,f,lambda); % [ek; ei; ej]
% old_edge = [zeros(numel(f),1), v(f(:,[2 3 1])',:)-v(f(:,[1 2 3])',:)];
omega = divedge(v,f,etilde);
new_vertex = integrate_mesh(v,f,omega);%landmark,target);
end