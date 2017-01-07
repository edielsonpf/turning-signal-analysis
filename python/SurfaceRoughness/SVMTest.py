from sklearn import svm
from Tools import LoadCSV
import numpy as np

num_simulation = 10

# data_train = 'data/pca_training_1.csv'
# label_train = 'data/classes_training_1.csv'
# 
# data_test = 'data/pca_testing_1.csv'
# label_test = 'data/classes_testing_1.csv'

data_train = 'new_data/pca_train_1.csv'
label_train = 'new_data/label_train_1.csv'

data_test = 'new_data/pca_test_1.csv'
label_test = 'new_data/label_test_1.csv'


num_features = 3

Ms =['Cs=200,F=0.1,D=0.1', 
     'Cs=240,F=0.1,D=0.1',
     'Cs=200,F=0.2,D=0.1',
     'Cs=200,F=0.1,D=0.2',
     'Cs=240,F=0.1,D=0.2',
     'Cs=240,F=0.2,D=0.2',
     'Cs=186,F=0.15,D=0.15',
     'Cs=220,F=0.23,D=0.15',
     'Cs=220,F=0.15,D=0.23',
     'Cs=220,F=0.15,D=0.15']

X=LoadCSV(data_test,num_features)
Y=LoadCSV(label_train,1)

X=LoadCSV(data_test,num_features)
Y=LoadCSV(label_test,1)

# test_kernel ='linear'
test_kernel = 'rbf'

# function_shape='ovo'
function_shape='ovr'

accuracy_results=[]
for simulation in xrange(num_simulation):
    
    clf = svm.SVC(kernel=test_kernel, decision_function_shape=function_shape)
    clf.fit(X, Y)

    MsIndex=0
    numObs=70
    numTests=70  
    Accuracy=0
    Count=0
    for i in range(numTests):
    #     RndObs = np.random.randint(0,numObs-1,1)
    #     Prediction = clf.predict(X[RndObs])
    #     Prediction = clf.predict(X[i].reshape(-1, 2))
        Prediction = clf.predict(X[i].reshape(-1, num_features))
        if Y[i]==Prediction:
            Accuracy=Accuracy+1
    #     else:
    #         print('Machining setup %s'%Ms[MsIndex])
    #         print('Error sample %s'%i)    
    #         print(Prediction)
    #         print(Y[i])
            
        Count=Count+1
        MsIndex=MsIndex+1
        if MsIndex > 9:
            MsIndex=0         
    test_accuracy=100.0*(1.0*Accuracy/Count) 
    accuracy_results.append(test_accuracy)
    print('Test accuracy: %s %%\n'%(test_accuracy))        

print(accuracy_results)

# X=LoadCSV('data/pca_training_2.csv',num_features)
# Y=LoadCSV('data/classes_training_2.csv',1)
# # X=LoadCSV('test_data/pca_train_2.csv',num_features)
# # Y=LoadCSV('test_data/label_train_2.csv',1)
# 
# clf = svm.SVC(decision_function_shape='ovr')
# clf.fit(X, Y)
# 
# X=LoadCSV('data/pca_testing_2.csv',num_features)
# Y=LoadCSV('data/classes_testing_2.csv',1)
# # X=LoadCSV('test_data/pca_test_2.csv',num_features)
# # Y=LoadCSV('test_data/label_test_2.csv',1)
# 
# MsIndex=0
# numObs=70
# numTests=70  
# Accuracy=0
# Count=0
# for i in range(numTests):
# #     RndObs = np.random.randint(0,numObs-1,1)
# #     Prediction = clf.predict(X[RndObs])
#     Prediction = clf.predict(X[i].reshape(-1, num_features))
# #     if Y[RndObs]==Prediction:
#     if Y[i]==Prediction:
#         Accuracy=Accuracy+1
# #     else:
# #         print('Machining setup %s'%Ms[MsIndex])
# #         print('Error sample %s'%i)
# #         print(Prediction)
# #         print(Y[i])
# 
#     Count=Count+1    
#     MsIndex=MsIndex+1
#     if MsIndex > 9:
#         MsIndex=0
#         
# print('Set 2 accuracy: %s %%'%(100.0*(1.0*Accuracy/Count)))