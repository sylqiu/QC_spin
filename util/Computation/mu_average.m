function new_mu = mu_average(mu,face,vertex,sx,sy)
% mu(~getface & abs(mu)>1) = mu(~getface & abs(mu)>1)/abs(mu(~getface & abs(mu)>1))*0.2;
% mu(getface & abs(mu)<1) = mu(getface & abs(mu)<1)/abs(mu(getface & abs(mu)<1))*5;
mu(abs(mu)>=1) = mu(abs(mu)>=1)./abs(mu(abs(mu)>=1))*0.1;
% mu(imag(mu)<t) = real(mu(imag(mu)<t)) + imag(mu(imag(mu)<t))./imag(mu(imag(mu)<t))*t;
[mu_grid,grid_face_ind]= face2grid(mu,face,vertex,sx,sy);
new_mu = zeros(size(face,1),1);
% [mu_grid,~,~,~] = dwt2(mu_grid,'haar');
% mu_grid = imresize(mu_grid,2);
new_mu(grid_face_ind) = mu_grid(:);
% new_mu(abs(imag(new_mu))>t) = real(new_mu(abs(imag(new_mu))>t)) +...
%     imag(new_mu(abs(imag(new_mu))>t))./imag(new_mu(abs(imag(new_mu))>t))*t;
new_mu(abs(new_mu)>=1) =new_mu(abs(new_mu)>=1)./abs(new_mu(abs(new_mu)>=1))*0.1;
end