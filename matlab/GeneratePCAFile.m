% Private Definition
FFT_POINTS = 256;		%numero de pontos da FFT 
ENERGY_CONTOUR = 9;		%numero de perfis
TIME_INTERVAL_MS = 20;	%intervalo de audio = 50ms
OVERLAP_INTERVAL_MS = 10;	%intervalo de audio = 50ms
DATA_WINDOW_SCALE=0.001;		%1ms
DATA_FOLDER =   'data_selected\';
VAR_NAME =      'spectrum';
%===========================================================

numFiles = 0;
fileData = 1;

fid1 = fopen('file_list.txt','r');
fid2 = fopen('results\spectrum_list.txt','wt');
 
while fileData~=0
	count = 0;
	fileData = fscanf(fid1,'%s',1);
    disp(fileData);
	if(fileData~=0)
		fileName = sprintf('%s%s.wav',DATA_FOLDER,fileData);
        disp(fileName);        
		numFiles=numFiles+1;
		%Calculate energy contour
		[dataAudio,sampleFreq]=wavread(fileName);
        Fs = sampleFreq;
        HammingSize = sampleFreq*TIME_INTERVAL_MS*DATA_WINDOW_SCALE;
        OverlapSize = sampleFreq*OVERLAP_INTERVAL_MS*DATA_WINDOW_SCALE;
        %t = 0:1/Fs:(length(dataAudio)-1)/Fs;
        
        [y,f,t,p] = spectrogram(dataAudio,HammingSize,OverlapSize,FFT_POINTS,Fs);
        spectrum=abs(y);
        
		%Save variable
		varFileName = sprintf('spectrogram_%s.dat',fileData);
        disp(varFileName);
		fid3 = 	fopen(varFileName,'w');	
        
		[meanLin, meanCol] = size(spectrum);

		fwrite(fid3,(FFT_POINTS/2)+1,'int');		
		for i=1:meanCol
			for j=1:meanLin
				count=count+fwrite(fid3,spectrum(j,i),'double');
			end	
		end
		fprintf(fid2,'%s\n',varFileName);
        fclose(fid3);
	end
end
fclose(fid1);
fclose(fid2);
