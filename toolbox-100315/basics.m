import brml.*

help array.array
%%
pot=array([1 2],rand(2,2))
pot.variables
pot.table
%%
r=rand([4 2 3]) % creates 3, 4 by 2 matrices
p=condp(r,[3 1])
sum(p,3)
sum(sum(p,3),1)

p2= condp(r, [2 1])
sum(p2,3)
sum(sum(p2,2),1)