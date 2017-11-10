function p=skillpot(a,b,win,S)
% p_{i,j} = probability that a beats b given their respective skill levels s_i , s_j
import brml.*
for A=1:S
for B=1:S
table(A,B)=1./(1+exp(B-A));
if ~win
table(A,B)=1-table(A,B);
end
end
end
p=array([a,b],table);