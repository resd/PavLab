function z = OneLayerPerc(x,y)

% OneLayerPerc - linear classification algorithm 
% Author: Maxim Panov, MIPT, group 674 
% 
% Purpose: classify the objects in data matrix based on the features 
% Criteria: repeat until convergence,iterating stochastic gradient descent
% Input: matrix objects-features,vector of target values
% Output: vector of weights
% 
% Example -> see report
%
% Local Variables
% n - vector (number of objects,number of features)
% w - vector of weights
% f - vector of values of activation function
% L - vector of function of losses values
% Q - scalar value of sum-of-squares error function on the current step
% Q - scalar value of sum-of-squares error function on the previous step
% l - scalar rate of changing Q
% d1 - scalar number of steps to be made after convergence
% d - scalar number of steps have been made after convergence
% rate - scalar learning rate parameter
% i - scalar random number of an object
% m - vector of mean values of features
% acc - scalar criteria of reaching convergence

d1 = 10; %set number of steps to be made after convergence
acc = 0.005; %set criteria of reaching convergence

n = size(x);
l = 1/n(1);
%get small initial values of weights
w = repmat(-1/2/n(2),1,n(2)+1) + rand(1,n(2)+ 1)/n(2);
%centralize x
m = mean(x);
x = x - repmat(m,n(1),1);
x = [x repmat(-1,n(1),1)];
%initial calculation of error function
f = 1./(1+exp(-x*w')); 
L = (f - y).^2; 
Q = sum(L); 
Q1 = Q + 1;
d = 0;
%stochastic gradient descent main cycle
while (((abs(Q - Q1)) > acc)||(d < d1)) 
    i = ceil(rand(1,1)*n(1)); %get random number of an object
    f(i) = 1./(1+exp(-x(i,:)*w'));
    L(i) = (f(i) - y(i)).^2;
    rate = fminbnd(@(b) LossFunc(b,x(i,:),y(i),w),0,1); %get rate using 
    %gold section methode for one parameter optimization
    w = w - 2*rate*(f(i) - y(i))*(1-f(i))*f(i)*x(i,:); %update weights
    
    if ((abs(Q - Q1)) < acc) 
        d = d+1;
    else
        d = 0;
    end;
    Q1 = Q;
    Q = (1-l)*Q + l*L(i); %update Q
end;
%return to non-centralized values of features
w(n(2)+1) = w(n(2)+1) + [m -1]*w';
z = w; %yield
return