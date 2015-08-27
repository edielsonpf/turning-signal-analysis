function model = TrainGmmModel(file_list)

SPEC_DATA_FOLDER =   'results\spectrogram\';

load setups;

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

%Generating model
K=1;
%training GMM models for each cluster
options = statset('Display','final');
model = gmdistribution.fit(X,K,'Options',options,'Replicates',5);
disp('Componentes Means');
ComponentMeans = model.mu;
disp(ComponentMeans);
disp('Componentes Covariances');
ComponentCovariances = model.Sigma;
disp(ComponentCovariances);
disp('Mixture Proportions');
MixtureProportions = model.PComponents;
disp(MixtureProportions);
end