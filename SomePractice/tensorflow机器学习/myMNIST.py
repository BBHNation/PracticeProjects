# coding:utf-8
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import os
os.environ['TF_CPP_MIN_LOG_LEVEL']='2'

import argparse
import tensorflow as tf
from tensorflow.examples.tutorials.mnist import input_data

# Import data
FLAGS = None
parser = argparse.ArgumentParser()
parser.add_argument('--data_dir', type=str, default='/tmp/tensorflow/mnist/input_data',
                      help='Directory for storing input data')
FLAGS, unparsed = parser.parse_known_args()
mnist = input_data.read_data_sets(FLAGS.data_dir, one_hot=True)
# mnist.train train Data
# mnist.test test Data
# mnist.validation validation Data

x = tf.placeholder(tf.float32, [None, 784])
# x不是一个特定的值，而是一个占位符placeholder，
# 我们在TensorFlow运行计算时输入这个值。
# 我们希望能够输入任意数量的MNIST图像，每一张图展平成784维的向量。
# 我们用2维的浮点数张量来表示这些图，这个张量的形状是[None，784 ]。
# （这里的None表示此张量的第一个维度可以是任何长度的。）

W = tf.Variable(tf.zeros([784, 10])) # 权重
b = tf.Variable(tf.zeros([10])) # 便质量
# 我们赋予tf.Variable不同的初值来创建不同的Variable：
# 在这里，我们都用全为零的张量来初始化W和b。因为我们要学习W和b的值，它们的初值可以随意设置。
# 注意，W的维度是[784，10]，因为我们想要用784维的图片向量乘以它以得到一个10维的证据值向量，
# 每一位对应不同数字类。b的形状是[10]，所以我们可以直接把它加到输出上面。

y = tf.nn.softmax(tf.matmul(x,W)+b)
# 实现Model y
# 首先，我们用tf.matmul(​​X，W)表示x乘以W，对应之前等式里面的，
# 这里x是一个2维张量拥有多个输入。然后再加上b，把和输入到tf.nn.softmax函数里面。

# 交叉熵的计算
y_ = tf.placeholder(tf.float32, [None,10])
# 为了计算交叉熵，我们首先需要添加一个新的占位符用于输入正确值：

cross_entropy = -tf.reduce_sum(y_*tf.log(y)) # 交叉熵
# 首先，用 tf.log 计算 y 的每个元素的对数。
# 接下来，我们把 y_ 的每一个元素和 tf.log(y) 的对应元素相乘。
# 最后，用 tf.reduce_sum 计算张量的所有元素的总和。
# （注意，这里的交叉熵不仅仅用来衡量单一的一对预测和真实值，
# 而是所有100幅图片的交叉熵的总和。对于100个数据点的预测表现比单一数据点的表现能更好地描述我们的模型的性能）

train_step = tf.train.GradientDescentOptimizer(0.01).minimize(cross_entropy)
# 在这里，我们要求TensorFlow用梯度下降算法（gradient descent algorithm）以0.01的学习速率最小化交叉熵。
# 梯度下降算法（gradient descent algorithm）是一个简单的学习过程，
# TensorFlow只需将每个变量一点点地往使成本不断降低的方向移动。

init = tf.global_variables_initializer()

sess = tf.Session()
sess.run(init)

for i in range(1000):
    batch_xs, batch_ys = mnist.train.next_batch(100)
    sess.run(train_step, feed_dict={x: batch_xs, y_:batch_ys})
    # 该循环的每个步骤中，我们都会随机抓取训练数据中的100个批处理数据点，
    # 然后我们用这些数据点作为参数替换之前的占位符来运行train_step。



# 评估性能
# 首先让我们找出那些预测正确的标签。
# tf.argmax 是一个非常有用的函数，它能给出某个tensor对象在某一维上的其数据最大值所在的索引值。
# 比如tf.argmax(y,1)返回的是模型对于任一输入x预测到的标签值，
# 而 tf.argmax(y_,1) 代表正确的标签，我们可以用 tf.equal 来检测我们的预测是否真实标签匹配(索引位置一样表示匹配)。
correct_prediction = tf.equal(tf.argmax(y,1), tf.argmax(y_,1))
# 这行代码会给我们一组布尔值。为了确定正确预测项的比例，我们可以把布尔值转换成浮点数，
# 然后取平均值。例如，[True, False, True, True] 会变成 [1,0,1,1] ，取平均值后得到 0.75.


accuracy = tf.reduce_mean(tf.cast(correct_prediction, "float"))
# 最后，我们计算所学习到的模型在测试数据集上面的正确率。
print(sess.run(accuracy, feed_dict={x: mnist.test.images, y_: mnist.test.labels}))
