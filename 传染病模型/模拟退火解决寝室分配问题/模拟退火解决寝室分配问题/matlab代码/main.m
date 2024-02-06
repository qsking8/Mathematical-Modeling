clear;clc
tic
rng('shuffle')  % ��������������ɣ�����ÿ�δ�matlab�õ��Ľ����һ��
% https://ww2.mathworks.cn/help/matlab/math/why-do-random-numbers-repeat-after-startup.html
% https://ww2.mathworks.cn/help/matlab/ref/rng.html
n = 40;  % �ж�����ͬѧ
mydata = csvread('C:\Users\sxjmqf\Desktop\mydata.csv');

%% ������ʼ��
T0 = 1000;   % ��ʼ�¶�
T = T0; % �������¶Ȼᷢ���ı䣬��һ�ε���ʱ�¶Ⱦ���T0
maxgen = 500;  % ����������
Lk = 500;  % ÿ���¶��µĵ�������
alpfa = 0.95;  % �¶�˥��ϵ��

%%  �������һ����ʼ��
path0 = randperm(n);
result0 = calculate_ans(path0,mydata);  % ������һ����Ӧ�ı�׼��

%% ����һЩ�����м���̵����������������ͻ�ͼ
min_result = result0;    
RESULT = zeros(maxgen,1); % ��¼ÿһ�����ѭ���������ҵ���min_result (���㻭ͼ��

%% ģ���˻����
for iter = 1 : maxgen  % ��ѭ��, ��������õ���ָ������������
    for i = 1 : Lk  %  ��ѭ������ÿ���¶��¿�ʼ����
        path1 = gen_new_path(path0);  
        result1 = calculate_ans(path1,mydata); 
        if result1 < result0    
            path0 = path1; 
            result0 = result1; 
        else
            p = exp(-(result1 - result0)/T); % ����Metropolis׼�����һ������
            if rand(1) < p   % ����һ���������������ʱȽϣ�����������С���������
                path0 = path1;  
                result0 = result1; 
            end
        end
        % �ж��Ƿ�Ҫ�����ҵ�����ѵĽ�
        if result0 < min_result  % �����ǰ����ã��������и���
            min_result = result0;  
            best_path = path0;  
        end
    end
    RESULT(iter) = min_result; % ���汾����ѭ���������ҵ�����С�Ľ��
    T = alpfa*T;   % �¶��½�       
end


disp('��ѵķ����ǣ�'); disp(reshape(best_path,4,n/4))
disp('��ʱ����ֵ�ǣ�'); disp(min_result)


%% ����ÿ�ε������ҵ���ͼ��
figure
plot(1:maxgen,RESULT,'b-');
xlabel('��������');


[~,tmp] = calculate_ans(best_path,mydata)  % ǰ���~��ʾ����Ҫ��һ�����ؽ��
toc

% % ע�⣺�����ļ������ο���һ����Ҫֱ�������Լ�����ģ������
% % �����������ĵĲ���Ҫ��ǳ��ϸ񣬴�����ͬҲ������Ϯ
% % ��Ƶ���ᵽ�ĸ��������ۺ�Ⱥ��������յ����Ǹ������Զ������Ķ������м��뷽ʽ����Ⱥ�ļ������ء��������塢���롢����Ƶ���Ƽ������ϵȡ�
% % ��ע�ҵ�΢�Ź��ںš���ѧ��ģѧϰ����������̨���͡�����������֣��ɻ�ó����Ľ�ģ������ط��������͡����ݡ������֣��ɻ�ý�ģ���ݵĻ�ȡ���������͡���ͼ�������֣��ɻ����ѧ��ģ�г����Ļ�ͼ���������⣬Ҳ���Կ������ںŵ���ʷ���£����淢���Ķ��ǶԴ���а����ļ��ɡ�
% % ����������ʾ�ѡ����ѧ��ģ���ϣ��ɹ�ע�ҵ�΢�Ź��ںš���ѧ��ģѧϰ���������ں�̨���͡�������ּ��ɽ������(�ҵ�΢���ַ��https://weidian.com/?userid=1372657210)���й���
% % ��Ƶ�۸񲻹󣬵���ֵ�ܸߡ����˹���ۿ�ֻ��Ҫ58Ԫ�����˹����˾�����46Ԫ����Ƶ����Ҳ�����ص����عۿ��ģ��������Ҳ�Ҫ�ַ�֪ʶ��Ȩ������Ƶ�������Ͻ��ж������ۡ�
% % ����޸Ĵ��������صķ�����https://www.bilibili.com/video/av59423231���ؿ���
