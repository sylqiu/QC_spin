function bd1 = compute_orderbd(face)
[am,amd] = compute_adjacency_matrix(face);
md = am - (amd>0)*2;
[I,J,~] = find(md == -1);
bd = zeros(size(I,1),2);
k = 1;
% bd(1,1) = I(k); bd(1,2) = J(k); k = find(J == I(k));
for n = 1:size(I,1)
    bd(n,1) = I(k);
    bd(n,2) = J(k);
    k = find(I == J(k));
end
bd1 = bd(:,1);
% [~,Ii] = sort(I);
% bd = zeros(size(I));
% 
% for i = 1:size(I,1)
%     k = Ii(i);
%     bd(i) = I(k);
% end



end