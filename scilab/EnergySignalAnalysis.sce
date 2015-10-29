//Limpa qualquer variável criada em outra simulação.
clear;
//fecha todos os gráficos
xdel(winsid());

Debug = 1;
SPEC_DATA_FOLDER = 'C:\Users\Edielson\Documents\Researches\turning-signal-analysis\results\spectrogram\';
//load ('setups.mat','setups');
//===========================================================
Ms=[];
MsIndex=1;
FileIndex=1;
fid1 = mopen('file_list.txt','rt');
while  ~meof(fid1) do
	FileAux = mgetl(fid1,1);
    disp(FileAux);
	FileName = sprintf('%saverage_%s.dat',SPEC_DATA_FOLDER,FileAux);
    disp(FileName);
    fid2 = mopen(FileName,'rb');
    val = mget(129,'d',fid2);
    //Save variable
    Ms(MsIndex,:)=val;
    mclose(fid2);
    FileIndex=FileIndex+1;
    MsIndex=MsIndex+1;
end
mclose(fid1);

//X1=Ms(:,1:15)';
//X1=Ms';
if Debug == 1 then
disp(Ms);
disp(size(Ms));
end

//covariance
//[pcaY,scoreY,latentY,tsquareY]=princomp(X1);
//correlation
[pcaY,scoreY,latentY,tsquareY]=princomp(nan_zscore(Ms));
if Debug == 1 then
    disp(size(pcaY));
    disp(size(scoreY));
    disp(cumsum(latentY)./sum(latentY));
    disp(scoreY(:,1:4));
    //disp(pcaY);
    //svwrite('pca.txt',scoreY(:,1));
    //[lambda,facpr,comprinc] = pca(Ms);
    //show_pca(lambda,facpr);
end
//=======================================================================
