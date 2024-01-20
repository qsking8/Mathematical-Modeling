import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np
import math
import pandas as pd
import matplotlib as mpl

''' 绘制散点图
sns.set() 
#改变风格：sns.set(style='whitegrid') 调整颜色：sns.set(palette="RdBu")
tips = sns.load_dataset("tips")
sns.relplot(x="total_bill",y="tip",col="time",hue="smoker",style="smoker",size="size",data=tips)
# =后面均为相关参数的列名  x与y表示横纵轴   hue表示不同类型用不同颜色点标注
# col(row)表示按该类型分成两张（四张）单表    size表示该数据不同程度用不同大小的点表示
plt.show()
'''

'''绘制线性回归模型
sns.set()
tips = sns.load_dataset("tips")
sns.lmplot(x="total_bill",y="tip",data=tips)
# ci = 60 可调整置信区间  hue = "smoker"可为两类数据分别作出线性回归曲线
# lowess = True 可用于进行局部加权线性回归作图
plt.show()
'''

'''绘制直方图
sns.set(style='white')
sns.displot(x,bins=20,kde=True)
# bins表示设置多少个分组，kde表示是否显示数据分布曲线
plt.show()
'''

'''绘制热力图
sns.set()
sns.set(font_scale=1.5)
sns.set_context({"figure.figsize":(8,8)})
data = {
    'A': np.random.randint(0, 50, 100),
    'B': np.random.randint(0, 50, 100),
    'C': np.random.randint(0, 50, 100),
    'D': np.random.randint(0, 50, 100),
    'E': np.random.randint(0, 50, 100),
    'F': np.random.randint(0, 50, 100)
}
df = pd.DataFrame(data)
corr = df.corr()
mask = np.zeros_like(corr)
mask[np.triu_indices_from(mask)] = True
sns.axes_style("white")
sns.heatmap(corr,mask = mask, vmin = 0.0,vmax = 1.0,annot=True,linewidths=0.3,linecolor="grey",cmap="RdBu_r",
            cbar_kws={"orientation":"horizontal"},center=0.5,square=True)
plt.show()
# vmax：设置颜色带的最大值 vmin：设置颜色带的最小值 cmap:设置颜色带的色系
# center: 颜色带分界线   annot：是否显示数字标注  fmt:数值的格式
# linewidth: 每个小方格之间的间距   linecolor：控制分割线的颜色
# cbar_kws：关于颜色带的设置  mask:预设的矩阵，用于屏蔽某些方格
'''

'''绘制曲线图
x = np.arange(-10, 10, 0.1)
y = []
for t in x:
    y_1 = 1 / (1 + math.exp(-t))
    y.append(y_1)
sns.set_style("whitegrid") #sns仅用于设置样式
plt.plot(x, y, label="sigmoid")
plt.xlabel("x")
plt.ylabel("y")
plt.ylim(0, 1)
plt.legend()
plt.show()
'''
