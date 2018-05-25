% find the vertices in p3 that lies between p1 and p2;
function in_lineseg_index = in_lineseg(p1,p2,p3)
p1 = repmat(p1,size(p3,1),1);
p2 = repmat(p2,size(p3,1),1);
t = (p3-p1)./(p2-p1);
lgc = abs(t(:,1) - t(:,2))<0.05;
t_ind = [1:size(t,1)];
t_ind = t_ind(lgc);
t_new = t(lgc,1);
[srt,order] = sort(t_new);
in_lineseg_index = srt < 1 & srt > 0;
in_lineseg_index = order(in_lineseg_index);
in_lineseg_index = t_ind(in_lineseg_index);
end
