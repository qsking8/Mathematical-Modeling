%% 模拟退火解决书店买书问题  % 466
tic
rng('shuffle')  % 控制随机数的生成，否则每次打开matlab得到的结果都一样

load book_data  % 这个文件一定要在当前文件夹下面
% 这个数据文件里面保存了两个矩阵：M是每本书在每家店的价格; freight表示每家店的运费
[s, b] = size(M);  % s是书店的数量，b是要购买的书的数量

%% 参数初始化
T0 = 1000;   % 初始温度
T = T0; % 迭代中温度会发生改变，第一次迭代时温度就是T0
maxgen = 500;  % 最大迭代次数
Lk = 200;  % 每个温度下的迭代次数
alfa = 0.95;  % 温度衰减系数

%%  随机生成一个初始解
way0 = randi([1, s],1,b); % 在1-s这些整数中随机抽取一个1*b的向量，表示这b本书分别在哪家书店购买
money0 = calculate_money(way0,freight,M,b); % 调用我们自己写的calculate_money函数计算这个方案的花费

%% 定义一些保存中间过程的量，方便输出结果和画图
min_money = money0;     % 初始化找到的最佳的解对应的花费为money0
MONEY = zeros(maxgen,1); % 记录每一次外层循环结束后找到的min_money (方便画图）

%% 模拟退火过程
for iter = 1 : maxgen  % 外循环, 我这里采用的是指定最大迭代次数
    for i = 1 : Lk  %  内循环，在每个温度下开始迭代
        way1 = gen_new_way(way0,s,b);  % 调用我们自己写的gen_new_way函数生成新的方案
        money1 = calculate_money(way1,freight,M,b); % 计算新方案的花费
        if money1 < money0    % 如果新方案的花费小于当前方案的花费
            way0 = way1; % 更新当前方案为新方案
            money0 = money1;
        else
            p = exp(-(money1 - money0)/T); % 根据Metropolis准则计算一个概率
            if rand(1) < p   % 生成一个随机数和这个概率比较，如果该随机数小于这个概率
                way0 = way1;
                money0 = money1;
            end
        end
        % 判断是否要更新找到的最佳的解
        if money0 < min_money  % 如果当前解更好，则对其进行更新
            min_money = money0;  % 更新最小的花费
            best_way = way0;  % 更新找到的最佳方案
        end
    end
    MONEY(iter) = min_money; % 保存本轮外循环结束后找到的最小花费
    T = alfa*T;   % 温度下降
end

disp('最佳的方案是：'); disp(mat2str(best_way))
disp('此时最优值是：'); disp(min_money)

%% 画出每次迭代后找到的最佳方案的图形
figure
plot(1:maxgen,MONEY,'b-');
xlabel('迭代次数');
ylabel('最小花费');
toc

% % 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
% % 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭
% % 视频中提到的附件可在售后群（购买后收到的那个无忧自动发货的短信中有加入方式）的群文件中下载。包括讲义、代码、我视频中推荐的资料等。
% % 关注我的微信公众号《数学建模学习交流》，后台发送“软件”两个字，可获得常见的建模软件下载方法；发送“数据”两个字，可获得建模数据的获取方法；发送“画图”两个字，可获得数学建模中常见的画图方法。另外，也可以看看公众号的历史文章，里面发布的都是对大家有帮助的技巧。
% % 购买更多优质精选的数学建模资料，可关注我的微信公众号《数学建模学习交流》，在后台发送“买”这个字即可进入店铺(我的微店地址：https://weidian.com/?userid=1372657210)进行购买。
% % 视频价格不贵，但价值很高。单人购买观看只需要58元，三人购买人均仅需46元，视频本身也是下载到本地观看的，所以请大家不要侵犯知识产权，对视频或者资料进行二次销售。
% % 如何修改代码避免查重的方法：https://www.bilibili.com/video/av59423231（必看）