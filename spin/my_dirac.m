%EV = [zeros(numel(f),1) v(f(:,[2 3 1])',:) - v(f(:,[3 1 2])',:)]; 
function D = my_dirac(EV,F,V)
 A = doublearea(V,F);

  % [ w -x -y -z, x  w -z  y, y  z  w -x, z -y  x  w];
%   Q = [ ...
%     1 0 0 0;0 -1  0 0;0 0 -1  0;0  0 0 -1; ...
%     0 1 0 0;1  0  0 0;0 0  0  1;0  0 -1  0; ...
%     0 0 1 0;0  0  0 -1;1 0  0  0;0 1 0  0; ...
%     0 0 0 1;0  0  1 0;0 -1  0  0;1  0 0  0]';
  Q = [...
    1 0 0 0, 0 1 0 0, 0 0 1 0, 0 0 0 1;
    0 -1 0 0, 1 0 0 0, 0 0 0 -1, 0 0 1 0;
    0 0 -1 0, 0 0 0 1, 1 0 0 0, 0 -1 0 0;
    0 0 0 -1, 0 0 -1 0, 0 1 0 0, 1 0 0 0];
  % face-quat indices 
%   II = repmat(repmat((0:size(F,1)-1)'*4 +(1:4),1,4),3,1);
  II = repmat(reshape(repmat((0:size(F,1)-1)'*4,1,3)',3*size(F,1),1),1,16)+...
      repmat([1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4],3*size(F,1),1);
%   JJ = (repmat(F(:),1,4*4)-1)*4+reshape(repmat(1:4,4,1),1,[]);
  JJ = repmat((reshape(F',numel(F),1)-1)*4,1,16)+repmat((1:4),3*size(F,1),4);
  D = sparse(II,JJ,EV*Q./repmat(reshape(repmat(A,1,3)',3*numel(A),1),1,16),4*size(F,1),4*size(V,1));

end