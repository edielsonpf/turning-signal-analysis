//definitions
DEFINE_DBG=0;
DEFINE_MFCC = 0;
DEFINE_PC1_PC3=1;
TRAINING_RATE=0.7;
PC1=11;
PC2=12;
PC3=13;
MFCC1=15;
MFCC2=16;
Vc=1;
f=2;
d=3;

configuration=[3 2 3; 3 4 3; 3 8 3; 3 16 3];
[rC,cC]=size(configuration);
dataset=['data.csv', 'data_v2.csv', 'data_v3.csv'];
[r,c]=size(dataset);

//Variable to store each experimental run
result = zeros(r*rC,3);
resultIndex=1;

for TestSet=1:c
    for Config=1:rC
        //generating data for training and testing procedures
        [Xtrain,Dtrain,Xtest,Dtest]= GenerateData(TRAINING_RATE,dataset(TestSet));
        
        //Definindo arquitetura da rede 
        if   DEFINE_MFCC == 1  then       
            NeuralNetwork=[2 15 3];
            filename='Wmel.sod'; 
        elseif DEFINE_PC1_PC3 == 1 then
            NeuralNetwork=configuration(Config,:);
            filename='WPC13.sod';  
        else
            NeuralNetwork=[1 15 3];
        //    NeuralNetwork=[2 15 3];
            filename='W.sod'; 
        end
    
    //    [fid,err] = mopen(filename,'rb');
    //    if err < 0 then 
            disp('Training model ' + string(Config) +'.....')
            W=Treina(Xtrain',Dtrain',NeuralNetwork);
            if DEFINE_DBG == 1 then
                disp(W);
            end
            save(filename,'W');
    //    else
    //        mclose(fid);
    //        load(filename,'W');
    //    end
        
        y = Classification(Xtest',W,NeuralNetwork);
        disp('Classification result for testing set: ' + dataset(TestSet) + ' and Configration: ' + string(Config));
        //disp(y');
        //disp('Expected result');
        //disp(Dtest);
    
        [Success,Errors,Accuracy] = TestPerformance(y',Dtest);
        result(resultIndex,1)=Success;
        result(resultIndex,2)=Errors;
        result(resultIndex,3)=Accuracy;
        resultIndex=resultIndex+1;
    end
end
csvWrite(result,'results.csv');

        
