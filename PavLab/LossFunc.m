function L = LossFunc(b,x,y,w)

% LossFunc - function of losses calculation 
% Author: Maxim Panov, MIPT, group 674 
% 
% Purpose: calculates function of losses 
% Input: rate of weights changing ,vector of features,class label, 
%        vector of weights
% Output: value of function of losses
% 
% Example: 
% b = 2
% x = [0.5,0.5,-1] 
% y = 1
% w = [1.5,1,0.5]
% LossFunc(b,x,y,w) produces
% z: [1x1 double]
% where
%     z = 0.0561      
%
% Local Variables
% f - scalar value of activation function
% L - scalar value of function of losses

f = 1./(1+exp(-x*w')); %get value of activation function
w = w - 2*b*(f - y)*(1-f)*f*x; %change weights
f = 1./(1+exp(-x*w')); %get new value of activation function
L = (f - y).^2; %get value of function of losses
return
