%find the vertex v in anti-ecol that is connected to e (in the same row in 
%pre_edgelist2, where e belongs ecol
function [connected_to,rownum] = findnxt(ecol,pre_edgelist2,anti_ecol,e)
    rownum = logical(sum(ismember(ecol,e),2));
    connected_to = anti_ecol(rownum,:);
    connected_to = connected_to(connected_to~=e);
    L = 1:size(pre_edgelist2);
    rownum = L(rownum);
%     connected_to = sum(connected_to,2)-e*ones(size(connected_to,1),1);
    %find the number of times each vertice connected_to E(1,1) appears in pre_edgelist
    if size(connected_to,1) == 1
        return;
    else
        freq = zeros(size(connected_to,1),1);
        for i = 1:size(freq,1)
           freq(i) = sum(sum(ismember(pre_edgelist2,connected_to(i))));
        end
        %only keep least frequent one
        [~,admis] = min(freq);
        connected_to = connected_to(admis);
        rownum = rownum(admis);
    end
end