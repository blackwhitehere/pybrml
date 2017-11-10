import brml.*
[a b c d]=assign(1:4);
S=10; % number of skill levels
% players and their prior skills:
pot(a)=array(a,condp(ones(S,1)));
pot(b)=array(b,condp(ones(S,1)));
pot(c)=array(c,condp(ones(S,1)));
pot(d)=array(d,condp(ones(S,1)));
% game outcomes:
o(1)=skillpot(a,b,true,S);
o(2)=skillpot(a,b,true,S);
o(3)=skillpot(b,c,true,S);
o(4)=skillpot(b,c,true,S);
o(5)=skillpot(a,c,true,S);
o(6)=skillpot(a,c,true,S);
o(7)=skillpot(a,c,false,S);
o(8)=skillpot(d,c,false,S);
o(9)=skillpot(d,c,false,S);
p=multpots([pot o]); % joint distribution of skill levels and game outcomes
% marginal skills of each player
pa=condpot(p,a); meana=sum((pa.table).*transpose(1:S))
pb=condpot(p,b); meanb=sum((pb.table).*transpose(1:S))
pc=condpot(p,c); meanc=sum((pc.table).*transpose(1:S))
pd=condpot(p,d); meand=sum((pd.table).*transpose(1:S))
% prob that D beats A given evidence
margda=condpot(p,[d a]);
s=skillpot(d,a,true,S);
pDbeatsAgivenEvidence=sumpot(s*margda,[],0)
% prob that D beats A given evidence (and assuming a post indep skills)
margdmarga=condpot(p,d)*condpot(p,a);
pDbeatsAgivenEvidenceIndep=sumpot(s*margdmarga,[],0)

