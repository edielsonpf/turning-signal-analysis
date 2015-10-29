//definitions
DEFINE_DBG=0;
DEFINE_MFCC = 0;
DEFINE_PC1_PC3=0;
TRAINING_RATE=0.7;
PC1=11;
PC3=13;
MFCC1=15;
MFCC2=16;
Vc=1;
f=2;
d=3;


//generating data for training and testing procedures
[Xtrain,Dtrain,Xtest,Dtest]= GenerateData(TRAINING_RATE);
    
//Definindo arquitetura da rede 
if   DEFINE_MFCC == 1  then       
    NeuralNetwork=[2 15 3];
    filename='Wmel.sod'; 
elseif DEFINE_PC1_PC3 == 1 then
    NeuralNetwork=[2 15 3];
    filename='WPC13.sod';  
else
    NeuralNetwork=[1 15 3];
//    NeuralNetwork=[2 15 3];
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
    mclose(fid);
    load(filename,'W');
end
    
y = Classification(Xtest',W,NeuralNetwork);
disp('Classification result');
disp(y');
disp('Expected result');
disp(Dtest);

[Success,Errors] = TestPerformance(y',Dtest);
disp('Accuracy: '+string(Success*100)+'%');

        
