from .resnet import  resnet18,resnet34, resnet50
from .swin_transformer import swin_tiny_patch4_window7_224, swin_small_patch4_window7_224, swin_base_patch4_window7_224
from .SENet import *
cfgs = {
    'resnet18': resnet18,
    'resnet34': resnet34,
    'resnet50': resnet50,
    'swin_transformer_tiny': swin_tiny_patch4_window7_224,
    'swin_transformer_small': swin_small_patch4_window7_224,
    'swin_transformer_base': swin_base_patch4_window7_224,
    'SE_ResNet18':SE_ResNet18,
    'SE_ResNet34':SE_ResNet34,
    'SE_ResNet50':SE_ResNet50
}

def find_model_using_name(model_name, num_classes):   
    return cfgs[model_name](num_classes)

 
