clc;
clear;
%% 基础参数
popSize = 200;  %种群内个体数目
N_chrom = 1; %染色体节点数，也就是每个个体有多少条染色体，其实说白了就是看适应函数里有几个自变量。
iter = 1000; %迭代次数，也就是一共有多少代
C = [3200 2800 2800 2900 0;3200 3400 3900 2880 0;20500 26000 31000 0 0;3200 3600 4100 2680 0;870 1500 1800 0 0;1850 1900 2070 1900 1650];     % 成本
W = [0.141; 0.195; 0.139; 0.188; 0.151; 0.195];     % 权重
S = [1 0 0 0 0;1 1 0.556 0.0462 0;0.438 1 0.75 0 0;1 1 0.938 0.36 0;0.319 1 0.75 0 0;1 1 0.969 1 0.438];     % 模块隶属度
g = [1 1 0 0 0;0 0 1 0 0;0 0 0 1 0;0 1 0 0 1;0 0 0 1 0;1 0 1 0 0];
mut = 0.2;  %突变概率
acr = 0.2; %交叉概率
N = 6;                      % 行数
M = 5;                      % 列数
best = 1;
chrom_range = [-10 -10;10 10];%每个节点的值的区间
fitness_ave = zeros(1, iter);%存放每一代的平均适应度
fitness_best = zeros(1, iter);%存放每一代的最优适应度
% 初始化，这只是用于生成第一代个体，并计算其适应度函数
chrom = Initialize(popSize, N_chrom, chrom_range); %初始化染色体
fitness = CalFitness(chrom, popSize, N_chrom); %计算适应度
chrom_best = FindBest(chrom, fitness, N_chrom); %寻找最优染色体
fitness_best(1) = chrom_best(end); %将当前最优存入矩阵当中
fitness_ave(1) = CalAveFitness(fitness); %将当前平均适应度存入矩阵当中
%% 用于生成以下其余各代，一共迭代多少步就一共有多少代
for t = 2:iter
    chrom = MutChrom(chrom, mut, popSize, N_chrom, chrom_range, t, iter); %变异
    chrom = AcrChrom(chrom, acr, popSize, N_chrom); %交叉
    fitness = CalFitness(chrom, popSize, N_chrom); %计算适应度
    chrom_best_temp = FindBest(chrom, fitness, N_chrom); %寻找最优染色体
    if chrom_best_temp(end)>chrom_best(end) %替换掉当前储存的最优
        chrom_best = chrom_best_temp;
    end
    %%替换掉最劣
    [chrom, fitness] = ReplaceWorse(chrom, chrom_best, fitness);
    fitness_best(t) = chrom_best(end); %将当前最优存入矩阵当中
    fitness_ave(t) = CalAveFitness(fitness); %将当前平均适应度存入矩阵当中
end
%% 作图
figure(1)
plot(1:iter, fitness_ave, 'r', 1:iter, fitness_best, 'b')
grid on
legend('平均适应度', '最优适应度')
suoe=PlotModel(chrom_best);
%% 输出结果
disp(['最优染色体为', num2str(chrom_best(1:end-1))])
disp(['最优适应度为', num2str(chrom_best(end))])

function chrom_new = Initialize(popSize, N_chrom, chrom_range)
    % 初始化染色体，随机生成popSize个个体，每个染色体有N_chrom个节点
    chrom_new = rand(popSize, N_chrom);
    
    % 将每一列乘上范围，确保染色体值在指定范围内
    for i = 1:N_chrom 
        chrom_new(:, i) = chrom_new(:, i) * (chrom_range(2, i) - chrom_range(1, i)) + chrom_range(1, i);
    end
