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
plot(Ry,PC1,'b.','MarkerSize',8)


X=[Ra, MRR, f];

NumCluster=3;
if NumCluster == 2 then
    [model,idx] = nan_kmeans( X, 2 );
else
    [model,idx] = nan_kmeans( X, 3 );    
end

//figure;
//plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',8)
//plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',8)
//if NumCluster == 3 then
//    plot(X(idx==3,1),X(idx==3,2),'g.','MarkerSize',8)
//end
//ctrs=model.X;
//plot(ctrs(:,1),ctrs(:,2),'ko', 'MarkerSize',8,'LineWidth',2)
//plot(ctrs(:,1),ctrs(:,2),'kx', 'MarkerSize',8,'LineWidth',2);
//if NumCluster == 2 then
//    legend('Cluster 1','Cluster 2','Centroids',  'Location','NW')
//else
//    plot(ctrs(:,1),ctrs(:,2),'k*', 'MarkerSize',8,'LineWidth',2);
//    legend('Cluster 1','Cluster 2','Cluster 3','Centroids',  'Location','NW')
//end

cluster1 = setups(idx == 1,:);
disp('Cluster 1');
disp(cluster1);
cluster2 = setups(idx == 2,:);
disp('Cluster 2');
disp(cluster2);

if NumCluster == 3 then
    cluster3 = setups(idx == 3,:);
    disp('Cluster 3');
    disp(cluster3);
end
