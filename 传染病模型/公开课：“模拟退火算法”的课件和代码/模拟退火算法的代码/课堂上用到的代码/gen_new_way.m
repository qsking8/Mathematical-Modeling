function way1 = gen_new_way(way0, s, b)
% way0：原来的买书方案，是一个1*b的向量，每一个元素都位于1-s之间
        index =  randi([1, b],1) ;  % 看哪一本书要更换书店购买
        way1 = way0;  % 将原来的方案赋值给way1
        way1(index) = randi([1, s],1);  % 将way1中的第index本书换一个书店购买   
end
