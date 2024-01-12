'''
 某单位对员工的年终综合评定
 U = {政治表现u1，工作能力u2，工作态度u3，工作成绩u4}
 V = {优秀v1,良好v2，一般v3，较差v4，差v5}
 A = {0.25,0.2,0.25,0.3}
 每个评价因素对应的评分见excel（模糊统计法）
'''
import pandas as pd
import numpy as np

A = np.array([[0.25,0.2,0.25,0.3]])

if __name__ == '__main__':
     data = pd.read_csv('evaluation.csv')
     matrix = data.values
     matrix = matrix[:,1:] #读取文件并取出数据部分
     print(matrix)

     row_sums = matrix.sum(axis=1)
     midresult = (matrix.T / row_sums).T
     print(midresult)    #模糊统计法求得隶属度

     result = np.dot(A,midresult)
     print(result)     #计算模糊综合评价矩阵

     max_indices = np.argmax(result, axis=1)
     print("对应的类别为：", max_indices+1) #得到评价结果






