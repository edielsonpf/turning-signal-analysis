from sklearn import mixture
from Tools import LoadCSV
import numpy as np

data_train = 'new_data/mix_train_2.csv'
label_train = 'new_data/label_train_2.csv'

data_test = 'new_data/mix_test_2.csv'
label_test = 'new_data/label_test_2.csv'


num_features = 5
num_simulation = 10

X_train=LoadCSV(data_train,num_features)
Y_train=LoadCSV(label_train,1)

n_classes = len(np.unique(Y_train))

S1=[]
S2=[]
S3=[]
for x,y in zip(X_train,Y_train):
    if y==1:
        S1.append(x)
    elif y==2:
        S2.append(x)
    else:
        S3.append(x)    

# print(S1)
# print(S2)
# print(S3)

# 'spherical', 'diag', 'tied', 'full'            
covariance='full'
n_gauss = 4

accuracy_results=[]
for i in xrange(num_simulation):

    gmix1 = mixture.GMM(n_components=n_gauss, covariance_type=covariance)
    gmix1.fit(S1)
    # print gmix1.means_
    
    gmix2 = mixture.GMM(n_components=n_gauss, covariance_type=covariance)
    gmix2.fit(S2)
    # print gmix2.means_
    
    gmix3 = mixture.GMM(n_components=n_gauss, covariance_type=covariance)
    gmix3.fit(S3)
    # print gmix3.means_
    
    y_train_pred1 = gmix1.score_samples(X_train)
    y_train_pred2 = gmix2.score_samples(X_train)
    y_train_pred3 = gmix1.score_samples(X_train)
    
    # for prediction1,prediction2,prediction3,y in zip(y_train_pred1,y_train_pred2,y_train_pred3,Y_train):
    #     print('%s,%s,%s,%s'%(prediction1,prediction2,prediction3,y))
    
    logprob1, responsibilities = gmix1.score_samples(X_train)
    logprob2, responsibilities = gmix2.score_samples(X_train)
    logprob3, responsibilities = gmix3.score_samples(X_train)
    
    train_accuracy=0
    counter=0
    for predict1,predict2,predict3,y in zip(logprob1,logprob2,logprob3,Y_train):
        
        result=[predict1,predict2,predict3]
        winner=max(result)
    #     print(winner)
    #     print(result.index(winner)+1.0)
    #     print(y)
    #    
        if y == (result.index(winner)+1.0): 
            train_accuracy=train_accuracy+1.0/len(X_train)
    
    train_accuracy=train_accuracy*100        
    print('Train accuracy: %.1f' % train_accuracy)
    
    X_test=LoadCSV(data_test,num_features)
    Y_test=LoadCSV(label_test,1)
    
    
    logprob1, responsibilities = gmix1.score_samples(X_test)
    logprob2, responsibilities = gmix2.score_samples(X_test)
    logprob3, responsibilities = gmix3.score_samples(X_test)
    
    test_accuracy=0
    counter=0
    for predict1,predict2,predict3,y in zip(logprob1,logprob2,logprob3,Y_test):
        
        result=[predict1,predict2,predict3]
        winner=max(result)
        
        if y == (result.index(winner)+1.0): 
            test_accuracy=test_accuracy+1.0/len(X_test)
    #     else:
    #         print('Machining setup %s'%Ms[MsIndex])
    #         print('Error sample %s'%i)
    #         print(result)
    #         print('Prediction = %s'%(result.index(winner)+1.0))
    #         print('Label=%s'%y)
    
    test_accuracy=test_accuracy*100 
    accuracy_results.append(test_accuracy)       
    print('Test accuracy: %.1f' % test_accuracy)

print(accuracy_results)