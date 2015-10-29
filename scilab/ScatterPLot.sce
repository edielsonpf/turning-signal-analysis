//Limpa qualquer variável criada em outra simulação.
clear;
//fecha todos os gráficos
xdel(winsid());

Debug = 1;
SPEC_DATA_FOLDER = 'C:\Users\Edielson\Documents\Researches\turning-signal-analysis\results\spectrogram\';

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
    //disp(cumsum(latentY)./sum(latentY));
    //disp(scoreY(:,1:4));
    //disp(pcaY);
    //svwrite('pca.txt',scoreY(:,1));
    //[lambda,facpr,comprinc] = pca(Ms);
    //show_pca(lambda,facpr);
end
PC1=scoreY(:,1);
PC2=scoreY(:,2);
PC3=scoreY(:,3);
//=======================================================================
load ('MRR.mat','MRR');
load ('ry.mat','Ry');
load ('ra.mat','Ra');
load ('f.mat','f');
load ('vc.mat','vc');
load ('setups.mat','setups');
load ('m1.mat','m1');
load ('m2.mat','m2');

Var=f;
//X1=vc;
//X2=f;
X1=Ry;
X2=-1*PC1;


MaxLevel=max(Var);
disp(MaxLevel);
MinLevel=min(Var);
disp(MinLevel);
Step=(MaxLevel-MinLevel)/3;
disp(Step);

for i=1:length(X1)
    if(Var(i)<=MinLevel+Step)
        plot(X1(i),X2(i),'g.','MarkerSize',8);
    elseif (Var(i)<=MinLevel+2*Step)
        plot(X1(i),X2(i),'b.','MarkerSize',8);
    else
        plot(X1(i),X2(i),'r.','MarkerSize',8);    
    end
end
//plot(PC1,PC3,'b.','MarkerSize',8)
//plot(PC1,PC3,'.','MarkerSize',8,color(255,255,0));
//figure;
//plot(vc,f,'g.','MarkerSize',8)
