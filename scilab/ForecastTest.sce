//definitions
DEFINE_DBG=1;
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
MRR=4;
Ra=5;
Ry=6;

configuration=zeros(3,4,4);
configuration(:,:,1)=[2 8 8 1; 2 16 8 1; 2 32 8 1];
configuration(:,:,2)=[3 8 8 1; 3 16 8 1; 3 32 8 1];
configuration(:,:,3)=[4 8 8 1; 4 16 8 1; 4 32 8 1];
configuration(:,:,4)=[5 8 8 1; 5 16 8 1; 5 32 8 1];

//configuration=zeros(4,3,4);
//configuration(:,:,1)=[3 8 1; 3 16 1; 3 32 1; 3 64 1];
//configuration(:,:,2)=[4 8 1; 4 16 1; 4 32 1; 4 64 1];
//configuration(:,:,3)=[5 8 1; 5 16 1; 5 32 1; 5 64 1];
//configuration(:,:,4)=[6 8 1; 6 16 1; 6 32 1; 6 64 1];


[rC,cC,dC]=size(configuration);
//dataset=['data_ry.csv', 'data_ry_v2.csv', 'data_ry_v3.csv'];
dataset=['data_mrr.csv'];
[r,c]=size(dataset);

//Variable to store each experimental run
result = zeros(r*rC,1);
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
            [Xtrain,Dtrain,Xtest,Dtest]= ForecastGenerateData(TRAINING_RATE,dataset(TestSet));
            
            NeuralNetwork=configuration(Config,:,Dim);
            filename='ANNForecast.sod';  
                    
            disp('Training model ' + string(Config) +'.....')
            W=Treina(Xtrain',Dtrain',NeuralNetwork);
            save(filename,'W');
            
            y = ann_FF_run(Xtrain',NeuralNetwork,W); 
            disp('Classification result for training set: ' + dataset(TestSet) + ' and Configration: ' + string(Config) + 'with number of inputs: ' + string(Dim));
            FinalResult=[y', Dtrain , (y'-Dtrain)];
            disp('Expected result:');
            disp(FinalResult);
            [TotalError,SquareError] = ForecastPerformance(y',Dtrain);
            
            y = ann_FF_run(Xtest',NeuralNetwork,W); 
            disp('Classification result for testing set: ' + dataset(TestSet) + ' and Configration: ' + string(Config) + 'with number of inputs: ' + string(Dim));
            FinalResult=[y', Dtest , (y'-Dtest)];
            disp('Expected result:');
            disp(FinalResult);
        
            [TotalError,SquareError] = ForecastPerformance(y',Dtest);
            result(resultIndex,1)=TotalError;
            resultIndex=resultIndex+1;
        end
    end
end
csvWrite(result,'results_forecast.csv');

        
