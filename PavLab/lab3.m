%-------------------------------------LAB3
s=sprintf('%s','LAB3:');disp(s);

clear all;

clc;

%������������� ������� ���. �������� � ��������� ��������� � �������
%�������� �������� �������
%load class1M.txt;
%load class1D.txt;
%load class2M.txt;
%load class2D.txt;

n=2;
L=5000;
k=20;
p=20;
class1D = [0.7, 1.1];
class2D = [0.9, 1.0];
class1M = [1.8, 1.1];
class2M = [4.3, 2.7];

%������������ ������� L � n ��������� ����� � ���������� ������� �������������
class1 = randn(L,n);
class2 = randn(L,n);
%������������ ������� L � n ��������� ����� � ����������� ������� �������������
%class1 = rand(L,n);
%class2 = rand(L,n);

%��������������� ��������� �������������� ������� �������� �������� (������� 1) ��� ������� ��������
class1(:,1) = class1M(1) + class1D(1)*(class1(:,1));
class2(:,1) = class2M(1) + class2D(1)*(class2(:,1));
%��� ������������ ������ �������������
%class1(:,1) = class1M(1) + 6*class1D(1)*(class1(:,1)-0.5);
%class2(:,1) = class2M(1) + 6*class2D(1)*(class2(:,1)-0.5);

%��� ������� ��������
class1(:,2) = class1M(2) + class1D(2)*(class1(:,2));
class2(:,2) = class2M(2) + class2D(2)*(class2(:,2));
%��� ������������ ������ �������������
%class1(:,2) = class1M(2) + 6*class1D(2)*(class1(:,2)-0.5);
%class2(:,2) = class2M(2) + 6*class2D(2)*(class2(:,2)-0.5);

X1 = class1M(1)+(class2M(1)-class1M(1))/2;
X2 = class1M(2)+(class2M(2)-class1M(2))/2;
k = -(class1M(1)-class2M(1))/(class1M(2)-class2M(2));
c = X2-X1*k;

tmin = min(class1(:,1));
tmax = max(class2(:,1));

X2min = k*tmin + c;
X2max = k*tmax + c;

%todo
%����������� ��������� �������������� ������� � ������������ ��������� x1, x2
%figure(12);plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+', class1M(1),class1M(2),'*g', class2M(1),class2M(2),'*g', X1, X2,'*g');hold on;
%���������� ��������� ��������� �������
%figure(12);plot([class1M(1),class2M(1)], [class1M(2),class2M(2)], 'k');hold on;
%figure(12);plot([tmin, tmax], [X2min, X2max], 'k');hold on;

%����������� �������������� �������������
%������ �������������� �������
S1 = cov(class1);        
S2 = cov(class2);

AS1 = inv(S1);
AS2 = inv(S2);

DS1 = COND(S1);
DS2 = COND(S2);

c = 0.5*log(DS2/DS1);
a6 = 0.5*(AS2(1,1) - AS1(1,1));
a5 = (AS2(1,2) - AS1(1,2));
a4 = 0.5*(AS2(2,2) - AS1(2,2));
b1 = AS1*class1M' - AS2*class2M';
a3 = b1(1);
a2 = b1(2);
a1 = -0.5*(class1M*AS1*class1M' - class2M*AS2*class2M') + 0.5*log(DS2/DS1);

