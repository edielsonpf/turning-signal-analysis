function [Xtrain,Dtrain,Xtest,Dtest]= GenerateData(TrainingRate, file_name)
DEFINE_DBG=0;
//definitions    
NUM_REPLICAS = 15;
NUM_EXP = 10;
NUM_TRAINING=round(TrainingRate*NUM_REPLICAS);
 // read csv file
StringData = read_csv(file_name);
data = evstr(StringData);

if  DEFINE_DBG == 1 then
disp(data);
end

//mounting training and testing sets
Xtrain=[];
Xtest=[];
train=1;
test=1;
for j=1:NUM_REPLICAS
    for i=1:NUM_EXP
        if(j<=NUM_TRAINING)
if   DEFINE_MFCC == 1 then        
           Xtrain(train,1)=data((j-1)*NUM_EXP+i,MFCC1);
           Xtrain(train,2)=data((j-1)*NUM_EXP+i,MFCC2);
elseif DEFINE_PC1 == 1 then
           Xtrain(train,1)=data((j-1)*NUM_EXP+i,PC1);
elseif DEFINE_PC1_PC2 == 1 then
           Xtrain(train,1)=data((j-1)*NUM_EXP+i,PC1);
           Xtrain(train,2)=data((j-1)*NUM_EXP+i,PC2);
elseif DEFINE_PC1_PC2_PC3 == 1 then
           Xtrain(train,1)=data((j-1)*NUM_EXP+i,PC1);
           Xtrain(train,2)=data((j-1)*NUM_EXP+i,PC2);
           Xtrain(train,3)=data((j-1)*NUM_EXP+i,PC3);
elseif DEFINE_PC1_PC2_PC3_PC4 == 1 then
           Xtrain(train,1)=data((j-1)*NUM_EXP+i,PC1);
           Xtrain(train,2)=data((j-1)*NUM_EXP+i,PC2);
           Xtrain(train,3)=data((j-1)*NUM_EXP+i,PC3);
           Xtrain(train,4)=data((j-1)*NUM_EXP+i,PC4);
else
           Xtrain(train,1)=data((j-1)*NUM_EXP+i,PC1);
//           Xtrain(train,2)=data((j-1)*NUM_EXP+i,f);
end
           Dtrain(train,:)=data((j-1)*NUM_EXP+i,17:19);
           train=train+1;
        else
if   DEFINE_MFCC == 1 then        
          Xtest(test,1)=data((j-1)*NUM_EXP+i,MFCC1);
          Xtest(test,2)=data((j-1)*NUM_EXP+i,MFCC2);
elseif DEFINE_PC1 == 1 then
          Xtest(test,1)=data((j-1)*NUM_EXP+i,PC1);
elseif DEFINE_PC1_PC2 == 1 then
          Xtest(test,1)=data((j-1)*NUM_EXP+i,PC1);
          Xtest(test,2)=data((j-1)*NUM_EXP+i,PC2);
elseif DEFINE_PC1_PC2_PC3 == 1 then
          Xtest(test,1)=data((j-1)*NUM_EXP+i,PC1);
          Xtest(test,2)=data((j-1)*NUM_EXP+i,PC2);
          Xtest(test,3)=data((j-1)*NUM_EXP+i,PC3);
elseif DEFINE_PC1_PC2_PC3_PC4 == 1 then
          Xtest(test,1)=data((j-1)*NUM_EXP+i,PC1);
          Xtest(test,2)=data((j-1)*NUM_EXP+i,PC2);
          Xtest(test,3)=data((j-1)*NUM_EXP+i,PC3);
          Xtest(test,4)=data((j-1)*NUM_EXP+i,PC4);
else
          Xtest(test,1)=data((j-1)*NUM_EXP+i,PC1);
//          Xtest(test,2)=data((j-1)*NUM_EXP+i,f);
end          
          Dtest(test,:)=data((j-1)*NUM_EXP+i,17:19);
          test=test+1;
       end 
    end
end
if DEFINE_DBG==1 then
    disp(size(Xtrain));
    disp(size(Xtest));
    disp(size(Dtrain));
    disp(size(Dtest));
end
endfunction
