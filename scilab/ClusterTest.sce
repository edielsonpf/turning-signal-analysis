//definitions
DEFINE_MFCC = 1
PC1=11;
MFCC2=16;
MFCC1=15;
 // read csv file
StringData = read_csv('data.csv');
data = evstr(StringData);
disp(data);

//mounting training and testing sets
Xtrain=[];
Xtest=[];
train=1;
test=1;
for j=1:15
    for i=1:10
        if(j<=11)
if   DEFINE_MFCC == 1 then        
           Xtrain(train,1)=data((j-1)*10+i,MFCC1);
           Xtrain(train,2)=data((j-1)*10+i,MFCC2);
else
           Xtrain(train,1)=data((j-1)*10+i,PC1);
end
           Dtrain(train,:)=data((j-1)*10+i,17:19);
           train=train+1;
        else
if   DEFINE_MFCC == 1 then        
          Xtest(test,1)=data((j-1)*10+i,MFCC1);
          Xtest(test,2)=data((j-1)*10+i,MFCC2);
else
          Xtest(test,1)=data((j-1)*10+i,PC1);
end          
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
if   DEFINE_MFCC == 1  then       
    NeuralNetwork=[2 15 3];
    filename='Wmel.sod'; 
else
    NeuralNetwork=[1 15 3];
    filename='W.sod'; 
end

[fid,err] = mopen(filename,'rb');
if err < 0 then 
    disp('Training model.....')
    W=Treina(Xtrain',Dtrain',NeuralNetwork);
    disp(W);
    save(filename,'W');
else
    load(filename,'W');
end
mclose(fid);
    
y = ClassificationTest(Xtest',W,NeuralNetwork);
disp('Classification result');
disp(y');
disp('Expected result');
disp(Dtest);

Result=(y'==Dtest);
disp(Result);
