function model=Treina(label_vector,instance_matrix) 

model=libsvm_svmtrain(label_vector,instance_matrix);

endfunction 
