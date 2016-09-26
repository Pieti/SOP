%{
compute_input > oikean tyyppinen ulostulo, arvoja ei validoitu 
get_minimum > oikea tyyppi, arvoja ei validoitu
training Kesken ja testaamatta

Matlabin luokat on erikoisia, aina pit‰‰ palauttaa objekti jos haluaa tehd‰ 
muutoksia luokkaan. (toinen vaihtoehto k‰ytt‰‰ referenssi‰ 'classdef item < handle' ) 


Lis‰ksi update_weights, get_minimum ovat t‰rkeit‰.
http://mnemstudio.org/ai/nn/som_python_ex2.txt
%}

classdef SomClass
    properties (Access=public)
        mClusters;
        mVectorLength;
        mMinAlpha;
        mDecayRate;
        mReductionPoint;
        mWeightArray;
        mDeltaVector;
        mAlpha;
        testVariable;
    end
    
    methods
        % constructor 
        function obj = SomClass(clusters, vectorLength, minAlpha, decayRate, reductionPoint)
            if (nargin == 5)
                obj.mClusters = clusters;
                obj.mVectorLength = vectorLength;
                obj.mMinAlpha = minAlpha;
                obj.mDecayRate = decayRate;
                obj.mReductionPoint = reductionPoint;
                obj.mWeightArray = rand(obj.mClusters, obj.mVectorLength);
                obj.mDeltaVector = zeros(obj.mClusters, 1);
                obj.mAlpha = 0.6; % TODO : Find this out what is this
                %obj.testVariable = false; % TODO : remove this
            else
            	disp('somclass - wrong argument count');
            end
        end

        function obj = compute_input(obj, vector)
            %obj.testVariable = true;
            obj.mDeltaVector = zeros(obj.mClusters, 1);
            for i = 1:obj.mClusters
                %display(obj.mWeightArray(i,:));
                %display(vector)
                d = obj.mWeightArray(i,:) - vector;
                obj.mDeltaVector(i) = sum(d.^2);
                %display(obj.mDeltaVector(i));
            end
            %display(['test ', num2str(obj.testVariable)]);
        end
        
        %this function cannot store variables thus it does not return obj
        function minimum = get_minimum(obj, nodeArray)
            %display(['test ', num2str(obj.testVariable)]);
            minimum = min(nodeArray);
        end
        
    
    
        function obj = training(obj, patternArray)
            iterations = 0;
            reductionFlag = false;
            reductionPoint = 0;

            while obj.mAlpha < obj.mMinAlpha
                iterations = iterations + 1;
                for i = 1:size(patternArray, 1)
                    obj.compute_input(patternArray, i)
                    dMin = obj.get_minimum(obj.DeltaVector);
                    obj.update_weights(i, dMin, patternArray)
                end
                % Reduce the learning rate.
                obj.mAlpha = obj.mDecayRate * obj.mAlpha;

                % Reduce radius at specified point.
                if obj.mAlpha < obj.mReductionPoint
                    if reductionFlag == false
                        reductionFlag = true;
                        reductionPoint = iterations;
                    end
                end
            end

            display(['Iterations: ', num2str(iterations)  ])
            display(['Neighborhood radius reduced after ', num2str(reductionPoint), ' iterations'])

            end   
    end
end