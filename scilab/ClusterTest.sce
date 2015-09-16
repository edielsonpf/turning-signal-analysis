//definitions
DEFINE_DBG=0;
DEFINE_MFCC = 1
PC1=11;
MFCC2=16;
MFCC1=15;

//generating data for training and testing procedures
[Xtrain,Dtrain,Xtest,Dtest]= GenerateData();
    
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
    if DEFINE_DBG == 1 then
        disp(W);
    end
    save(filename,'W');
else
    load(filename,'W');
end
mclose(fid);
    
y = Classification(Xtest',W,NeuralNetwork);
disp('Classification result');
disp(y');
disp('Expected result');
disp(Dtest);

[Success,Errors] = TestPerformance(y',Dtest);
disp('Accuracy');
disp(Success);
disp('Errors');
disp(Errors);

        
