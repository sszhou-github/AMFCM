function index = Index_DB( cluster_n, P, U, data, expo)

data_n = size(data,1);

dist_P_P = distfcm( P, P ).^2;

lable = zeros(data_n,1);
S = zeros(cluster_n,1);
R = zeros(cluster_n,1);

for k=1:1:data_n
    [YY, lable(k)] = max( U(:,k) );
end

for i=1:1:cluster_n
    sum1 = 0;
    count = 0;
    for k=1:1:data_n
        if lable(k) == i
           sum1 = sum1 +  sum( ( data(k,:)-P(i, :) ).^2 ) ;
           count = count +1;
        end
    end
    S(i) = sum1 / count ;
end

for i=1:1:cluster_n
    R(i)=0;
    for j=1:1:cluster_n
        if j~=i
            tem = ( S(i) + S(j) ) / dist_P_P(i,j);
            if R(i) < tem
                R(i) = tem;
            end
        end
    end
end

index = sum ( R ) / (cluster_n );


