function W=Treina(Xt,d,NN) 

 
//Definindo arquitetura da rede 
 
//Criando rede inicial 
W = ann_FF_init(NN); 
 
//===============Treinando a rede=========== 
//Taxa de aprendizagem e limiar do erro 
lp = [0.01, 1e-4]; 
 
//Maximo numero de épocas 
epochs = 3000; 
 
//treinando 
W = ann_FF_Std_batch(Xt,d,NeuralNetwork,W,lp,epochs); 
endfunction 
