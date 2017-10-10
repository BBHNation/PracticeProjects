# coding:utf-8
import glob

# 获取图片信息
image_file_names = glob.glob("./Images-dogs/n02*/*.jpg")
print image_file_names[0:2]

from itertools import groupby
from collections import defaultdict

# 初始化训练集合
training_data_set = defaultdict(list)

# 初始化测试集合
testing_data_set = defaultdict(list)

# 将文件名分解为品种和相应的文件名，品种对应于文件夹名称
image_file_name_with_breed = map(lambda filename:(filename.split("/")[2], filename), image_file_names)
print image_file_name_with_breed[0:2]

# 依据品种（image_file_name_with_breed 的第0个分量） 对图像分组
for dog_breed, breed_images in groupby(image_file_name_with_breed, lambda x: x[0]):
    # 枚举每个品种的图像， 并将大致20%的图像加入到测试集
    for i, breed_image in enumerate(breed_images):
        if i % 5 == 0:
            testing_data_set[dog_breed].append(breed_image[1])
        else:
            training_data_set[dog_breed].append(breed_image[1])

    # 检查每个品种的图像是否至少是全部图像的18%以上
    breed_training_count = len(training_data_set[dog_breed])
    breed_testing_count = len(testing_data_set[dog_breed])
    print breed_testing_count
    print breed_training_count
    assert round(breed_testing_count / (breed_testing_count + breed_training_count), 2) == 0, "Not enough testing images"



