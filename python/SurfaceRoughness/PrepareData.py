import csv

csvReader = csv.reader(open('train_f.csv', 'rb'), delimiter=',')

x1 = []
for row in csvReader:
    for column in row:
        x1.append(float(column))
print (x1)

