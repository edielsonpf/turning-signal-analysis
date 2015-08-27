function result = TestGmmModel(file_list,model)

SPEC_DATA_FOLDER =   'results\spectrogram\';

%===========================================================
fileData = 1;
Ms=[];
MsIndex=1;
FileIndex=1;
fid1 = fopen(file_list,'r');
while fileData~=0
	count = 0;
	fileData = fscanf(fid1,'%s',1);
    disp(fileData);
	if(fileData~=0)
		fileName = sprintf('%saverage_%s.dat',SPEC_DATA_FOLDER,fileData);
        disp(fileName);
        fid2 = fopen(fileName,'r');
        [val1,count] = fread(fid2,129,'double');
        %Save variable
        Ms(:,FileIndex)=val1';
        fclose(fid2);
    end
    FileIndex=FileIndex+1;
end
fclose(fid1);

X1=Ms';
%correlation
[pcaY,scoreY,latentY,tsquareY]=princomp(zscore(X1));

X=[scoreY(:,1:4)];
[row,col]=size(X);

%Testing model
result=[];
for i=1:row
    [p,nlogl] = posterior(model,X(i,:));
    result(i,1)=p;
    result(i,2)=nlogl;
end 
end