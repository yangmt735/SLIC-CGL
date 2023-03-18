function [superBunches,superVertices,N] = mysupervertex(subjectID,Idx,superLabels,hem,saveOutput)
%% Set input/output directorie

readFrom = ['H:/Structural_preproc/' subjectID '/MNINonLinear/fsaverage_LR32k/'];
% Please set the directory the files will be read from, if not specified,
% the output directory will be set automatically.

writeTo = ['H:/HCP/SL-CGL/5/out/' subjectID '/'];
if ~isdir(writeTo)
    mkdir(writeTo);
end
     
%% Load surface files
fileName = [subjectID '.' hem '.midthickness.32k_fs_LR.surf.gii'];
g = gifti([readFrom fileName]);  
vGray = g.vertices;
fGray = g.faces;

fileName = [subjectID '.' hem '.atlasroi.32k_fs_LR.shape.gii'];
g = gifti([readFrom fileName]);  
corticalMask = g.cdata;

%% Load data   E:/HCP test-retest/103818.rar/MNINonLinear/Results/rfMRI_REST1_LR/
fileName = ['H:/HCP_test-retest/' subjectID '.rar/MNINonLinear/Results/rfMRI_REST1_LR/rfMRI_REST1_LR_Atlas_hp2000_clean.dtseries.nii'];
dtseries = read_cifti(fileName);
timeseries = get_cortical_timeseries( dtseries, hem );
%timeseries = dtseries(1:Vertices,:);

% Mappers
[ map32to29, map29to32 ] = cortical_mappers(corticalMask);  
    for i = 1 : length(Idx)
        idx = Idx{i,1};        
        bunch = timeseries(idx,:);
        superBunches(i,:) = mean(bunch,1);    
        mapped = map29to32(idx);        
        superVertices(i, :) = mean(vGray(mapped,:), 1);
    end

%% Compute the adjacency matrix for supervertices
N = find_neighbours_among_supervertices(length(superVertices), superLabels, corticalMask, fGray);            
%% Save output data structures for further analysis 
if saveOutput
    save([writeTo 'superBunches_' hem '.mat'],'superBunches');
    save([writeTo 'superVertices_' hem '.mat'],'superVertices');
    save([writeTo 'N_' hem '.mat'], 'N');
    disp('All generated files have been saved...');
end
        