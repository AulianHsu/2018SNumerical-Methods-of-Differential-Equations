%%
clear all;close all;clc

n=100;
for i=3:n
a1=ones(i,1);
a2=-3*ones(i-1,1);
a3=2*ones(i-2,1);
a=diag(a1)+diag(a2,-1)+diag(a3,-2);
a(2,1)=0;
a_cond(1,i-2)=cond(a);

end
x=1:n-2;
loglog(x,a_cond)
title cond(A_1)�����A_1ά���Ĺ�ϵ

%%
clear all;close all;clc

n=100;
for i=3:n
a1=ones(i,1);
a2=-3*ones(i-1,1);
a3=2*ones(i-2,1);
a=diag(a1)+diag(a2,-1)+diag(a3,-2);
a(2,1)=0;
a(1,n)=-1;
a_cond(1,i-2)=cond(a);

end
x=1:n-2;
scatter(x,a_cond)
title cond(A_2)�����A_2ά���Ĺ�ϵ
%%
clear all;close all;clc

n=100;
for i=3:n
a1=ones(i,1);
a2=-2*ones(i-1,1);
a3=ones(i-2,1);
a=diag(a1)+diag(a2,-1)+diag(a3,-2);
a(2,1)=0;
a_cond(1,i-2)=cond(a);

end
x=1:n-2;
scatter(x,a_cond)
title cond(A_3)�����A_3ά���Ĺ�ϵ