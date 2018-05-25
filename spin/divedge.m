function omega = divedge(V,F,etilde)
    double_area = doublearea(V,F);
    FF = F';
    FF = FF(:);
    shiftFF = F(:,[2,3,1]);
    shiftFF = shiftFF';
    shiftFF = shiftFF(:);
    double_area = reshape(repmat(double_area,1,3)',3*numel(double_area),1);
    edge_vec1 = [zeros(numel(F),1) V(F(:,[3 1 2])',:) - V(F(:,[2 3 1])',:)];
    edge_vec2 = [zeros(numel(F),1) V(F(:,[3 1 2])',:) - V(F(:,[1 2 3])',:)];
    cotAlpha = sum(edge_vec1.*edge_vec2,2)./double_area; 
    cotAlpha = repmat(cotAlpha,1,4)/2;
    II = [repmat(FF,1,4);repmat(shiftFF,1,4)];
    JJ = repmat((1:4),size(II,1),1);
    SS = [-cotAlpha.*etilde; cotAlpha.*etilde];
    omega = sparse(II,JJ,SS);
%     mean_vec = sum(omega,1)/size(omega,1);
%     omega = omega - repmat(mean_vec,size(omega,1),1);
    
end