%����������� �������� � ������������ ���������
i=1;
for t=tmin:((tmax-tmin)/p):tmax,
    z(i) = t;
    X = z(i);
    Y1(i) = (-(a5 * X + a2)+((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
	Y2(i) = (-(a5 * X + a2)-((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
    i=i+1;
end

%todo
%figure(21);plot(class1(:,1),class1(:,2),'b+',class2(:,1),class2(:,2),'ro', z,Y1,'-k',  z,Y2,'-k');hold on;

%���������� ���������� �������� �������������
err1 = 0;
err2 = 0;
P = 0;

% j=-1;
% for i=1:L
%     f(i,1)=0;
%     f(i,2)=j;
% end
% j=1;
% for i=L+1:2*L
%     f(i,1)=0;
%     f(i,2)=j;
% end

for i=1:L
    f(i,1) = a6*class1(i,1)^2 + a5*class1(i,1)*class1(i,2) + a4*class1(i,2)^2 + a3*class1(i,1) + a2*class1(i,2) + a1;
    if(f(i,1)<0)
        err1=err1+1;
    end

    f(i+L,1) = a6*class2(i,1)^2 + a5*class2(i,1)*class2(i,2) + a4*class2(i,2)^2 + a3*class2(i,1) + a2*class2(i,2) + a1;
    if(f(i+L,1)>0)
        err2=err2+1;
    end
end

err1
err2
P = 1 - (err1+err2)/(2*L)

[res, outf] = MSR(class1, class2, 2);
outf

% res = Amain(class1, class2, 2);
% outf = sprintf('�����������  =  %f\n������ 1 ����  =  %f\n������ 2 ����  =  %f\n', res(1), res(2), res(3));
% outf





%������������� ��������
%Imax = 20 � ���������� ������ ��������
%L=L1+L2 � ���������� ��������� � ��������� �������
%� � ������ ������������� ������������� ���������������� ������������ cnum
Imax = 20;
L = 100;

cnum = 6;
class = [class1; class2];
c(1:cnum) = 1;

%cmax(6) = 0.5*(AS2(1,1) - AS1(1,1));
%cmax(5) = (AS2(1,2) - AS1(1,2));
%cmax(4) = 0.5*(AS2(2,2) - AS1(2,2));
%b1 = AS1*class1M' - AS2*class2M';
%cmax(3) = b1(1);
%cmax(2) = b1(2);
%cmax(1)=-0.5*(class1M*AS1*class1M'-class2M*AS2*class2M')+� 0.5*log(DS2/DS1);

n1 = length(class1);
n2 = length(class2);
y(1:n1)=0;
y(n1+1:n1+n2)=1;


Pmax = 0;
err1max=0;
err2max=0;
iimax=0;
jjmax=0;
cmax=[];

%������������ ��������� ������ �������������� �������������

for (ii = 1:Imax)
	for (jj = 1:L)
        f = [];
		f(6) = class(jj,1)*class(jj,1);
		f(5) = class(jj,1)*class(jj,2);
		f(4) = class(jj,2)*class(jj,2);
		f(3) = class(jj,1);
		f(2) = class(jj,2);
		f(1) = 1;
        
		sum = f*c';
		ysum = y(jj) - sum;

		r(1:cnum, 1:cnum) = 0;

		if(((y(jj) > 0) & (ysum > 0)) | ((y(jj) < 0) & (ysum < 0)))
			q=0;
			for(k=1:cnum)
				for(t=1:cnum)
					r(k,t)=f(k)*f(t);
					q=q+r(k,t)*r(k,t);
					if(k==t)
						s=r(k,t);
					end
				end
				G = s/q;
				c(k) = c(k)+G*ysum*f(k);
			end
		end

%���������� ���������� �������� �������������
err1 = 0;
err2 = 0;
P = 0;

% j=-1;
% for i=1:L
%     f(i,1)=0;
%     f(i,2)=j;
% end
% j=1;
% for i=L+1:2*L
%     f(i,1)=0;
%     f(i,2)=j;
% end

for i=1:L
    f(i,1) = a6*class1(i,1)^2 + a5*class1(i,1)*class1(i,2) + a4*class1(i,2)^2 + a3*class1(i,1) + a2*class1(i,2) + a1;
    if(f(i,1)<0)
        err1=err1+1;    
    end

    f(i+L,1) = a6*class2(i,1)^2 + a5*class2(i,1)*class2(i,2) + a4*class2(i,2)^2 + a3*class2(i,1) + a2*class2(i,2) + a1;
    if(f(i+L,1)>0)
        err2=err2+1;    
    end
end

err1;
err2;
P = 1 - (err1+err2)/(2*L);




		if (P > Pmax)
			Pmax=P;
			err1max=err1;
			err2max=err2;
			iimax=ii;
			jjmax=jj;
			cmax=c;
		end

%����������� �������� � ������������ ���������
i=1;
for t=tmin:((tmax-tmin)/p):tmax,
    z(i) = t;
    X = z(i);
    Y1(i) = (-(a5 * X + a2)+((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
	Y2(i) = (-(a5 * X + a2)-((a5 * X + a2).^2 - 4 * a4 * (a6 * X.^2 + a3 * X + a1)).^0.5)/(2 * a4);
    i=i+1;
end

%figure(21);plot(class1(:,1),class1(:,2),'ro',class2(:,1),class2(:,2),'b+', z,Y1,'-k',  z,Y2,'-k');hold on;



end
end

err1max
err2max
Pmax
iimax;
jjmax;
cmax;

[res, out] = MSA(class1, class2, 2);
res

pr = 2;
cl1t = [];
cl2t = [];
len = 2;
out = '';
cl1 = class1;
cl2 = class2;

%[res, outf] = Am(cl1, cl2, pr);
%res = Amain(cl1, cl2, pr);
%outf = sprintf('�����������  =  %f\n������ 1 ����  =  %f\n������ 2 ����  =  %f\n', res(1), res(2), res(3));
% outf
%Aplot(class1, class2, 2);
