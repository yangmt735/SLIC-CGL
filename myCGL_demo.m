function myCGL_demo(writeTo,data,r1,r2,c,kMeansReplicate,kMeansMaxIter)

warning off;
for CIndex = 1 :length(c)
     CTemp = c(CIndex);
    for r1Index = 1 : length(r1)
        r1Temp = r1(r1Index);
        for r2Index = 1 : length(r2)
            r2Temp = r2(r2Index);
            % Main algorithm
            fprintf('Please wait a few minutes\n');
            disp([', --r1--: ', num2str(r1Temp), ', --r2--: ', num2str(r2Temp)])
            [Zs, F,obj, runtime,H] = myCGL(data, r1Temp, r2Temp, CTemp);
            
            resFile = [writeTo ,'-spatial_c=', num2str(CTemp), '-r1=', num2str(r1Temp), '-r2=', num2str(r2Temp), '.mat'];
            save(resFile, 'Zs', 'F', 'obj', 'runtime','H');
            
            % label
            savefile = [writeTo '/label/'];
            if ~isdir(savefile)
                mkdir(savefile);
            end
            [ labels, ~ ] =  kmeans(F, CTemp, 'Display','final','Replicates', kMeansReplicate, 'MaxIter', kMeansMaxIter);
            save([savefile ,'-group_c=', num2str(CTemp), '-r1=', num2str(r1Temp), '-r2=', num2str(r2Temp), '.mat'], 'labels');
            
            for s = 1:length(H)
                [ labels, ~ ] =  kmeans(H{s}, CTemp, 'Display','final','Replicates', kMeansReplicate, 'MaxIter', kMeansMaxIter);
                save([savefile ,'-subject' num2str(s) '_c=', num2str(CTemp), '-r1=', num2str(r1Temp), '-r2=', num2str(r2Temp), '.mat'], 'labels');
            
            end
            
            %Runtime(idx) = runtime;
            disp(['runtime: ', num2str(runtime)]);
        end
    end
end

