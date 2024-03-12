clear;clc
load mydata.mat  % �������ݣ������У��ֱ���S,I,R��������
global true_s true_i true_r  n  % ����ȫ�ֱ���
n = size(mydata,1);  % һ���ж���������
true_s = mydata(:,1);
true_i = mydata(:,2);
true_r = mydata(:,3);
figure(1)
% plot(1:n,true_s,'r-',1:n,true_i,'b-',1:n,true_r,'g-')  % S������̫����
% legend('S','I','R')
plot(1:n,true_i,'b-',1:n,true_r,'g-') % ��������I��R������
legend('I','R')

% ����Ⱥ�㷨�����
lb = [0 0]; 
ub = [1 1];  
options = optimoptions('particleswarm','Display','iter','SwarmSize',100,'PlotFcn','pswplotbestf');
[h, fval] = particleswarm(@Obj_fun,2,lb,ub,options)  % h����Ҫ�Ż��Ĳ�����fval��Ŀ�꺯��ֵ
% options = optimoptions('particleswarm','SwarmSize',100,'FunctionTolerance',1e-12,'MaxStallIterations',100,'MaxIterations',100000);
% [h, fval] = particleswarm(@Obj_fun,2,lb,ub,options)  % h����Ҫ�Ż��Ĳ�����fval��Ŀ�꺯��ֵ

beta = h(1);  % �׸�Ⱦ�����Ѹ�Ⱦ�߽Ӵ��ұ���Ⱦ��ǿ��
gamma = h(2);  % ������
[t,p]=ode45(@(t,x) SIR_fun(t,x,beta,gamma), [1:n],[true_s(1) true_i(1) true_r(1)]);   
p = round(p);  % ��p������������(����Ϊ����)
sse = sum((true_s - p(:,1)).^2  + (true_i -  p(:,2)).^2  + (true_r - p(:,3)).^2)  % ����в�ƽ����



figure(3)  % ��ʵ����������ϵ������ŵ�һ�𿴿�
plot(1:n,true_i,'b-',1:n,true_r,'g-') 
hold on
plot(1:n,p(:,2),'b--',1:n,p(:,3),'g--') 
legend('I','R','��ϵ�I','��ϵ�R')

% Ԥ��δ��������
N = 27; % ����N��
[t,p]=ode45(@(t,x) SIR_fun(t,x,beta,gamma), [1:N],[true_s(1) true_i(1) true_r(1)]);   
p = round(p);  % ��p������������(����Ϊ����)
figure(4)
plot(1:n,true_i,'b-',1:n,true_r,'g-') 
hold on
plot(1:N,p(:,2),'b--',1:N,p(:,3),'g--') 
legend('I','R','��ϵ�I','��ϵ�R')





% % ע�⣺�����ļ������ο���һ����Ҫֱ�������Լ�����ģ������
% % �����������ĵĲ���Ҫ��ǳ��ϸ񣬴�����ͬҲ������Ϯ
% % ��Ƶ���ᵽ�ĸ��������ۺ�Ⱥ��������յ����Ǹ������Զ������Ķ������м��뷽ʽ����Ⱥ�ļ������ء��������塢���롢����Ƶ���Ƽ������ϵȡ�
% % ��ע�ҵ�΢�Ź��ںš���ѧ��ģѧϰ����������̨���͡�����������֣��ɻ�ó����Ľ�ģ������ط��������͡����ݡ������֣��ɻ�ý�ģ���ݵĻ�ȡ���������͡���ͼ�������֣��ɻ����ѧ��ģ�г����Ļ�ͼ���������⣬Ҳ���Կ������ںŵ���ʷ���£����淢���Ķ��ǶԴ���а����ļ��ɡ�
% % ����������ʾ�ѡ����ѧ��ģ���ϣ��ɹ�ע�ҵ�΢�Ź��ںš���ѧ��ģѧϰ���������ں�̨���͡�������ּ��ɽ������(�ҵ�΢���ַ��https://weidian.com/?userid=1372657210)���й���
% % ��Ƶ�۸񲻹󣬵���ֵ�ܸߡ����˹���ۿ�ֻ��Ҫ58Ԫ�����˹����˾�����46Ԫ����Ƶ����Ҳ�����ص����عۿ��ģ��������Ҳ�Ҫ�ַ�֪ʶ��Ȩ������Ƶ�������Ͻ��ж������ۡ�
% % ����޸Ĵ��������صķ�����https://www.bilibili.com/video/av59423231���ؿ���
