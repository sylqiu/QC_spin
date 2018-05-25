function eigvec = my_inversepower(M, maxiter)
eigvec = repmat([1;0;0;0],size(M,1)/4,1);
for i = 1:maxiter
    eigvec = eigvec./norm(eigvec);
    eigvec = M\eigvec;
end
eigvec = eigvec./norm(eigvec);
end