end
%%Initialize这个函数生成一个具有随机值的初始染色体矩阵，每个染色体的值都在指定的范围内。
function fitness = CalFitness(pop, popSize, M, N, W, S, g, C)
    % 计算适应度的函数
    fitness = zeros(popSize, 1);

    % 循环生成1200组随机数，每行总和为1
    i = 0;
    while(i < 1200)
        i = i + 1;
        for j = 1:5
            n(i,j) = rand(1, 1) > 0.5; % 随机生成0或1
        end
        if sum(n(i,1:5)) ~= 1 % 保证每行总和为1
            i = i - 1;
        end 
    end
    pop = reshape(n',[],popSize)';

    % 计算每个个体的适应度
    for i = 1:popSize
        k = reshape(pop(i,:), M, N)'; % 将染色体reshape为矩阵
        cost_constraint = (1 + 0.5) * sum(C .* k, 'all'); % 计算成本约束

        % 使用给定公式计算适应度
        fitness(i) = 1000 * sum(W .* sum(S .* k .* g, 2), 'all') / sum(sum(C .* k .* g, 2), 'all') - cost_constraint;
    end
end
%% 这个函数首先生成了一个1200行5列的随机矩阵 pop，每行的总和为1。然后，使用这个 pop 矩阵计算每个个体的适应度。适应度的计算涉及对染色体的解码，并使用问题的特定公式进行计算。
function chrom_best = FindBest(chrom, fitness, N_chrom)
    % 寻找适应度最高的染色体
    chrom_best = zeros(1, N_chrom+1);
    [maxNum, maxCorr] = max(fitness);
    chrom_best(1:N_chrom) = chrom(maxCorr, :);
    chrom_best(end) = maxNum;
end
%% 这个函数用于在给定染色体矩阵和适应度矩阵的情况下，找到适应度最高的染色体。
%% 用于对每代共100个个体进行变异处理
function chrom_new = MutChrom(chrom, mut, popSize, N_chrom, chrom_range, t, iter)
    % 对每个个体进行变异处理
    for i = 1:popSize
        mut_rand = rand; % 随机生成一个数，代表基因突变的概率
        if mut_rand <= mut
            % 如果基因突变概率小于等于阈值，则进行基因突变处理
            row_to_mutate = randi(popSize); % 随机选择一行进行变异

            % 生成新的只有一个1的行
            new_row = zeros(1, N_chrom);
            new_row(randi(N_chrom)) = 1;

            % 将所选行替换为新的只有一个1的行
            chrom(row_to_mutate, :) = new_row;

            % 检验是否越界
            chrom(row_to_mutate, :) = IfOut(chrom(row_to_mutate, :), chrom_range(:, :));
        end
    end
    chrom_new = chrom;
end
%% 这个函数用于对每个个体进行变异处理。对于每个个体，根据给定的变异概率（mut），以及随机生成的数值，决定是否进行基因突变。
function c_new = IfOut(c, range)
    % 检验染色体值是否越界
    if c < range(1) || c > range(2)
        if abs(c - range(1)) < abs(c - range(2))
            c_new = range(1);
        else
            c_new = range(2);
        end
    else
        c_new = c;
    end
end
%% 这个函数用于检验染色体值是否越界，并进行相应的处理。
function chrom_new = AcrChrom(chrom, acr, N, N_chrom)
    % 对每个个体进行交叉处理
    for i = 1:N
        acr_rand = rand; % 随机生成一个数，代表个体是否进行交叉处理的概率
        if acr_rand < acr
            % 如果交叉概率小于阈值，则进行交叉处理
            acr_chrom = floor((N-1)*rand+1); % 随机选择要交叉的染色体

            % 生成新的只有一半元素为1的行
            new_row = zeros(1, N_chrom);
            new_row(randperm(N_chrom, round(N_chrom/2))) = 1; % 使用 round 以确保得到整数值

            % 交叉操作：将某一行的位置与另一行进行交叉
            chrom(acr_chrom, :) = new_row;
        end
    end
    chrom_new = chrom;
end

%% 这个函数用于对每个个体进行交叉处理。对于每个个体，根据给定的交叉概率（acr），以及随机生成的数值，决定是否进行交叉处理。
function [chrom_new, fitness_new] = ReplaceWorse(chrom, chrom_best, fitness)
    % 替换适应度较差的个体
    max_num = max(fitness);
    min_num = min(fitness);
    limit = (max_num - min_num) * 0.2 + min_num;

    replace_corr = fitness < limit;

    replace_num = sum(replace_corr);
    chrom(replace_corr, :) = ones(replace_num, 1) * chrom_best(1:end-1);
    fitness(replace_corr) = ones(replace_num, 1) * chrom_best(end);
    chrom_new = chrom;
    fitness_new = fitness;
end
%% 这个函数用于替换适应度较差的个体。根据设定的阈值（limit），将适应度低于阈值的个体替换为当前最优个体。
function fitness_ave = CalAveFitness(fitness)
    % 计算平均适应度
    [popSize, ~] = size(fitness);
    fitness_ave = sum(fitness) / popSize;
end
%% 这个函数用于计算给定适应度矩阵的平均适应度。
function y = PlotModel(chrom)
    % 绘制模型
    x = chrom(1);
    y = chrom(2);
    z = chrom(3);
    figure(2)
    scatter3(x, y, z, 'ko')
    hold on
    [X, Y] = meshgrid(-10:0.1:10);
    Z = sin(X) + cos(Y) + 0.1 * X + 0.1 * Y;
    mesh(X, Y, Z)
    y = 1;
end

%% 这个函数用于绘制模型。它接受一个染色体作为输入，并在三维坐标中绘制染色体的位置，同时绘制一个函数表面。在这个问题中，函数表面的形式是 sin(X) + cos(Y) + 0.1 * X + 0.1 * Y。
