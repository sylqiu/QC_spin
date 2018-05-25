function M_v = vertex_invmass_matrix(V,F)
FF = F';
A = doublearea(V,F)/6;
A = repmat(A,1,3);
A = reshape(A',3*size(F,1),1);
II = FF(:);
JJ = FF(:);
M_v = sparse(II,JJ,A);
M_v = inv(M_v);
end
