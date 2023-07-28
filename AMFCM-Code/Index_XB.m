function index = Index_XB( cluster_n, P, U, data, expo)

data_n = size(data,1);
dim_n = size(data,2);

mf = U.^expo;       % MF matrix after exponential modification
dist = distfcm(P, data);       % fill the distance matrix
EK = sum( sum((dist.^2).*mf) );  % objective function

dist_P_P = distfcm( P, P ).^2;

DK = dist_P_P(1,2);
for i = 1:1:cluster_n
    for j=1:1:cluster_n
        if i~=j
           if DK > dist_P_P(i,j)
               DK = dist_P_P(i,j);
           end
        end
    end
end

index = EK / (data_n * DK );