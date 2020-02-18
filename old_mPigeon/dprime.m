function Dprime=dprime(Pc,M);

%The dprime function takes a "Percent Correct" argument and an
%"M-Alternative" argument and returns the calculated Dprime according to
%accepted formulas for calculating Dprime based on Malternative choice.

A=(-4 + sqrt(16 + 25 * log(M-1)))/3;
B=((log(M-1)+2) / (log(M-1)+1))^(1/2);
N=norminv(Pc);
Dprime = real(A + B * N);