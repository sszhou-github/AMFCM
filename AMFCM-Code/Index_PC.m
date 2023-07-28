function index = Index_PC(  U, data, expo)

data_n = size(data,1);
mf = U.^expo;       % MF matrix after exponential modification
index=sum(sum(mf))/data_n;

