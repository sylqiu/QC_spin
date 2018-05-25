function [ind,E,component_index,num_boundary_componet] = correct_boundary_faces(f)
%% assume f has correct orientation
pre_edgelist = outline(f);
ind = unique(pre_edgelist(:));
%clean a bit first
% correct = sum(~ismember(pre_edgelist,ind),2)==0;
% pre_edgelist = pre_edgelist(correct,:);

E = zeros(size(ind,1),2);
% L = pre_edgelist(:,1);
% R = pre_edgelist(:,2);
[~,flip_ind] = find_tri_by_edge(f,pre_edgelist(1,:));

if flip_ind == 0
    E(1,1) = pre_edgelist(1,1);
    E(1,2) = pre_edgelist(1,2);
else
    E(1,1) = pre_edgelist(1,2);
    E(1,2) = pre_edgelist(1,1);
end
rownum = 1;
pre_edgelist = pre_edgelist([1:rownum-1,rownum+1:end],:);

num_boundary_componet = 1;
component_index = 0;
for i = 2:size(ind,1)
    [connected_to,rownum] = findnxt(pre_edgelist,pre_edgelist,pre_edgelist,E(i-1,2));
    if isempty(connected_to)
        num_boundary_componet = num_boundary_componet+1;
        component_index = [component_index,i-1];
        
        [~,flip_ind] = find_tri_by_edge(f,pre_edgelist(1,:));

        if flip_ind == 0
            E(i,1) = pre_edgelist(1,1);
            E(i,2) = pre_edgelist(1,2);
        else
            E(i,1) = pre_edgelist(1,2);
            E(i,2) = pre_edgelist(1,1);
        end
%         E(i,1) = pre_edgelist(1,1);
%         E(i,2) = pre_edgelist(1,2);
        rownum = 1;
        pre_edgelist = pre_edgelist([1:rownum-1,rownum+1:end],:);
    else
        E(i,1) = E(i-1,2);  
        E(i,2) = connected_to;
        pre_edgelist = pre_edgelist([1:rownum-1,rownum+1:end],:);
    end
end
component_index = [component_index,size(ind,1)];
ind = E(:,1);
end