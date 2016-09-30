clear;

%{
  Tarkoituksena on siis tehdä aluksi random painomatriisi kooltaan clusterien määrä X näytteenvektorin pituus
    ( visualisoitu ylös )
  
  Tämän jälkeen päivittää painovektoria niin kauan että jokaiselle random
  värille löytyy clusteri tarpeeksi läheltä 

  Lopuksi visualisoidaan lopullinen painomatriisi ( alhaalla )
 
 Tarkoitus on siis toteuttaa tämä http://www.ai-junkie.com/ann/som/som1.html, poikkeuksena
 toteutetaan som verkolla jossa nodet on sijoitettu vierekkäin ( kun alkuperäisessä kaksiulotteinen vektori ). Koodin pitäisi vastata
 tätä
http://mnemstudio.org/ai/nn/som_python_ex2.txt


Tilanne 30.9: ohjelma mutta tulokset eivät vaikuta olevan oikeita. 
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
%Voidaan toteuttaa metodi jossa syötteenä on ( x,y,color ) vektoreita ja
%piirtää se scatterin avulla.
 

%%}