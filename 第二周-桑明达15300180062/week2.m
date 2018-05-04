%% week2.1 P24 2
clear all;close all;clc
% G=@(x) exp(-x);
% F=@(x) x-exp(-x);
% F1=@(x) 1+exp(-x);  %Fһ�׵���
% �������ȱȽ� 

% 1.���������
n=24; %��������

Gx=0;
G=@(x) exp(-x);

for i=2:n
    Gx(i,1)=G(Gx(i-1,1));
end

% 2.Newton-Paphson����
Fx=0;
F=@(x) x-exp(-x);
F1=@(x) 1+exp(-x);  %Fһ�׵���

for i=2:n
    Fx(i,1)=Fx(i-1,1)-F(Fx(i-1,1))./F1(Fx(i-1,1));
end

% ��ͼ
x=1:n;
subplot(1,2,1)
scatter(x,Gx,'g');
hold on;
scatter(x,Fx,'*r');
title �������ȱȽ�;
legend('���������','Newton-Paphson����');
subplot(1,2,2)
semilogy(x,abs(Fx-Gx),'b');
title �������ȱȽ�;
legend('���');

%% week2 P41 6 �Ⱦ�ڵ��ֵ��ʽ��ʾRunge����
clear all;close all;clc
a=-1;
b=1;
pointsnumber=300;
xx=linspace(a,b,pointsnumber);
yy=1./(1+25.*xx.^2);
plot(xx,yy,'color',[0 0 0]);
%legend('1/(1+25*x^2)');
hold on

N=[5 9 13];
for n=N
    x=linspace(a,b,n);
    y=1./(1+25.*x.^2);
    xxn=linspace(a,b,pointsnumber);
    [yyn,coef]=newton_eval(xxn,x,y);
    scatter(xxn,yyn);
    hold on
end
str='legend(''1/(1+25*x^2)''';
for n=N
    str=strcat(str,',','''n=',int2str(n),'''');
end
str=strcat(str,');');
eval(str);

axis([-1 1 -1 1])
xlabel('-1 \leq x \leq 1')
ylabel('1/(1+25*x^2)')
title('Plot of 1/(1+25*x^2)')
%linespec('','.-','-','.');
%legend('1/(1+25*x^2)','n=5','n=9','n=13')
hold off


%% week2 P41 6 Chebyshev��ֵ��ʽ��ʾRunge����
clear all;close all;clc
a=-1;
b=1;
pointsnumber=100;
xx=linspace(a,b,pointsnumber);
yy=1./(1+25.*xx.^2);
plot(xx,yy,'color',[0 0 0]);
%legend('1/(1+25*x^2)');
hold on

N=[5 9 13];
for n=N
    x=0:n;
    x=-cos(pi.*x./n);
    y=1./(1+25.*x.^2);
    xxn=linspace(a,b,pointsnumber);
    [yyn,coef]=newton_eval(xxn,x,y);
    scatter(xxn,yyn);
    hold on
end
str='legend(''1/(1+25*x^2)''';
for n=N
    str=strcat(str,',','''n=',int2str(n),'''');
end
str=strcat(str,');');
eval(str);

axis([-1 1 -1 1])
xlabel('-1 \leq x \leq 1')
ylabel('1/(1+25*x^2)')
title('Plot of 1/(1+25*x^2)')
%linespec('','.-','-','.');
%legend('1/(1+25*x^2)','n=5','n=9','n=13')
hold off

%%
function [yy,coef]=newton_eval(xx,x,y)

[~,n]=size(x);
for j=1:n-1
    for i=1:n-j
        y(n-i+1)=(y(n-i+1)-y(n-i))/(x(n-i+1)-x(n-i+1-j));
    end
end
coef=y;
yy=zeros(size(xx));
yy=yy+y(1);
xxx=ones(size(xx));
for k=2:n
    xxx=xxx.*(xx-x(k-1));
    yy=yy+y(k).*xxx;
end
end











