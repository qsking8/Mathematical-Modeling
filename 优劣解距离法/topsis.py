'''
代码展示一般TOPSIS模型的计算过程（计算得分时不计权重）
'''
import pandas as pd
import numpy as np
import math
from scipy.spatial import distance

if __name__ == '__main__':
    data = pd.read_csv('river.csv')
    matrix = data.values
    matrix = matrix[:,1:]
#先对各列指标进行正向化处理
#指标一为极大型，无需正向化处理
#指标二为中间型，越接近7越好
    column = matrix[:,1]
    column = column - 7
    result = np.max(np.abs(column))
    column = np.abs(column) / result
    column = column * -1
    column = column + 1
    matrix[:, 1] = column
#指标三为极小型，越小越好
    column = matrix[:,2]
    res = np.max(column)
    column = column * -1
    column = column + res
    matrix[:, 2] = column
#指标四为区间型，介于10-20之间最佳
    column_index = 3
    M = 1e-9
    a = 10
    b = 20
    for row in matrix:
        element = row[column_index]
        if element < a:
            element = a - element
        elif element > b:
            element = element - b
        else:
            element = 0
        row[column_index] = element
        if element > M:
            M = element
    column = matrix[:,3]
    column = column * -1
    column = column / M
    column = column + 1
    matrix[:,3] = column
#再对矩阵进行标准化处理
    col_num = len(matrix[0])
    sqsum = 0
    for index in range(0,col_num):
        sqsum = 0
        for row in matrix:
            sqsum += row[index]*row[index]
        sqsum = math.sqrt(sqsum)
        column = matrix[:,index]
        column = column / sqsum
        matrix[:, index] = column
#最后计算得分并归一化，不计入权重
    dis_max = np.amax(matrix, axis=0)
    dis_min = np.amin(matrix, axis=0)
    grade = []
    row_num = matrix.shape[0]
    for index in range(0,row_num):
        gra_max = distance.euclidean(matrix[index],dis_max)
        gra_min = distance.euclidean(matrix[index],dis_min)
        mark = gra_min / (gra_max+gra_min)
        grade.append(mark)
    #得分归一化
    print(grade)
    total = np.sum(grade,axis=0)
    grade = grade / total
    print(grade)



