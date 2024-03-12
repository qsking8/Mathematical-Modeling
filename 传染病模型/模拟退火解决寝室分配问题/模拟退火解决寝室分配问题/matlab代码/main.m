clear;clc
tic
rng('shuffle')  % 控制随机数的生成，否则每次打开matlab得到的结果都一样
% https://ww2.mathworks.cn/help/matlab/math/why-do-random-numbers-repeat-after-startup.html
% https://ww2.mathworks.cn/help/matlab/ref/rng.html
n = 40;  % 有多少名同学
mydata = csvread('C:\Users\sxjmqf\Desktop\mydata.csv');

%% 参数初始化
T0 = 1000;   % 初始温度
T = T0; % 迭代中温度会发生改变，第一次迭代时温度就是T0
maxgen = 500;  % 最大迭代次数
Lk = 500;  % 每个温度下的迭代次数
alpfa = 0.95;  % 温度衰减系数

%%  随机生成一个初始解
path0 = randperm(n);
result0 = calculate_ans(path0,mydata);  % 计算这一组解对应的标准差

%% 定义一些保存中间过程的量，方便输出结果和画图
min_result = result0;    
RESULT = zeros(maxgen,1); % 记录每一次外层循环结束后找到的min_result (方便画图）

%% 模拟退火过程
for iter = 1 : maxgen  % 外循环, 我这里采用的是指定最大迭代次数
    for i = 1 : Lk  %  内循环，在每个温度下开始迭代
        path1 = gen_new_path(path0);  
        result1 = calculate_ans(path1,mydata); 
        if result1 < result0    
            path0 = path1; 
            result0 = result1; 
        else
            p = exp(-(result1 - result0)/T); % 根据Metropolis准则计算一个概率
            if rand(1) < p   % 生成一个随机数和这个概率比较，如果该随机数小于这个概率
                path0 = path1;  
                result0 = result1; 
            end
        end
        % 判断是否要更新找到的最佳的解
        if result0 < min_result  % 如果当前解更好，则对其进行更新
            min_result = result0;  
            best_path = path0;  
        end
    end
    RESULT(iter) = min_result; % 保存本轮外循环结束后找到的最小的结果
    T = alpfa*T;   % 温度下降       
end


disp('最佳的方案是：'); disp(reshape(best_path,4,n/4))
disp('此时最优值是：'); disp(min_result)


%% 画出每次迭代后找到的图形
figure
plot(1:maxgen,RESULT,'b-');
xlabel('迭代次数');


[~,tmp] = calculate_ans(best_path,mydata)  % 前面的~表示不需要第一个返回结果
toc

% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭
% % 视频中提到的附件可在售后群（购买后收到的那个无忧自动发货的短信中有加入方式）的群文件中下载。包括讲义、代码、我视频中推荐的资料等。
% % 关注我的微信公众号《数学建模学习交流》，后台发送“软件”两个字，可获得常见的建模软件下载方法；发送“数据”两个字，可获得建模数据的获取方法；发送“画图”两个字，可获得数学建模中常见的画图方法。另外，也可以看看公众号的历史文章，里面发布的都是对大家有帮助的技巧。
% % 购买更多优质精选的数学建模资料，可关注我的微信公众号《数学建模学习交流》，在后台发送“买”这个字即可进入店铺(我的微店地址：https://weidian.com/?userid=1372657210)进行购买。
% % 视频价格不贵，但价值很高。单人购买观看只需要58元，三人购买人均仅需46元，视频本身也是下载到本地观看的，所以请大家不要侵犯知识产权，对视频或者资料进行二次销售。
% % 如何修改代码避免查重的方法：https://www.bilibili.com/video/av59423231（必看）
