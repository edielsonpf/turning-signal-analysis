DATA_FOLDER =   'results\spectrogram\';
%===========================================================

fileData = 1;

Ms=[];
MsIndex=1;
FileIndex=1;
fid1 = fopen('file_list2.txt','r');
while fileData~=0
	count = 0;
	fileData = fscanf(fid1,'%s',1);
    disp(fileData);
	if(fileData~=0)
		fileName = sprintf('%saverage_%s.dat',DATA_FOLDER,fileData);
        disp(fileName);
        fid2 = fopen(fileName,'r');
        [val1,count] = fread(fid2,129,'double');
        %Save variable
        Ms(FileIndex,:)=val1';
        fclose(fid2);
    end
    FileIndex=FileIndex+1;
end
fclose(fid1);
disp(Ms);
disp(size(Ms));

Z = linkage(Ms,'ward','euclidean');
c = cluster(Z,'maxclust',3);
disp(c);
figure
dendrogram(Z)
xlabel('Machinning setup')
ylabel('Distance linkage')