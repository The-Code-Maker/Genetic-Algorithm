function [ flag ] = Test( lenchrom, bound, ret )
%lenchrom   input:染色体长度
%bound      input:变量的取值范围
%code       input:染色体的编码值
%flag      output:可行性标志变量
%初始变量
flag = 1;
%1:可行
%0:不可行
for n = 1:lenchrom
    if ret(n) < bound(n,1) || ret(n) > bound(n,2)
        flag = 0;
        break
    end
end
end

