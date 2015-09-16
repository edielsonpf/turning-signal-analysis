function y=ClassificationTest(x,W,NN) 
     //Definindo arquitetura da rede 
     //NeuralNetwork=[4 15 3]; 
     y = ann_FF_run(x,NN,W); 
     y=round(y); 
     //[l,c]=size(y); 
      
     //for i=1:c 
    //     if(y(1,i)==0 & y(2,i)==0 & y(3,i)==1) 
    //         cluster='C'; 
    //     elseif (y(1,i)==1 & y(2,i)==0 & y(3,i)==0) 
    //         cluster='A'; 
    //     elseif (y(1,i)==0 & y(2,i)==1 & y(3,i)==0) 
    //         cluster='B';       
    //     else 
    //         cluster='unknown'; 
    //     end  
    // disp(cluster);          
    // end 
endfunction 
