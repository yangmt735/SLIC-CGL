function [prr_data,newdata] = mycreateFC(data,superVertices,R,Thr)
   
    norm_data = zscore(data);
    prr_data = corr(transpose(norm_data));
    newdata = prr_data;
    
    for j = 1:length(superVertices)
        for k = 1:length(superVertices)
            
            dx = (superVertices(j,1)-superVertices(k,1)).*(superVertices(j,1)-superVertices(k,1));
            dy = (superVertices(j,2)-superVertices(k,2)).*(superVertices(j,2)-superVertices(k,2));
            dz = (superVertices(j,3)-superVertices(k,3)).*(superVertices(j,3)-superVertices(k,3));
            dg = sqrt(dx+dy+dz);
            [ dists ] = mydist( dg, R );
            dist(j,k) = dists;
            if dists > Thr
                newdata(j,k) = 0;
            end
        end
    end
