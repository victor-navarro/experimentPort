function V=rho(dist1, dist2)


d1size = size(dist1,2);
d2size = size(dist2,2);

A = [dist1 dist2];
B = [ones(1,d1size) ones(1,d2size)*2];



[sortList,sortRanks]=sort(A);


sortList;
sortRanks;
mwuMax = (d1size*d2size);
rankSum = sum(sortRanks(B==1));
mwuCalc = rankSum - (d1size)*(d1size+1)/2;

V = abs(mwuCalc/mwuMax - .5) + .5;
