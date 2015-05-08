 function class= newClass(a)
% new class creation
% n – kol-vo priznakov
% N – kol-vo elementov
% M – vector mat ojidaniy
% D – vector dispersiyy
M1=[11.2 23.7];
M2=[17.8 24.8];
D1=[2.3 1.2];
D2=[1 0.9];
N=100;
n=2;
class = randn(N,n);
% mashtabirovanie
if (a == 1)
    class(:,1) = round(M1(1) + D1(1)*(class(:,1)-0.5));
    class(:,2) = round(M1(2) + D1(2)*(class(:,2)-0.5));
else
    class(:,1) = round(M2(1) + D2(1)*(class(:,1)-0.5));
    class(:,2) = round(M2(2) + D2(2)*(class(:,2)-0.5));
end

end