close all
clear all

SPEC_DATA_FOLDER =   'results\spectrogram\';
load setups;

%plotlysetup('edielsonpf','6524edfr');
%plotly_path = fullfile(pwd, 'plotly');
%addpath(genpath(plotly_path));
%plotlyupdate
%===========================================================

fileData = 1;

Ms=[];
MsIndex=1;
FileIndex=1;
fid1 = fopen('file_list.txt','r');
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

%X1=Ms(:,1:15)';
X1=Ms';
%disp(X1);

%covariance
%[pcaY,scoreY,latentY,tsquareY]=princomp(X1);
%correlation
[pcaY,scoreY,latentY,tsquareY]=princomp(zscore(X1));
%disp(size(scoreY));
%disp(cumsum(latentY)./sum(latentY));
%disp(scoreY(:,1:4));
%disp(size(pcaY));
%disp(pcaY);
csvwrite('pca.txt',scoreY(:,1));

fig=figure();
pareto(latentY)
xlabel('Principal Component')
ylabel('Variance Explained (%)')
%fig2plotly(fig);
%=======================================================================
%mounting cluster wuth PC1 and MRR
load mrr;
X=[MRR, scoreY(:,1)];
%disp(X);

%finding clustetrs for tool and workpiece conditions
K=3;
%training GMM models for each cluster
options = statset('Display','final');
GMModel = gmdistribution.fit(X,K,'Options',options,'Replicates',5);
disp('Componentes Means');
ComponentMeans = GMModel.mu;
disp(ComponentMeans);
disp('Componentes Covariances');
ComponentCovariances = GMModel.Sigma;
disp(ComponentCovariances);
disp('Mixture Proportions');
MixtureProportions = GMModel.PComponents;
disp(MixtureProportions);
[P,nlogl] = posterior(GMModel,X);

idx = cluster(GMModel,X);
%disp('GMM clusters');
disp(idx);

%Z = linkage(X,'ward','euclidean');
%idx = cluster(Z,'maxclust',2);

cluster1 = (idx == 1);
cluster2 = (idx == 2);
cluster3 = (idx == 3);

figure
scatter(X(cluster1,1),X(cluster1,2),30,P(cluster1,1),'+')
hold on
scatter(X(cluster2,1),X(cluster2,2),30,P(cluster2,1),'o')
hold on
scatter(X(cluster3,1),X(cluster3,2),30,P(cluster3,1),'^')
hold off
legend('Cluster 1','Cluster 2','Cluster 3','Location','NW')
clrmap = jet(80); colormap(clrmap(9:72,:))
ylabel(colorbar,'Component 1 Posterior Probability')
xlabel('MRR');
ylabel('PCA');
%fig2plotly();

%hold on
%h = ezcontour(@(x,y)pdf(GMModel,[x y]),[-12 20],[-35 55]);
%hold off

%cluster1 = setups(idx == 1,:);
%cluster2 = setups(idx == 2,:);
%cluster3 = setups(idx == 3,:);
%disp('Cluster 1');
%disp(cluster1);
%disp('Cluster 2');
%disp(cluster2);
%disp('Cluster 3');
%disp(cluster3);

%========================================================================
load ry;
X2=[MRR,Ry];
K=2;
%training GMM models for each cluster
options = statset('Display','final');
GMModel2 = gmdistribution.fit(X2,K,'Options',options,'Replicates',5);
P2 = posterior(GMModel2,X2);
idx = cluster(GMModel2,X2);

%Z = linkage(X2,'ward','euclidean');
%idx = cluster(Z,'maxclust',2);

cluster1 = (idx == 1);
cluster2 = (idx == 2);

