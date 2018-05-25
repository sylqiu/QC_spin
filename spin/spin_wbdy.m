function new_vertex = spin_wbdy(f,v,theta,V,V_tilde,bdy_ind,EV,rho)
%V_angle assigns an angle for each boundary vertex, represent the angle
%between V_tilde and V. By default V should be the outward pointing
%binormal
D = my_dirac(EV,f,v);
Rho = mean_curvhalfdensity(f,rho);
A = D-Rho;
W = Wmatrix(v,bdy_ind,theta,V,V_tilde);
C = Cmatrix(v,V_tilde,bdy_ind);
U = W*C;
mV = vertex_invmass_matrix(v,f);
mV = rconvq(mV);
K = A*mV*U;
KK = qadjoint(K,v,f)*K;
maxiter = 3;
% eigVec = my_inversepower(KK,maxiter);
eigVec = my_inversepower_wbdy(KK, v,maxiter, bdy_ind);
lambda = mV*U*eigVec;
etilde = new_edge(v,f,lambda);
omega = divedge(v,f,etilde);
new_vertex = integrate_mesh(v,f,omega);
end