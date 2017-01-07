from sklearn.mixture import GMM
from Tools import LoadCSV
import numpy as np

X_train=LoadCSV('new_data/mfcc_train_1.csv',2)
Y_train=LoadCSV('new_data/label_train_1.csv',1)

for x,y in zip(X_train,Y_train):
    print('%s = %s'%(x,y))

n_classes = len(np.unique(Y_train))
# print(n_classes)

# 'spherical', 'diag', 'tied', 'full'
covar_type = 'tied'

classifier = GMM(n_components=n_classes,covariance_type=covar_type, init_params='wc', n_iter=20)

# initialize the GMM parameters in a supervised manner.
# classifier.means_ = np.array([X_train[Y_train == i].mean(axis=0)
#                               for i in xrange(n_classes)])
# print(classifier.means_)

# Train the other parameters using the EM algorithm.
classifier.fit(X_train)
# 
y_train_pred = classifier.predict(X_train)

train_accuracy = np.mean(y_train_pred == Y_train) * 100
print('Train accuracy: %.1f' % train_accuracy)

# y_test_pred = classifier.predict(X_test)
# test_accuracy = np.mean(y_test_pred.ravel() == y_test.ravel()) * 100
# plt.text(0.05, 0.8, 'Test accuracy: %.1f' % test_accuracy,
#          transform=h.transAxes)
