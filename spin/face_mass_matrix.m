function M_f = face_mass_matrix(V,F)
A = doublearea(V,F)/2;
M_f = diag(A);
end