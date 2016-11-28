function [residualMotionData]=residualMotion(timeData,motionData);

order=1;
coef = polyfit(timeData,motionData,order);
predictedValues = polyval(coef,timeData);

residualMotionData = minus(motionData,predictedValues);

end
