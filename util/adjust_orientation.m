function ff = adjust_orientation(f,v)
% given a connected mesh, make all triangles oriented consistantly as the
% first given trangle 
% parent = [1];
% ff(1,:) = f(1,:);
% ancestor = parent;
% descendents = setdiff([1:size(f,1)],ancestor);
% while ~isempty(descendents)
%     child = [];
%     f_remain = f(descendents,:);
%     f_remain_lenth = 1:size(f_remain,1);
%     for j = parent
%         for i = 0:2
%             %find the descendent triangle whose share the edge with the
%             %parent
%             A = f_remain==ff(j,mod(i,3)+1);
%             B = 2*(f_remain==ff(j,mod(i+1,3)+1));
%             ji = f_remain_lenth(sum(A+B,2) == 3);
%             if isempty(ji)
%                 continue;
%             end
%             child_ji = 1:size(f,1);
%             child_ji = child_ji(sum((repmat(f_remain(ji,:),size(f,1),1)-f).^2,2) == 0);
%             child = [child,child_ji];
%             C = A(ji,:) + B(ji,:);
%             if ismember([2,1],[C(1),C(2);C(2),C(3);C(3),C(1)],'rows')...
%                     == 1;
%                 ff(child_ji,:) = f(child_ji,:);
%             else
%                 ff(child_ji,:) = f(child_ji,[1,3,2]);
%             end
%         end
%     end
%     parent = child;
%     ancestor = [ancestor,parent];
%     descendents = setdiff([1:size(f,1)],ancestor);
% end

neigh = neighbors(triangulation(f,v));


end