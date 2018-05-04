%%
close all;clear all;clc

%%   ����1��
close all;clear all;clc

n=4;%cotes��ʽ
num=1000;%�ֶ���
a=0;
b=1;
x=linspace(a,b,n*num+1)';
y=exp(x);
In=newton_cotes_new_n(a,b,y,n);

%%  Romberg�㷨
close all;clear all;clc

a=0;
b=1;
fun = @(x) exp(x);%��������
n=1;%cotes��ʽ
In=0;
for n=1:5
    l=1*(2^(n-1))+1;
    x=linspace(a,b,l)';
    y=reshape(fun(x),[l,1]);
    In(n,1)=newton_cotes_new_n(a,b,y,1);
    
    for i=2:n
        In(n,i)=(4^(i-1)*In(n,i-1)-In(n-1,i-1))./(4^(i-1)-1);
    end
end
vpa(In,11)

%%  Romberg�㷨2
close all;clear all;clc

a=0;
b=1;
rows=10;%��Ҫ�Ƶ�����
fun = @(x) exp(x);%��������

In(1,1)=(b-a)./2.*(fun(a)+fun(b));
for n=2:rows
    l=2^(n-2);
    x=linspace(a+(b-a)./(2*l),b-(b-a)./(2*l),l)';
    y=fun(x);
    In(n,1)=0.5*(In(n-1,1)+(b-a)./l.*sum(y));
    
    for i=2:n
        In(n,i)=(4^(i-1)*In(n,i-1)-In(n-1,i-1))./(4^(i-1)-1);
    end
end
vpa(In,11)

%%  Romberg�㷨-�Զ���ֹ
close all;clear all;clc

a=0;
b=1;
fun = @(x) exp(x);%��������
n=1;%cotes��ʽ
In=0;
doa0=10^-6;

l=2;
x=linspace(a,b,l)';
y=reshape(fun(x),[l,1]);
In(1,1)=newton_cotes_new_n(a,b,y,1);

ysum=sum(y).*(b-a)./(l-1);
I=In(1,1);
for n=2:5
    l=1*(2^(n-1))+1;
    x=linspace(a,b,l)';
    y=reshape(fun(x),[l,1]);
    In(n,1)=newton_cotes_new_n(a,b,y,1);
    ysum=sum(y).*(b-a)./(l-1);
    doa=abs((In(n,1)-I)./ysum);
    if doa<doa0
        break
    end
    I=In(n,1);
    for i=2:n
        In(n,i)=(4^(i-1)*In(n,i-1)-In(n-1,i-1))./(4^(i-1)-1);
        
        doa=abs((In(n,i)-I)./ysum);
        if doa<-doa0
            break
        end
        I=In(n,i);
    end
    if doa<doa0
        break
    end
end
if doa>=doa0
    fprintf('���㷶Χ��δ�ﵽҪ��ľ���\n');
end
fprintf('�������ս����%20.20f\n',I);
fprintf('����������������%20.20f\n',doa);

%%  �۲����Ľ��� exp(x)
close all;clear all;clc

n1=1;%���ι�ʽ
n2=2;%simpson��ʽ
n3=4;%cotes��ʽ
num_int=50;%�ֶ���
a=0;
b=1;
fun=@(x) exp(x);
I=exp(1)-exp(0);
for num=1:num_int
    x1=linspace(a,b,n1*num+1)';
    y1=fun(x1);
    In1(num,1)=newton_cotes_new_n(a,b,y1,n1);
    h1(num,1)=(b-a)./num;
    
    x2=linspace(a,b,n2*num+1)';
    y2=fun(x2);
    In2(num,1)=newton_cotes_new_n(a,b,y2,n2);
    h2(num,1)=(b-a)./num;
    
    x3=linspace(a,b,n3*num+1)';
    y3=fun(x3);
    In3(num,1)=newton_cotes_new_n(a,b,y3,n3);
    h3(num,1)=(b-a)./num;
end
X1 = [ones(size(log(h1))) log(h1)];
b1 = regress(log(abs(In1-I)),X1);
x1=linspace(min(log(h1)),max(log(h1)),2);
y1=b1(1)+b1(2).*x1;

X2 = [ones(size(log(h2))) log(h2)];
b2 = regress(log(abs(In2-I)),X2);
x2=linspace(min(log(h2)),max(log(h2)),2);
y2=b2(1)+b2(2).*x2;

X3 = [ones(size(log(h3))) log(h3)];
b3 = regress(log(abs(In3-I)),X3);
x3=linspace(min(log(h3)),max(log(h3)),2);
y3=b3(1)+b3(2).*x3;

plot(x1,y1,'r',x2,y2,'g',x3,y3,'b')
hold on
title('�۲�exp(x)���������С���䳤��h�Ĺ�ϵ')
xlabel('log(h)')
ylabel('log(abs(In-I))')
t1=sprintf('���ι�ʽ��б����%2.2s',b1(2));
t2=sprintf('simpson��ʽ��б����%2.2s',b2(2));
t3=sprintf('cotes��ʽ��б����%2.2s',b3(2));
scatter(log(h1),log(abs(In1-I)),'r');
hold on
scatter(log(h2),log(abs(In2-I)),'g');
hold on
scatter(log(h3),log(abs(In3-I)),'b');
legend(t1,t2,t3);


%%  �۲����Ľ��� sin(x)
close all;clear all;clc

