function [ silhouettes ] = Silhouette_Width(parcels, Z)
    [parcels,~]= relabel(parcels);
%     if len(parcels.shape) >= 2
%         parcels = parcels.squeeze(-1);
    K = length(unique(parcels));
    SI = zeros(K, 1);
    %N = parcels.shape[0]
    N = length(parcels);
    for i = 1 : K + 1
        in_members = (parcels == i);
        out_members = (parcels ~= i);

        in_nk = sum(in_members);
        out_nk = N - in_nk;

        corrs = Z(in_members, :);
        corrs = corrs(:, in_members);
        corrs = corrs';
        I = eye(length(corrs));
        %A = np.array(I, dtype=bool)
        A = logical(I);
        corrs(A) = 0;
        means_in = sum(corrs, 1) / ((in_nk - 1)*in_nk);
        ak = mean(means_in);

        un_corrs = Z(in_members, :);
        un_corrs = un_corrs(:, out_members);
        means_out = sum(un_corrs, 1) / (in_nk * out_nk);
        bk = mean(means_out);
        if ak == 0 && bk == 0
            SI(i) = 0;
        else
            SI(i) = (ak - bk) / max(ak, bk);
        %corrs[]
        end
    end
silhouettes =  mean(SI);