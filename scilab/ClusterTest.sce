//definitions
DEFINE_DBG=0;
DEFINE_MFCC = 0;
DEFINE_PC1_PC3=1;
TRAINING_RATE=0.6;
PC1=11;
PC2=12;
PC3=13;
PC4=14;
MFCC1=15;
MFCC2=16;
Vc=1;
f=2;
d=3;

configuration=zeros(5,3,4);
configuration(:,:,1)=[1 2 3; 1 4 3; 1 8 3; 1 16 3;1 32 3];
configuration(:,:,2)=[2 2 3; 2 4 3; 2 8 3; 2 16 3;2 32 3];
configuration(:,:,3)=[3 2 3; 3 4 3; 3 8 3; 3 16 3;3 32 3];
configuration(:,:,4)=[4 2 3; 4 4 3; 4 8 3; 4 16 3;4 32 3];

[rC,cC,dC]=size(configuration);
dataset=['data.csv', 'data_v2.csv', 'data_v3.csv'];
[r,c]=size(dataset);

//Variable to store each experimental run
result = zeros(r*rC,3);
resultIndex=1;

for TestSet=1:c
    for Dim=1:dC
        if Dim == 1
            DEFINE_PC1 = 1;
            DEFINE_PC1_PC2 = 0;
            DEFINE_PC1_PC2_PC3 = 0;
            DEFINE_PC1_PC2_PC3_PC4 = 0;
        elseif Dim == 2
            DEFINE_PC1 = 0;
            DEFINE_PC1_PC2 = 1;
            DEFINE_PC1_PC2_PC3 = 0;
            DEFINE_PC1_PC2_PC3_PC4 = 0;
        elseif Dim == 3
            DEFINE_PC1 = 0;
            DEFINE_PC1_PC2 = 0;
            DEFINE_PC1_PC2_PC3 = 1;
            DEFINE_PC1_PC2_PC3_PC4 = 0;
        else
            DEFINE_PC1 = 0;
            DEFINE_PC1_PC2 = 0;
            DEFINE_PC1_PC2_PC3 = 0;
            DEFINE_PC1_PC2_PC3_PC4 = 1;
        end
        
        for Config=1:rC
            //generating data for training and testing procedures
            [Xtrain,Dtrain,Xtest,Dtest]= GenerateData(TRAINING_RATE,dataset(TestSet));
            
            NeuralNetwork=configuration(Config,:,Dim);
            filename='WPC13.sod';  
                    
            disp('Training model ' + string(Config) +'.....')
            W=Treina(Xtrain',Dtrain',NeuralNetwork);
            if DEFINE_DBG == 1 then
                disp(W);
            end
            save(filename,'W');
            
            y = Classification(Xtest',W,NeuralNetwork);
            disp('Classification result for testing set: ' + dataset(TestSet) + ' and Configration: ' + string(Config) + 'with number of inputs: ' + string(Dim));
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
end
csvWrite(result,'results_ry_60.csv');

        
