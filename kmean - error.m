load discrim
M = csvread('C:\Users\karun\Downloads\pyAudioAnalysis-master\pyAudioAnalysis-master\goo.csv');
disp('actual matrix')
sz = size(M);
disp(sz);
[coeff] = pca(M);
reducedDimension = coeff(:,1:5);
disp('after PCA');
sa = size(reducedDimension);
disp(sa);
X = M * reducedDimension;
disp('final matrix');
st = size(X);
disp(st);
idx5 = kmeans(X,5,'Distance','correlation','Replicates',10);
figure
[silh5,h] = silhouette(X,idx5,'city');
h = gca;
h.Children.EdgeColor = [.8 .8 1];
xlabel 'Silhouette Value'
ylabel 'Cluster'
mean(silh5)