% iterative singular set search
% Inputs:
% face,vertex: user created inital parametrisation mesh
% registered_vertex: first registration result obtained;
% getface: flipped region
% nn,mm,kk: some original mesh parameters, needed, for naive_unfold, not
%        essential
% constraints: [c_cin,c], available constraints, may not be complete due to
%           occlusion

function [map,map_mu] = iter_sing(face,vertex,registered_vertex,getface,nn,mm,kk,constraints)
[nu_vertex,~] = naive_unfold(face,registered_vertex,getface,nn,mm,kk);
mu_1 = compute_bc(face,vertex,nu_vertex,2);
mu_angle = 0;
new_mu = complex(ones(size(face, 1), 1), zeros(size(face, 1), 1));
new_mu = new_mu./abs(new_mu);
new_mu(getface) = new_mu(getface)*1000*exp(1i*mu_angle);
new_mu(~getface) = new_mu(~getface)*0;
% figure(9);
[map,map_mu] = lbs_rect(nu_vertex',face',mu_1);
 gpp_plot_mesh(face,map');view(2);
% figure(2);plot(real(map_mu(getface)),imag(map_mu(getface)),'ro')
% figure(2);plot(real(map_mu),imag(map_mu),'b.')
itermax = 50;
iter = 1;
% load('DefaultParameterLM.mat');
% Operator = createOpt_fold(vertex,face,getface);
% corner = [161;206;251;296];

while iter <itermax
%     penalty = P.sigma;
%     penalty = penalty + P.sigmaIncrease;
    [vertex_1,~] = twopt_bs(face,map',new_mu,constraints);
    gpp_plot_mesh(face,vertex_1);
%     subplot(1,2,1);
    figure(11); subplot(1,2,1); set(gcf,'position',[50,50,800,400]);
%     plot3d(face,vertex,vertex_1,0.5);axis off;  

    [nu_vertex,new_mu_1] = naive_unfold(face,vertex_1,getface,nn,mm,kk);
%     figure(13);
    gpp_plot_mesh(face,nu_vertex);axis off;
%     Smooth_Operator = (1/(penalty))*(P.alpha*speye(size(vertex,1)) + ...
%         penalty*speye(size(vertex,1)) - Operator.laplacian/2);
%     new_mu_1 = mu_average(new_mu_1,face,vertex,sx,sy);
%     new_mu_1 = smoothing(new_mu_1,Smooth_Operator,Operator);
   
    new_mu_1 = mu_chop(new_mu_1,0,0);
%     nu_vertex = [nu_vertex,zeros(size(nu_vertex,1),1)];
    [map,map_mu] = lbs_rect(nu_vertex',face',new_mu_1);%,'corner',corner);
%     subplot(1,2,2);
%     figure(10);
    figure(11); subplot(1,2,2);gpp_plot_mesh(face,map');view(2);axis off;
    drawnow;pause(0.1);
%      new_mu_1 = mu_average(new_mu_1,face,vertex,sx,sy,-0.1);
%     new_mu_1 = new_mu_1*(itermax-iter)/itermax;
% figure(2);plot(real(new_mu_1),imag(new_mu_1),'b.'); 
%
%     [nu_vertex,new_mu_1] = twopt_bs(face,vertex,new_mu_1,unew_constraints);
    iter = iter+1;
end
end