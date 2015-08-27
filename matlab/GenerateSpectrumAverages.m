DATA_FOLDER =   'results\spectrogram\';
%===========================================================

numFiles = 0;
fileData = 1;

fid1 = fopen('file_list.txt','r');
while fileData~=0
	count = 0;
	fileData = fscanf(fid1,'%s',1);
    disp(fileData);
	if(fileData~=0)
		fileName = sprintf('%sspectrogram_%s.dat',DATA_FOLDER,fileData);
        disp(fileName);
        fid2 = fopen(fileName,'r');
        [val1,count] = fread(fid2,1,'int');
        %disp(val1);
        count=1;	
        obs=0;
        average=zeros(val1,1);
        %Save variable
        varFileName = sprintf('average_%s.dat',fileData);
        disp(varFileName);
        fid3 = 	fopen(varFileName,'w');	
        while count~=0 
            [val,count] = fread(fid2,val1,'double');
            if(count~=0)		
                average=average+val;
                obs=obs+1;
            end
        end
        average=average/obs;
        disp(average);
        disp(obs);
        [meanLin, meanCol] = size(average);
        for i=1:meanCol
            for j=1:meanLin
                count=count+fwrite(fid3,average(j,i),'double');
            end	
        end
        fclose(fid3);
    end
end
fclose(fid1);
fclose(fid2);
