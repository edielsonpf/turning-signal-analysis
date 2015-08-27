DATA_WINDOW_SIZE=20;			%20ms
DATA_WINDOW_SCALE=0.001;		%ms
numPerfil = 9;
FFT_SIZE = 256;

%[dataAudio,sampleFreq]=wavread('data_selected\vc_240_f_010_ap_010-1.wav');
%[dataAudio,sampleFreq]=wavread('data_selected\vc_200_f_010_ap_010-1.wav');

%[dataAudio,sampleFreq]=wavread('data_selected\vc_186_f_015_ap_015-1.wav');
%[dataAudio,sampleFreq]=wavread('data_selected\vc_240_f_010_ap_020-1.wav');

%[dataAudio,sampleFreq]=wavread('data_selected\vc_220_f_023_ap_015-1.wav');
[dataAudio,sampleFreq]=wavread('data_selected\vc_240_f_020_ap_020-12.wav');


%figure
Fs = sampleFreq;
HammingSize = sampleFreq*DATA_WINDOW_SIZE*DATA_WINDOW_SCALE;
OverlapSize = sampleFreq*DATA_WINDOW_SIZE/2*DATA_WINDOW_SCALE;
t = 0:1/Fs:(length(dataAudio)-1)/Fs;
subplot(3,1,1)
plot(t,dataAudio);
axis xy; axis tight;

[y,f,t,p] = spectrogram(dataAudio,HammingSize,OverlapSize,FFT_SIZE,Fs);

disp(size(abs(y)'));
%disp(size(f));
%disp(size(p));
%disp(size(t));
%disp(abs(y(:,100)));
[pcaY,scoreY,latentY,tsquareY]=princomp(abs(y)');
disp(size(pcaY));
%disp(pcaY);
disp(size(scoreY));
disp(cumsum(latentY)./sum(latentY));
%biplot(pcaY(:,1:2),'Scores',scoreY(:,1:2));

subplot(3,1,2);
plot(t,abs(y));
axis xy; axis tight;

disp(scoreY(:,1:20));

subplot(3,1,3)
surf(t,f,10*log10(abs(p)),'EdgeColor','none');   
axis xy; axis tight; colormap(jet); view(0,90);
xlabel('Time');
ylabel('Frequency (Hz)');


%[sizeFreq, numWindows]=size(p);
[sizeFreq, numWindows]=size(y);
perfil=zeros(numPerfil,numWindows);

for n=1:numWindows
    %calculate the total energy for each window
    Etotal=0;
    for j=1:sizeFreq
        %Etotal=Etotal + 10*log10(abs(p(j,n)));
        Etotal=Etotal + abs(y(j,n));
    end
    %disp('Total energy:');
    %disp(Etotal);
    Passo = Etotal/(numPerfil+1);
    %disp('Passo:');
    %disp(Passo);
    Limiar = 0.0;
    ParcialAnterior = 0.0;
    %Parcial = 10*log10(abs(p(1,n)));
    Parcial = abs(y(1,n));
    
    j=1;
    for i=1:numPerfil
       Limiar = Limiar + Passo;
       %while (Parcial >= Limiar)
       while (Parcial <= Limiar)
          j=j+1;
          %disp('Limiar:');
          %disp(Limiar);
          %disp('Parcial:');
          %disp(Parcial);
          ParcialAnterior = Parcial;
          %disp(10*log10(abs(p(j,n))));
          %Parcial = Parcial + 10*log10(abs(p(j,n)));
          Parcial = Parcial + abs(y(j,n));
       end
       
       %disp(n);
       %disp(i);
       %disp(j);
       %disp(f(j));
       %perfil(i,n) = f(j);
       %disp(perfil(i,n));
      
       %if ((Parcial < Limiar)&&(j>1)) % passou do ponto
       if ((Parcial > Limiar)&&(j>1)) % passou do ponto
          x1 = f(j-1.0);
          x2 = f(j);
          perfil(i,n) = InterpLinear(x1,ParcialAnterior,x2,Parcial,Limiar);
       else
          perfil(i,n) = f(j);
       end
    end
end
%disp(perfil);
%[numRows,numCols]=size(y);
%mean=0;
%for i=1:numCols
%    mean=mean+abs(y(:,i));
%end
%disp(mean/numCols);
[numRows,numCols]=size(perfil);
mean=0;
for i=1:numCols
    mean=mean+abs(perfil(:,i));
end
%disp(mean/numCols);

