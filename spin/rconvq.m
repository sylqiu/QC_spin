%converting a diagonal real matrix into its quaternionic representation
% function q_A = qconv(A) %extremely slow
% B = repmat(reshape(A,numel(A),1),1,4);
% V = reshape(B',1,numel(B));
% V = reshape(V,4*size(A,2),size(A,1));
% II = repmat((1:4*size(A,1))',1,size(A,2));
% JJ = repmat(reshape((1:4*size(A,2)),4,size(A,2)),size(A,1),1);
% q_A = sparse(II,JJ,V);
% end

%Assume A is sparse
function q_A = rconvq(A)
    [I,J,S] = find(A);
    II = repmat(4*(I-1),1,4)+repmat((1:4),size(I,1),1);
    JJ = repmat(4*(J-1),1,4)+repmat((1:4),size(J,1),1);
    SS = repmat(S,1,4);
    q_A = sparse(II,JJ,SS,4*size(A,1),4*size(A,2));

end