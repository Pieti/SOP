%{
compute_input metodi jäi vaiheeseen ( ainakin testaamatta ).

Lisäksi update_weights, get_minimum ovat tärkeitä.
http://mnemstudio.org/ai/nn/som_python_ex2.txt
%}

classdef SomClass
   properties
       mClusters;
       mVectorLength;
       mMinAlpha;
       mDecayRate;
       mReductionPoint;
       mWeightArray;
       mDeltaVector;
       
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
         else
             disp('somclass - wrong argument count');
         end
      end
      
      % In progress
      function compute_input(obj, vector)
        obj.mDeltaVector = zeros(obj.mClusters, 1);
        
        for i = 1:obj.mClusters
            obj.mDeltaVector = norm(obj.mWeightArray(i), vector); % not sure about mWeigh index TODO : check
        end
      end
   end
end