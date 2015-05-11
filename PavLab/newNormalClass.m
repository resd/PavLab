function class= newNormalClass(M, D)
% new class creation
% n – kol-vo priznakov
% N – kol-vo elementov
% M – vector mat ojidaniy
% D – vector dispersiyy
N=100;
n=2;
class = randn(N,n);
% mashtabirovanie
class(:,1) = round(M(1) + D(1)*(class(:,1)-0.5));
class(:,2) = round(M(2) + D(2)*(class(:,2)-0.5));
end