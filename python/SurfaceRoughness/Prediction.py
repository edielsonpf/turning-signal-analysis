# -*- coding: utf-8 -*-
""" 
Example of use multi-layer perceptron
=====================================

Task: Approximation function: 1/2 * sin(x)

"""

import neurolab as nl
import numpy as np
import csv

csvReader = csv.reader(open('train_f.csv', 'rb'), delimiter=',')
train_f = np.zeros(90)
index=0
for row in csvReader:
    for column in row:
        train_f[index] = float(column)
        index=index+1

csvReader = csv.reader(open('train_pc1.csv', 'rb'), delimiter=',')
train_pc1=np.zeros(90)
index=0
for row in csvReader:
    for column in row:
        train_pc1[index]=float(column)
        index=index+1

csvReader = csv.reader(open('train_ry.csv', 'rb'), delimiter=',')
train_ry=np.zeros(90)
index=0
for row in csvReader:
    for column in row:
        train_ry[index] = float(column)
        index=index+1

csvReader = csv.reader(open('validation_f.csv', 'rb'), delimiter=',')
validation_f = np.zeros(60)
index=0
for row in csvReader:
    for column in row:
        validation_f[index] = float(column)
        index=index+1

csvReader = csv.reader(open('validation_pc1.csv', 'rb'), delimiter=',')
validation_pc1=np.zeros(60)
index=0
for row in csvReader:
    for column in row:
        validation_pc1[index] = float(column)
        index=index+1

csvReader = csv.reader(open('validation_ry.csv', 'rb'), delimiter=',')
validation_ry=np.zeros(60)
index=0
for row in csvReader:
    for column in row:
        validation_ry[index] = float(column)
        index=index+1

# Create train samples
#x = [[0 for col in range(2)] for row in range(len(train_f))]
x = np.matrix([train_f,train_pc1])
#print(x)

y=np.zeros(len(train_ry))
for i in range(len(train_ry)):
    y[i] = train_ry[i] * 0.1
#print(y)

size = len(y)
inp = x.transpose()
#print(inp)
tar = y.reshape(size,1)


# Create network with 2 layers and random initialized
net = nl.net.newff([[-2, 2],[-25, 25]],[16, 1])
 
# Train network
error = net.train(inp, tar, epochs=5000, show=100, goal=0.001)
 
# Simulate network
out = net.sim(inp)
 
# Plot result
import pylab as pl
#pl.subplot(211)
pl.plot(error)
pl.xlabel('Epoch number')
pl.ylabel('error (default SSE)')
 
# x2 = np.linspace(-6.0,6.0,150)
# Create train samples
#x = [[0 for col in range(2)] for row in range(len(train_f))]
x2 = np.matrix([validation_f,validation_pc1])

y2 = net.sim(x2.transpose()).transpose()
print(y2)
 
out=np.zeros(len(validation_ry))
for i in range(len(validation_ry)):
    out[i] = validation_ry[i] * 0.1

size = len(out)

y3 = out.reshape(size)
print(y3)

 
#pl.subplot(212)
#pl.plot(x2, y2, '-',x , y, '.', x, y3, 'p')
#pl.legend(['train target', 'net output'])
pl.show()