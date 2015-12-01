function [pred,acc,dec]=Classification(label_vector,instance_matrix,model) 
     
     [pred,acc,dec]=libsvm_svmpredict(label_vector,instance_matrix,model);
     
endfunction 
