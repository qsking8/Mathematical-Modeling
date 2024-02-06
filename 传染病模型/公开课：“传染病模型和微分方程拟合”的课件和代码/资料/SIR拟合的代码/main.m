clear;clc
load data30.mat
global true_s true_i true_r
true_s = p30(:,1);
true_i = p30(:,2);
true_r = p30(:,3);
plot(1:30,true_s,'r-',1:30,true_i,'b-',1:30,true_r,'k-')
legend('S','I','R')
hold on


lb = [0.1 0.03];  ub = [0.6 0.2];  

% Á£×ÓÈº
% options = optimoptions('particleswarm','Display','iter','SwarmSize',200,'PlotFcn','pswplotbestf');
% [x, fval] = particleswarm(@sir_Obj_fun,2,lb,ub,options) 

% fmincomº¯Êý
x0 = [0.1 0.1]
[x, fval] = fmincon(@sir_Obj_fun,x0,[],[],[],[],lb,ub)  

T = 100;
beta = 0.3;
gamma = 0.1;
[~,p]=ode45(@(t,p) sir_fun(t,p,beta,gamma), [1:1:T],[true_s(1) true_i(1) true_r(1)]); 
plot(1:T,p(:,1),'r*',1:T,p(:,2),'b*',1:T,p(:,3),'k*')