figure
scatter(X2(cluster1,1),X2(cluster1,2),10,P2(cluster1,1),'+')
hold on
scatter(X2(cluster2,1),X2(cluster2,2),10,P2(cluster2,1),'o')
hold off
legend('Cluster 1','Cluster 2','Location','NW')
clrmap = jet(80); colormap(clrmap(9:72,:))
ylabel(colorbar,'Component 1 Posterior Probability')
xlabel('MRR');
ylabel('Ry');
%cluster1 = setups(idx == 1,:);
%cluster2 = setups(idx == 2,:);
%cluster3 = setups(idx == 3,:);
%disp('Cluster 1');
%disp(cluster1);
%disp('Cluster 2');
%disp(cluster2);
%disp('Cluster 3');
%disp(cluster3);

%========================================================================
X3=[scoreY(:,1),Ry];
K=2;
%training GMM models for each cluster
options = statset('Display','final');
GMModel3 = gmdistribution.fit(X3,K,'Options',options,'Replicates',5);
P3 = posterior(GMModel3,X3);
idx = cluster(GMModel3,X3);

cluster1 = (idx == 1);
cluster2 = (idx == 2);

figure
scatter(X3(cluster1,1),X3(cluster1,2),10,P3(cluster1,1),'+')
hold on
scatter(X3(cluster2,1),X3(cluster2,2),10,P3(cluster2,1),'o')
hold off
legend('Cluster 1','Cluster 2','Location','NW')
clrmap = jet(80); colormap(clrmap(9:72,:))
ylabel(colorbar,'Component 1 Posterior Probability')
xlabel('PCA');
ylabel('Ry');

%========================================================================
load vc;
X4=[scoreY(:,3),vc];
K=2;
%training GMM models for each cluster
options = statset('Display','final');
GMModel4 = gmdistribution.fit(X4,K,'Options',options,'Replicates',5);
P4 = posterior(GMModel4,X4);
idx = cluster(GMModel4,X4);

cluster1 = (idx == 1);
cluster2 = (idx == 2);

figure
scatter(X4(cluster1,1),X4(cluster1,2),10,P4(cluster1,1),'+')
hold on
scatter(X4(cluster2,1),X4(cluster2,2),10,P4(cluster2,1),'o')
hold off
legend('Cluster 1','Cluster 2','Location','NW')
clrmap = jet(80); colormap(clrmap(9:72,:))
ylabel(colorbar,'Component 1 Posterior Probability')
xlabel('PCA(3)')
ylabel('Vc')

%========================================================================
load f;
X5=[scoreY(:,1),f];
K=2;
%training GMM models for each cluster
options = statset('Display','final');
GMModel5 = gmdistribution.fit(X5,K,'Options',options,'Replicates',5);
P5 = posterior(GMModel5,X5);
idx = cluster(GMModel5,X5);

cluster1 = (idx == 1);
cluster2 = (idx == 2);

figure
scatter(X5(cluster1,1),X5(cluster1,2),10,P5(cluster1,1),'+')
hold on
scatter(X5(cluster2,1),X5(cluster2,2),10,P5(cluster2,1),'o')
hold off
legend('Cluster 1','Cluster 2','Location','NW')
clrmap = jet(80); colormap(clrmap(9:72,:))
ylabel(colorbar,'Component 1 Posterior Probability')
xlabel('PCA(1)')
ylabel('f')

%========================================================================
load f;
X6=[Ry,f];
K=2;
%training GMM models for each cluster
options = statset('Display','final');
GMModel6 = gmdistribution.fit(X6,K,'Options',options,'Replicates',5);
P6 = posterior(GMModel6,X6);
idx = cluster(GMModel6,X6);

cluster1 = (idx == 1);
cluster2 = (idx == 2);

figure
scatter(X6(cluster1,1),X6(cluster1,2),10,P6(cluster1,1),'+')
hold on
scatter(X6(cluster2,1),X6(cluster2,2),10,P6(cluster2,1),'o')
hold off
legend('Cluster 1','Cluster 2','Location','NW')
clrmap = jet(80); colormap(clrmap(9:72,:))
ylabel(colorbar,'Component 1 Posterior Probability')
xlabel('Ry')
ylabel('f')