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
    filename='SVMModelMel.sod'; 
elseif DEFINE_PC1_PC3 == 1 then
    NeuralNetwork=[2 15 3];
    filename='SVMModelPC13.sod';  
else
    NeuralNetwork=[1 15 3];
//    NeuralNetwork=[2 15 3];
    filename='SVMModel.sod'; 
end

[fid,err] = mopen(filename,'rb');
if err < 0 then 
    disp('Training model.....')
    model=Treina(Xtrain,Dtrain);
    if DEFINE_DBG == 1 then
        disp(W);
    end
    save(filename,'model');
else
    mclose(fid);
    load(filename,'model');
end
    
[pred,acc,dec]= Classification(Xtest,Dtest,model);
//disp('Classification result');
disp(pred);
disp(acc);
//disp('Dec:'+string(dec));
        
