function [dec, val] = optdec(epsilonA1,epsilonB1,desired,T,w1,pars)
import brml.*;
wealth_size = size(pars.WealthValue,2);
ea_size = size(pars.epsilonAval,2);
eb_size = size(pars.epsilonBval,2);
d_size = size(pars.DecisionValue,2);
% initialise the transition p(wt_1|wt,ea,eb,dt)
p = zeros(wealth_size,wealth_size,ea_size,eb_size,d_size);
for wt_plus_one=1:wealth_size
	for wt=1:wealth_size
		for ea_plus_one =1:ea_size
			for eb_plus_one=1:eb_size
				for dt=1:d_size % we say that is valid tranisition if change in wealth
					% is <0.1 i.e. we round it up
					expected_wt = pars.WealthValue(wt) * (pars.DecisionValue(dt)*... 
                        (1+pars.epsilonAval(ea_plus_one))...
                        +(1-pars.DecisionValue(dt))*(1+pars.epsilonBval(eb_plus_one)));
						if abs(pars.WealthValue(wt_plus_one)-expected_wt)<0.1
							p(wt_plus_one,wt,ea_plus_one,eb_plus_one,dt)=1;
						end
				end
			end
		end
	end
end
% assign the variables w(t), w(t-1),ea(t),eb(t),ea(t-1),eb(t-1) 
%, d(t-1) to some numbers
[wt wtm ea eb dtm eam,ebm]=assign(1:7);
wt=1:T;
% wtm=(T+1):(2*T);
% ea=(2*T+1):(3*T);
% eb=(3*T+1):(4*T);
% eam=(4*T+1):(5*T);
% ebm=(5*T+1):(6*T);
% dtm=(6*T+1):(7*T);
% transition potential between states
tranpot=array([wt wtm ea eb dtm],p);
%transition potential between prices
epsilonA_pot = array([ea eam], pars.epsilonAtran);
epsilonB_pot = array([eb ebm], pars.epsilonBtran);
%set up wealth utility,10,000 for w=1.5
wealth_util = zeros(wealth_size,1);
for v=1:wealth_size
	if (pars.WealthValue(v) == 1.5)
		wealth_util(v) = 10000;
	end
end
valpot=array(wt,wealth_util); % initial values
% iterate T times to get the desired wealth at time T
for i=1:T
	[tmppot d] = maxpot(sumpot(multpots([tranpot valpot epsilonA_pot ...
        epsilonB_pot]),[wt,ea,eb]),dtm);
	% valpot is going to contain message from t to t-1
	valpot=array([wt ea eb],tmppot.table);
	end
% get expected utility at t=1,given w1, prices in states % epsilonA1,epsilonB1
val = valpot.table(w1,epsilonA1,epsilonB1);
% get decision
dec = d(w1);
[dec val];