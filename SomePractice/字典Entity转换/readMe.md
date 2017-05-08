#使用BaseEntiy类来做字典和类的转换
--
类似于SwiftyEntity的类，使用字典来初始化

特性有：

- 大量使用Runtime特性，来获取属性和设置属性
- 使用单独的非ARC处理，BaseEntity并没有使用ARC，需要设置
- 设置方法：

	打开Targets -->Build Phases -->Compile Sources，双击需要修改ARC设置的文件。在空白中添加下列信息。

	如果你的工程是开启ARC的, 那就需要对某些文件禁用ARC, (-fno-objc-arc)

	如果你的工程是关闭ARC的, 那就需要对某些文件开启ARC.(-fobjc-arc)