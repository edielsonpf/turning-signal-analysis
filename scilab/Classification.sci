function y=Classification(x,W,NN) 
     //x: vector with testing data 
     //W: synaptic weight of treined ANN
     //NN: ANN arquitecture 
      
     y = ann_FF_run(x,NN,W); 
     y=round(y); 
endfunction 
