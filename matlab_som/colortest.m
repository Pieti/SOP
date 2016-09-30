clear;

%{
  Tarkoituksena on siis tehd� aluksi random painomatriisi kooltaan clusterien m��r� X n�ytteenvektorin pituus
    ( visualisoitu yl�s )
  
  T�m�n j�lkeen p�ivitt�� painovektoria niin kauan ett� jokaiselle random
  v�rille l�ytyy clusteri tarpeeksi l�helt� 

  Lopuksi visualisoidaan lopullinen painomatriisi ( alhaalla )
 
 Tarkoitus on siis toteuttaa t�m� http://www.ai-junkie.com/ann/som/som1.html, poikkeuksena
 toteutetaan som verkolla jossa nodet on sijoitettu vierekk�in ( kun alkuper�isess� kaksiulotteinen vektori ). Koodin pit�isi vastata
 t�t�
http://mnemstudio.org/ai/nn/som_python_ex2.txt


Tilanne 30.9: ohjelma mutta tulokset eiv�t vaikuta olevan oikeita. 
%}

learn_data_file = 'learn_data.mat';
clusters = 16;
vector_len = 3;
decay_rate = 0.96; % default 0.96
min_alpha = 0.01; % default 0.01
radius_reduction =  0.023; % default 0.023

delta_vector = zeros(clusters, 1);

% init weight matrix, and save
weight_matrix = rand(clusters, vector_len);

load(learn_data_file, 'data'); 
learn_data = data; 
clear data;

mySom = SomClass(clusters, vector_len, min_alpha, decay_rate, radius_reduction);

mySom = mySom.training(learn_data);

Plotter(weight_matrix, mySom.mWeightArray);

% test compute_input method
%mySom = mySom.compute_input([0.4, 0.5, 0.6]);

%d = get_minimum(mySom, mySom.mDeltaVector);

%display(d);

%%{ 
%One way to plot color dots
%Voidaan toteuttaa metodi jossa sy�tteen� on ( x,y,color ) vektoreita ja
%piirt�� se scatterin avulla.
 

%%}