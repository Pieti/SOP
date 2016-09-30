function Plotter(matrixToPlot1, matrixToPlot2)
    length = size(matrixToPlot1,1);

    x = 1:length;
    y = ones(1, length);

    x = [ x 1:length ];
    y = [ y zeros(1, length)];
    
    graph_dotSize = 25;
    %c = rand(6,3);
    c = [matrixToPlot1; matrixToPlot2];
    
    scatter(x,y,graph_dotSize,c,'filled')
end