
 addpath('H:\HCP\SL-CGL\function\');
 addpath('H:\HCP\SL-CGL\lib\');

%group-parcel
load('F:\SL-CGL\g\LR_out\idx-g.mat');
% Set parameters
subjectIDs      = dlmread('SubjectsId.txt');
percent = 0.1;
Thrset = 1;%Thrset = [1,2,3,4,5];
r1 = 5;
r2 = 50;
c = [100 200 300 400 500];
kMeansReplicate = 10; % Kmeans replicates 
kMeansMaxIter   = 500; % Kmeans max iteration
% super timeseries createFC
for t = 1: length(Thrset)
    thr = Thrset(t);
    writeTo = ['F:\SL-CGL\spatial-' num2str(thr) '\LR_out\'];
    if ~isdir(writeTo)
        mkdir(writeTo);
    end
    lfile = [writeTo 'spatial_Superbunches_' num2str(percent) '.mat'];
load(lfile,'Superbunches_p');

% CGL + label

myCGL_demo(writeTo,Superbunches_p,r1,r2,c,kMeansReplicate,kMeansMaxIter);

end
