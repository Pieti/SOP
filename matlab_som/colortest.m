clear;

learn_data_file = 'learn_data.mat';
clusters = 16;
vector_len = 3;
decay_rate = 0.96;
min_alpha = 0.01;
radius_reduction = 0.02;

delta_vector = zeros(clusters, 1);

weight_matrix = rand(clusters, vector_len);

load(learn_data_file, 'data'); 
learn_data = data; 
clear data;

mySom = SomClass(clusters, vector_len, min_alpha, decay_rate, radius_reduction);

% test compute_input method
mySom = mySom.compute_input([0.4, 0.5, 0.6]);

d = get_minimum(mySom, mySom.mDeltaVector);

display(d);

%{ 
One way to plot color dots
Voidaan toteuttaa metodi jossa sy�tteen� on ( x,y,color ) vektoreita ja
piirt�� se scatterin avulla.
 
x = [0, 0, 1, 1, 2, 2];
y = [0, 1, 0, 1, 0, 1];

size = 25;
c = rand(6,3);

scatter(x,y,size,c,'filled')
%}