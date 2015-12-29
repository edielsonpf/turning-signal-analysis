function [TotalError,SquareError] = ForecastPerformance(Xr,Xd)
//Xr: Vector with the values to be compared
//Xd: vetor wit the reference values

DEFINE_DBG=0;
SquareError=(Xr-Xd).^2;

if DEFINE_DBG == 1 then
    disp(SquareError);
end

[l,c]=size(Xr);

TotalError = 0;
for i=1:l
    TotalError = TotalError +  SquareError(i);   
end
TotalError=sqrt(TotalError)/l;
disp('Sum Square Error: '+string(TotalError))
endfunction
