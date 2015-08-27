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
%subplot(3,1,1)
%plot(t,dataAudio);
%axis xy; axis tight;

[y,f,t,p] = spectrogram(dataAudio,HammingSize,OverlapSize,FFT_SIZE,Fs);

disp(size(abs(y)'));
%disp(size(f));
%disp(size(p));
%disp(size(t));
disp(abs(y(1:10,:)));
%[pcaY,scoreY,latentY,tsquareY]=princomp(abs(y)');
[pcaY,scoreY,latentY,tsquareY]=princomp(zscore(abs(y)'));
%disp(size(pcaY));
%disp(pcaY);
%disp(size(scoreY));
%disp(cumsum(latentY)./sum(latentY));
%biplot(pcaY(:,1:2),'Scores',scoreY(:,1:2));

%subplot(3,1,2);
%plot(t,abs(y));
%axis xy; axis tight;

%disp(scoreY(:,1:20));

%subplot(3,1,3)
%surf(t,f,10*log10(abs(p)),'EdgeColor','none');   
%axis xy; axis tight; colormap(jet); view(0,90);
%xlabel('Time');
%ylabel('Frequency (Hz)');

disp('PCA average');
[numRows,numCols]=size(scoreY);
mean=zeros(1,numCols);
for i=1:numCols
    for j=1:numRows
        mean(i)=mean(i)+scoreY(j,i);
    end
    mean(i)=mean(i)/numRows;
end
%disp(mean(1:20)');
