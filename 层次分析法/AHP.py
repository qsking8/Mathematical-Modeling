'''
   本代码用于层次分析法计算过程，包括矩阵一致性检验和权重（得分）求解
'''
import numpy as np

A = np.array([[1,1,4,1/3,3],[1,1,4,1/3,3],[1/4,1/4,1,1/3,1/2],[3,3,3,1,3],[1/3,1/3,2,1/3,1]])
RI = np.array([[0,0,0.52,0.89,1.12,1.26,1.36,1.41,1.46,1.49,1.52,1.54,1.56,1.58,1.59]])

if __name__ == '__main__':
# 首先进行判断矩阵一致性检验
     eigenvalues, _ = np.linalg.eig(A)
     #找到最大特征值
     max_eigenvalue = np.max(eigenvalues)
     eigen = np.real(max_eigenvalue)
     #求解行数与列数
     num_rows, num_cols = A.shape
     CI = (eigen - num_rows) / (num_rows - 1)
     CR = CI / RI[0,num_cols-1]
     print(CR)
     if CR < 0.1:
        print("矩阵的一致性可以接受")
     else:
        print("矩阵的一致性不可以接受")
#求解评分（权重）
     #算术平均法求权重
     col_sum = A.sum(axis=0)
     matrix1 = A / col_sum
     matrix1 = matrix1.sum(axis=1)
     matrix1 = matrix1/num_rows
     print(matrix1)
     #几何平均法求权重
     col_mul = A.prod(axis=1)
     matrix2 = np.power(col_mul,1/num_rows)
     fu = matrix2.sum(axis=0)
     matrix2 = matrix2 / fu
     print(matrix2)
     #特征值法求权重
     eigenvalues, eigenvectors = np.linalg.eig(A)
     max_eigenvalue_index = np.argmax(eigenvalues)
     max_eigenvalue = eigenvalues[max_eigenvalue_index]
     corresponding_eigenvector = eigenvectors[:, max_eigenvalue_index]
     vec = np.real(corresponding_eigenvector)
     col = vec.sum(axis=0)
     vec = vec / col
     print(vec)