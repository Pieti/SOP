clear; 

% for generating learning/test data
% variable name in file is always 'data' ( must be same in loading )

data_size = 20;
vector_len = 3; 
filename = 'learn_data.mat';

data = rand(data_size,vector_len);

save(filename, 'data');
