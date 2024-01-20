# Deep-Learning-Image-Classification-Models
My code and models with readme.md are publicly available at https://github.com/qsking8/Deep-Learning-Image-Classification-Models
## 1. 实验环境
- 在Colab平台上利用Tesla V4 GPU进行在线训练。
- 使用Colab提供的默认环境即可运行该代码。

## 2. 数据集下载
- 训练图片的大小和iamgeNet数据集大小一致，为224*244
- 花朵数据集，此数据集包含五种不同种类的224*224花朵图像，用于训练的图像有3306张，用于验证的图像有364张。
- 下载地址链接：https://pan.baidu.com/s/1v6qMV2S9XBaVTP6bulv5RA?pwd=bejn 
提取码：bejn
## 3. 运行方式
- 将数据集下载，放置到Deep-Learning-Image-Classification-Models/Datasets/flower.zip下
- 将全部文件上传到谷歌网盘
- 在colab上就可以直接运行Classification.ipynb即可。
- 注意，Classification.ipynb中含有解压数据集的代码段，无需将flower.zip解压
## 4. 实验结果
|train| Loss	|training accuracy|	val_accurate|
| :-----: | :----: | :----: |:----: |
|ResNet-18	|4.3E-05|	1	|0.744505|
|ResNet-34	|2.4E-05	|1|	0.695055|
|ResNet-50	|1.8E-4	|1	|0.71978|
|RE-ResNet-18	|2.3E-05	|1	|0.758242|
|RE-ResNet-34	|1.8E-05	|1|	0.766484|
|RE-ResNet-50	|6.0E-06	|1|	0.801314|
|Swin-tniy	|0.003458	|0.986388|	0.733516|
|Swin-small	|0.03574	|0.975499|	0.722527|
|Swin-base	|0.344897	|0.686328|	0.664835|
## 5. 训练参数下载
- 本实验对花朵数据集进行epoch为100的训练。
- 训练后的9个模型最优参数下载地址https://drive.google.com/open?id=1-pvCnkMkKT1wesJql0rz8ULo6CY5HyvS&usp=drive_copy
- 包括9个模型的best.pth和last.pkl


