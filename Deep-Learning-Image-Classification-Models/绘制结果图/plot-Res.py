import pandas as pd
import matplotlib.pyplot as plt

# 文件路径
file_paths = [
    r'C:\Users\65349\Desktop\mycode\Deep-Learning-Image-Classification-Models\训练记录\resnet18.csv',
    r'C:\Users\65349\Desktop\mycode\Deep-Learning-Image-Classification-Models\训练记录\resnet34.csv',
    r'C:\Users\65349\Desktop\mycode\Deep-Learning-Image-Classification-Models\训练记录\resnet50.csv'
]

# 读取并提取数据
dfs = [pd.read_csv(file_path) for file_path in file_paths]
models = ['resnet18', 'resnet34', 'resnet50.csv']

# 创建一个包含三个子图的大图
fig, axes = plt.subplots(nrows=3, ncols=1, figsize=(10, 15))

bias = [ 'train Loss','training accuracy','val_accurate']

# 绘制对比图
for bia, model, ax in zip(bias, models, axes):
    line1,=ax.plot(dfs[0]['epoch'], dfs[0][bia], label=f'{models[0]}', linestyle='-', linewidth=2)
    line2,=ax.plot(dfs[1]['epoch'], dfs[1][bia], label=f'{models[1]}', linestyle='-', linewidth=2)
    line3,=ax.plot(dfs[2]['epoch'], dfs[2][bia], label=f'{models[2]}', linestyle='-', linewidth=2)

    # 添加标签和标题
    ax.set_xlabel('Epochs')
    ax.set_ylabel(f'{bia} ')
    ax.set_title(f'ResNet-{bia} ')
    ax.legend()
# 调整子图之间的间距
plt.subplots_adjust(hspace=0.5)
# 调整图例位置
axes[0].legend(bbox_to_anchor=(0.8, 1), loc='upper left',prop={'size': 8})
axes[1].legend(bbox_to_anchor=(0.8, 0.4), loc='upper left',prop={'size': 8})
axes[2].legend(bbox_to_anchor=(0.8, 0.4), loc='upper left',prop={'size': 8})
# 显示图形
plt.show()
