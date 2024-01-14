'''
   已知某一天空气污染物的浓度为0.07mg/m³，该空气污染物的评价标准为：
   Ⅰ级：0.05 Ⅱ级：0.15 Ⅲ级：0.25 Ⅳ级：0.50
   确定空气污染物浓度对于每个级别的隶属度

   下面运用梯形分布对四种级别的隶属度进行计算
   Ⅰ级为偏小型 Ⅱ级和Ⅲ级为中间型 Ⅳ级为偏大型
'''
def cal_one(a):
    if a < 0.05:
        return 1
    elif a < 0.15:
        return round((0.15-a)/(0.15-0.05),1)
    else:
        return 0

def cal_two(a):
    if a<0.05:
        return 0
    elif a<0.15:
        return round((a-0.05)/(0.15-0.05),1)
    elif a<0.25:
        return round((0.25-a)/(0.25-0.15),1)
    else:
        return 0

def cal_three(a):
    if a<0.15:
        return 0
    elif a<0.25:
        return round((a-0.15)/(0.25-0.15),1)
    elif a<0.5:
        return round((0.5-a)/(0.5-0.25),1)
    else:
        return 0

def cal_four(a):
    if a<0.25:
        return 0
    elif a<0.5:
        return round((a-0.25)/(0.5-0.25),1)
    else:
        return 1

if __name__ == '__main__':
    a = 0.07
    print("对以上四种级别的隶属度分别为：")
    print(cal_one(a))
    print(cal_two(a))
    print(cal_three(a))
    print(cal_four(a))