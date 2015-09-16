
 // read csv file
StringData = read_csv('data.csv');
data = evstr(StringData);
disp(data);

train=1;
test=1;
for j=1:15
    for i=1:10
        if(j<=11)
           Xtrain(train)=data((j-1)*10+i,11);
           Dtrain(train,:)=data((j-1)*10+i,17:19);
           train=train+1;
        else
          Xtest(test)=data((j-1)*10+i,11);
          Dtest(test,:)=data((j-1)*10+i,17:19);
          test=test+1;
       end 
    end
end
disp(size(Xtrain));
disp(size(Xtest));
disp(size(Dtrain));
disp(size(Dtest));

//Definindo arquitetura da rede 
NeuralNetwork=[1 15 3]; 

[fid,err] = mopen('W.sod','rb');
if err < 0 then 
    W=Treina(Xtrain',Dtrain',NeuralNetwork);
    disp(W);
    save('W.sod','W');
else
    load('W.sod','W');
end
mclose(fid);
    
y = ClassificationTest(Xtest',W,NeuralNetwork);
disp('Classification result');
disp(y');
disp('Expected result');
disp(Dtest);

//Result=[y',Dtest];
//disp(Result);
Result=(y'==Dtest);
disp(Result);
