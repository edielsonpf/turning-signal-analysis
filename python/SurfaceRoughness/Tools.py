'''
Created on Apr 2, 2016

@author: Edielson
'''

import csv
import numpy as np
import struct 

def LoadCSV(fileName,numFeatures):
    
    with open(fileName, 'rb') as csvfile:
        dataReader = csv.reader(csvfile, delimiter=',', quotechar='|')
        if numFeatures > 1:
            dataTrain=np.empty(shape=[0, numFeatures])
            for row in dataReader:
                    listAux=[]
                    for column in row:
                        listAux.append(float(column))
                    dataTrain = np.append(dataTrain, [listAux], axis=0)
        else:
            dataTrain=[]
            for row in dataReader:
                for column in row:
                    dataTrain.append(float(column))
                
    return dataTrain        

def LoadMel(fileName,numFeatures):
    with open(fileName, mode='rb') as file: # b is important -> binary
        fileContent = file.read(12*8)
        Mel=np.empty(shape=[0, numFeatures])
        while fileContent:
            out = struct.unpack('12d',fileContent[0:8*12])
            Mel = np.append(Mel, [out], axis=0)
            fileContent = file.read(12*8)
    return Mel
    return   