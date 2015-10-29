function [Success,Errors] = TestPerformance(Xr,Xd)
//Xr: Vector with the values to be compared
//Xd: vetor wit the reference values

DEFINE_DBG=0;
Result=(Xr==Xd);

if DEFINE_DBG == 1 then
    disp(Result);
end

Success=0;
Errors=0;

[l,c]=size(Xr);

for i=1:l
    Test=%T;
    for j=1:c
       Test=Test&Result(i,j); 
    end
    if(Test==%T)
        Success=Success+1;
    else
        Errors=Errors+1;
    end
end
disp('Successes: '+string(Success))
disp('Erros: '+string(Errors))
disp('Total:'+string(l));
Success=Success/l;
Errors=Errors/l;
endfunction
