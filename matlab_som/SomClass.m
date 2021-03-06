%{

Matlabin luokat on erikoisia, aina pit�� palauttaa objekti jos haluaa tehd� 
muutoksia luokkaan. (toinen vaihtoehto k�ytt�� referenssi� 'classdef item < handle' ) 

voi olla ett� t�ll� hetkell� tapahtuu paljon tiedon kopiointia muuttujasta
toiseen, en ole perehtynyt matlabin toimintaan, mutta referenssin k�ytt�
varmistaisi ainakin ettei jokaista parametri� kopioida uuteen muuttujaan.

Mallia katsottu
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

        function obj = compute_input(obj, patternArray, vecNumber)
            %obj.testVariable = true;
            obj.mDeltaVector = zeros(obj.mClusters, 1);
            for i = 1:obj.mClusters
                %display(obj.mWeightArray(i,:));
                %display(vector)
                d = obj.mWeightArray(i,:) - patternArray(vecNumber,:);
                obj.mDeltaVector(i) = sum(d.^2);
                %display(obj.mDeltaVector(i));
            end
            %display(['test ', num2str(obj.testVariable)]);
        end
        
        %this function cannot store variables thus it does not return obj
        function minimum = get_minimum(~, nodeArray)
            %display(['test ', num2str(obj.testVariable)]);
            [~, minimum] = min(nodeArray); % save index to minimum
        end
        
    
    
        function obj = training(obj, patternArray)
            iterations = 0;
            reductionFlag = false;
            reductionPoint = 0;

            %display(['obj mAlpha: ', num2str(obj.mAlpha)  ])
            %display(['obj mMinAlpha ', num2str(obj.mMinAlpha) ])
            
            while obj.mAlpha > obj.mMinAlpha
                iterations = iterations + 1;
                for i = 1:size(patternArray, 1)
                    obj = obj.compute_input(patternArray, i);
                    dMin = obj.get_minimum(obj.mDeltaVector);
                    obj = obj.update_weights(i, dMin, patternArray);
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
            display(['obj mAlpha: ', num2str(obj.mAlpha)  ])
            display(['obj mMinAlpha ', num2str(obj.mMinAlpha) ])
            
        end
        
        function obj = update_weights(obj, vectorNumber, dMin, patternArray)
            for i = 1:obj.mVectorLength
                % Update the winner.
                obj.mWeightArray(dMin, i) = obj.mWeightArray(dMin, i) + (obj.mAlpha * (patternArray(vectorNumber, i) - obj.mWeightArray(dMin, i)));

                % Only include neighbors before radius reduction point is reached.
                if obj.mAlpha > obj.mReductionPoint
                    if (dMin > 1) && (dMin < (obj.mClusters)) % TODO : CHECK THIS 
                        % Update neighbor to the left...
                        obj.mWeightArray(dMin - 1, i) = obj.mWeightArray(dMin - 1, i) + (obj.mAlpha * (patternArray(vectorNumber, i) - obj.mWeightArray(dMin - 1, i)));
                        % and update neighbor to the right.
                        obj.mWeightArray(dMin + 1, i) = obj.mWeightArray(dMin + 1, i) + (obj.mAlpha * (patternArray(vectorNumber, i) - obj.mWeightArray(dMin + 1, i)));
                    else
                        if dMin == 1 % TODO : CHECK
                            % Update neighbor to the right.
                            obj.mWeightArray(dMin + 1, i) = obj.mWeightArray(dMin + 1, i) + (obj.mAlpha * (patternArray(vectorNumber, i) - obj.mWeightArray(dMin + 1, i)));
                        else
                            % Update neighbor to the left.
                            obj.mWeightArray(dMin - 1, i) = obj.mWeightArray(dMin - 1, i) + (obj.mAlpha * (patternArray(vectorNumber, i) - obj.mWeightArray(dMin - 1, i)));

                        end
                    end
                end
            end
        end           
    end
end