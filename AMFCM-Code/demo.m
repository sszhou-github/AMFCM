%sample code to compare FCM and the new proposed MSFCM
%  load satimage;%%obtain "data" as training dataset, "label" as its target.



dataset_str={'satimage'};
%     'led7','Abalone','shuttle','COIL20','feret','cifar10','AR'};
%     ,'iris','led7','satimage','segment','COIL20','Abalone','feret'};
%,'Avila','shuttle','Seismic','Abalone','led7','feret','COIL20'};
cluster_n1=[6];
% 10,28,7,20,200,10,10];,3,10,6,7,20,28,200];
Restarts=1;
for j=1:Restarts
    for i=1:length(dataset_str)
        load(dataset_str{i});
        expo=2;
        MaxIte  = 5000;        % Max. iteration
        error = 10^-6;  % Min. improvement
        cluster_n=cluster_n1(i);
        [data_n,data_s] = size(data); 
        U0 = rand(cluster_n, data_n);U0=bsxfun(@rdivide,U0,sum(U0,1));
        
  
        [U_final, V_final, time_final(j), iter_final(j),label_final]=AMFCM(data, U0, cluster_n, expo,MaxIte,error);
        PC_final(j) = Index_PC(U_final, data, expo);
        XB_final(j) = Index_XB( cluster_n, V_final, U_final, data, expo) ;
        DB_final(j) = Index_DB( cluster_n, V_final, U_final, data, expo) ;
        [FM_final(j), ARI_final(j), NMI_final(j)] = evaluate(label, label_final');
    end
end
    %%%%%%
    aver_time=mean(time_final);var_time=std(time_final);
    aver_iter=mean(iter_final);var_iter=std(iter_final);

    aver_PC=mean(PC_final);var_PC=std(PC_final);
    aver_XB=mean(XB_final);var_XB=std(XB_final);
    aver_DB=mean(DB_final);var_DB=std(DB_final);

    aver_FM1=mean(FM_final);var_FM1=std(FM_final);
    aver_ARI=mean(ARI_final);var_ARI=std(ARI_final);
    aver_NMI=mean(NMI_final);var_NMI=std(NMI_final);
    



