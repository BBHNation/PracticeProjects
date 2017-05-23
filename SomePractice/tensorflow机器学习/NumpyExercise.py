# coding:utf-8
import socket
import numpy as np

z = np.zeros(10)
print z

z[4] = 5
print z

z = np.arange(10,50) # 创建范围数组
z = z[::-1] # 反转数组
print z

z = np.arange(9).reshape(3,3) # 创建一个三维数组
print z

nz = np.nonzero([1,2,0,0,4,0]) # 找到非0的索引
print nz

z = np.eye(3) # 创建3*3单位向量
print z

z = np.random.random((3,3,3)) # 产生随机的三维向量
print z

z = np.random.random((10,10))
Zmin, Zmax = z.min(), z.max()
print Zmin,Zmax

z = np.ones((10,10)) # 创建一个全是1的二维数组
z[1:-1,1:-1] = 0
print z

z = np.random.random(30)
m = z.mean() # 平均数
print m

Z = np.zeros((5,5))
Z += np.arange(0,5)
print(Z)

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(('www.sina.com.cn',80))
# 发送数据:
s.send(b'GET / HTTP/1.1\r\nHost: www.sina.com.cn\r\nConnection: close\r\n\r\n')
# 接收数据:
buffer = []
while True:
    # 每次最多接收1k字节:
    d = s.recv(1024)
    if d:
        buffer.append(d)
    else:
        break
data = b''.join(buffer)
print data






