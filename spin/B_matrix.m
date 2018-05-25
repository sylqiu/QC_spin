function B = B_matrix(F)
FF = F';
II = repmat((1:size(F,1)),3,1);
II = reshape(II,1,numel(II));
JJ = FF(:)';
b = ones(1,numel(F))/3;
B = sparse(II,JJ,b);
end