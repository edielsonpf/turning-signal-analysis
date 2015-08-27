DATA_FOLDER =   'results\';
%===========================================================

numFiles = 0;
fileData = 1;

row=0;
col=0;
data=[];
fid1 = fopen('file_list.txt','r');
while fileData~=0
	count = 0;
	fileData = fscanf(fid1,'%s',1);
    disp(fileData);
	if(fileData~=0)
		fileName = sprintf('%saverage_%s.dat',DATA_FOLDER,fileData);
        disp(fileName);
        fid2 = fopen(fileName,'r');
        [val1,count] = fread(fid2,9,'double');
        %Save variable
        data=[data val1];
        fclose(fid2);
        col=col+1;
    end
end
csvwrite('final_result.dat',data);
fclose(fid1);