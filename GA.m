function [zbest, y] = GA()
%%
%参数初始化
popsize = 1000;                             %种群规模
lenchrom = 3;                               %基因中染色体个数
maxgen = 5000;                              %进化次数

pc = 0.7;                                   %设置交叉概率，可以设置为变化的
pm = 0.3;                                   %设置变异概率，同理也可以设置为变化的
%%
%种群
bound = [-1 1;-1 1;-1 1];
%变量范围
%%
%产生初始粒子和适应度
GApop = zeros(popsize,lenchrom);
fitness = zeros(popsize,1);
for n = 1:popsize
    %随机产生一个种群
    GApop(n,:) = Code(lenchrom,bound);      %随机产生个体
    %计算适应度
    fitness(n) = Fun(GApop(n,:));
end
%找最好的染色体
[bestfitness, bestindex] = min(fitness);
zbest = GApop(bestindex,:);                 %全局最佳
fitnesszbest = bestfitness;                 %全局最佳适应度值
y = zeros(1,maxgen);
%%
%迭代寻优
for n = 1:maxgen
    %种群更新 GA选择更新
    GApop = Select(GApop, fitness, popsize);
    %交叉操作
    GApop = Cross(pc,lenchrom,GApop,length(GApop),bound);
    %变异操作
    GApop = Mutation(pm,lenchrom,GApop,popsize,[n,maxgen],bound);
    for m = 1:popsize
        fitness(m) = Fun(GApop(m,:));
        if fitness(m) < fitnesszbest
            zbest = GApop(m,:);
            fitnesszbest = fitness(m);
        end
    end
    y(n) = fitnesszbest;
end
y = y(end);
end