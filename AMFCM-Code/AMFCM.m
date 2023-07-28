function [U, V,t ,it,label]=AMFCM(data, U0, cluster_n, expo,max_it,min_impro)
%%AMFCM algorithms with given initial points U
%%No objective computing.
t=cputime; it =1;
mf = U0.^expo;       % MF matrix after exponential modification
V0 = (mf)*data./(sum((mf),2)*ones(1,size(data,2))); %new center
it=it+1;

while it<max_it
    dist = dist2fcm(V0, data);       % fill the distance matrix
     tmp = dist.^(-2/(expo-1));      % calculate new U, suppose expo != 1
     U = tmp./(ones(cluster_n, 1)*sum(tmp));
     mf=U.^expo ;     
     V1=mf*data./(sum(mf,2)*ones(1,size(data,2)));%得到的中心点

    %%New scaling methods
    div_dis=sqrt(sum((V0-V1).^2,2))';
    
     [dis, dis_index]=sort(dist);
        I=dist  - ones(cluster_n,1)*(dis(1,:) + div_dis(dis_index(1,:)))  - div_dis'*ones(1,size(data,1));
        a=length(I>0);
        if a>0
            tmp(find(I>0))=0;
            U=tmp./(ones(cluster_n, 1)*sum(tmp));
            mf = U.^expo;       % MF matrix after exponential modification
            V= mf*data./(sum(mf,2)*ones(1,size(data,2))); %new center
        else
            V=V1;
        end
   if norm( V- V0, 'fro') <= min_impro, break;    end
    V0=V; it=it+1;
end
t=cputime - t;
dist = dist2fcm(V, data);       % fill the distance matrix
tmp = dist.^(-2/(expo-1));      % calculate new U, suppose expo != 1
U = tmp./(ones(cluster_n, 1)*sum(tmp));
[~,label]=max(U);
end

