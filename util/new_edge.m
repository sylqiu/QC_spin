function etilde = new_edge(V,F,lambda)
edge_vec = [zeros(numel(F),1) V(F(:,[2 3 1])',:) - V(F(:,[1 2 3])',:)]; %edge vector
etilde = zeros(size(edge_vec));
lambda = reshape(lambda,4,size(lambda,1)/4)';%each row for each vertex
for i = 0:size(F,1)-1;
    vind = F(i+1,:);
    for vi = 0:2;
        eij = toReal(edge_vec(3*i+vi+1,:));
        lambda_i = lambda(vind(vi+1),:);
        lambda_i = toQuat(lambda_i);
        lambda_i = toReal(lambda_i);
        
        lambda_j = lambda(vind(mod(vi+1,3)+1),:); 
        lambda_j = toQuat(lambda_j);
        lambda_j = toReal(lambda_j);
        
        eeij = (1/3)*lambda_i'*eij*lambda_i +...
            (1/6)*lambda_i'*eij*lambda_j + ...
            (1/6)*lambda_j'*eij*lambda_i + ...
            (1/3)*lambda_j'*eij*lambda_j;
        eeij = toQuat(eeij(1,:));
        etilde(3*i+vi+1,:) = eeij;
        
    end
end

end