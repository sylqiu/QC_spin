function Rho = mean_curvhalfdensity(F,rho)
%     if length(rho)==size(F,1)
%         error('tho size not right');
%     else
    R = sparse(1:size(rho),1:size(rho),rho);
    B = B_matrix(F);
    Rho = R*B;   
    Rho = rconvq(Rho); 
    
end