n1=1;%���ι�ʽ
n2=2;%simpson��ʽ
n3=4;%cotes��ʽ
num_int=100;%�ֶ���
a=0;
b=pi;
fun=@(x) sin(x);
I=2;
for num=1:num_int
    x1=linspace(a,b,n1*num+1)';
    y1=fun(x1);
    In1(num,1)=newton_cotes_new_n(a,b,y1,n1);
    h1(num,1)=(b-a)./num;
    
    x2=linspace(a,b,n2*num+1)';
    y2=fun(x2);
    In2(num,1)=newton_cotes_new_n(a,b,y2,n2);
    h2(num,1)=(b-a)./num;
    
    x3=linspace(a,b,n3*num+1)';
    y3=fun(x3);
    In3(num,1)=newton_cotes_new_n(a,b,y3,n3);
    h3(num,1)=(b-a)./num;
end
X1 = [ones(size(log(h1))) log(h1)];
b1 = regress(log(abs(In1-I)),X1);
x1=linspace(min(log(h1)),max(log(h1)),2);
y1=b1(1)+b1(2).*x1;

X2 = [ones(size(log(h2))) log(h2)];
b2 = regress(log(abs(In2-I)),X2);
x2=linspace(min(log(h2)),max(log(h2)),2);
y2=b2(1)+b2(2).*x2;

X3 = [ones(size(log(h3))) log(h3)];
b3 = regress(log(abs(In3-I)),X3);
x3=linspace(min(log(h3)),max(log(h3)),2);
y3=b3(1)+b3(2).*x3;

plot(x1,y1,'r',x2,y2,'g',x3,y3,'b')
hold on
title('�۲�sin(x)���������С���䳤��h�Ĺ�ϵ')
xlabel('log(h)')
ylabel('log(abs(In-I))')
t1=sprintf('���ι�ʽ��б����%2.2s',b1(2));
t2=sprintf('simpson��ʽ��б����%2.2s',b2(2));
t3=sprintf('cotes��ʽ��б����%2.2s',b3(2));
scatter(log(h1),log(abs(In1-I)),'r');
hold on
scatter(log(h2),log(abs(In2-I)),'g');
hold on
scatter(log(h3),log(abs(In3-I)),'b');
legend(t1,t2,t3);

%%  �۲����Ľ��� exp(x^2)
close all;clear all;clc

n1=1;%���ι�ʽ
n2=2;%simpson��ʽ
n3=4;%cotes��ʽ
num_int=20;%�ֶ���
a=0;
b=pi;
fun=@(x) exp(x.^2);
I=2;
for num=1:num_int
    x1=linspace(a,b,n1*num+1)';
    y1=fun(x1);
    In1(num,1)=newton_cotes_new_n(a,b,y1,n1);
    h1(num,1)=(b-a)./num;
    
    x2=linspace(a,b,n2*num+1)';
    y2=fun(x2);
    In2(num,1)=newton_cotes_new_n(a,b,y2,n2);
    h2(num,1)=(b-a)./num;
    
    x3=linspace(a,b,n3*num+1)';
    y3=fun(x3);
    In3(num,1)=newton_cotes_new_n(a,b,y3,n3);
    h3(num,1)=(b-a)./num;
end
X1 = [ones(size(log(h1))) log(h1)];
b1 = regress(log(abs(In1-I)),X1);
x1=linspace(min(log(h1)),max(log(h1)),2);
y1=b1(1)+b1(2).*x1;

X2 = [ones(size(log(h2))) log(h2)];
b2 = regress(log(abs(In2-I)),X2);
x2=linspace(min(log(h2)),max(log(h2)),2);
y2=b2(1)+b2(2).*x2;

X3 = [ones(size(log(h3))) log(h3)];
b3 = regress(log(abs(In3-I)),X3);
x3=linspace(min(log(h3)),max(log(h3)),2);
y3=b3(1)+b3(2).*x3;

plot(x1,y1,'r',x2,y2,'g',x3,y3,'b')
hold on
title('�۲�exp(x^2)���������С���䳤��h�Ĺ�ϵ')
xlabel('log(h)')
ylabel('log(abs(In-I))')
t1=sprintf('���ι�ʽ��б����%2.2s',b1(2));
t2=sprintf('simpson��ʽ��б����%2.2s',b2(2));
t3=sprintf('cotes��ʽ��б����%2.2s',b3(2));
scatter(log(h1),log(abs(In1-I)),'r');
hold on
scatter(log(h2),log(abs(In2-I)),'g');
hold on
scatter(log(h3),log(abs(In3-I)),'b');
legend(t1,t2,t3);

%%
function In=newton_cotes_new_n(a,b,y,n)
% ����newton-cotes��ʽ
% a,b�����䷶Χ��
% y����������
% y�Ǻ���ֵ��
% n��cotes��ʽ��������
% ����
% n=4;
% a=0;
% b=1;
% x=linspace(a,b,1000*n+1)';
% y=exp(x);

%����cotes��ʽϵ��
c1=1:n;
c1=c1.^(c1');
c2=(n.^(1:n)./(2:(n+1)))';
%�ɰ�matlabʹ�����д���
% for i=1:n
%     for j=1:n
%         c1(i,j)=j^i;
%     end
% end
% c2=zeros(n,1);
% for i=1:n
%     c2(i,1)=n.^(i)./(i+1);
% end
c_nk=(c1)\c2;
c_nk=[c_nk(n);c_nk];

%�ֶμ���
if mod(size(y,1)-1,n)==0
    num=(size(y,1)-1)./n;%�ֶε�����
    In=0;
    for i=1:num %��i��
        yy=y((i-1)*n+1);
        for j=0:n-1
            yy=[yy;y((i-1)*n+2+j)];
        end
        In=In+(b-a)./num.*((c_nk')*yy);
    end
else
    fprintf('����ĺ���ֵ��������\n');
    In=NaN;
end

end
