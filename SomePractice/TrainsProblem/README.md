#Train Problem Readme
## 代码的主要层次为：
```
TrainsProblem
	-src
		-main
		-resource
		-test
	-target
	pom.xml
	README.md
```

其中`src`为源代码，`pom.xml`为`maven`项目管理配置文件，`target`为`maven`编译目标文件夹。在`src`中，`main`包含的是主要实现，`resource`为资源文件（三个txt文件），`test`为测试文件夹。

## 主要的类和解释
- `util` // 通用类
	- `TWDirectedGraph.java` // 有向图的算法实现，是主要的类
	- `TWTownMap.java` // 对有向图的一层对象封装，是一个接口
	- `TWTownMapImpl.java` // 对TWTownMap接口的实现
- `service` // 服务于Main函数
	- `TWTrainProblemService` // 接口：暴露输入输出的方法
	- `TWTrainProblemServiceImpl` // 实现上述接口，服务于Main函数
- `question` // 用于识别从文件中读取的问题
	- `TWQuestion.java` // 接口：包含解决问题的方法定义
	- `TWQuestionFactory.java` // 工厂类，按需生产问题类对象
	- `TWQuestionForDistance.java` // 距离问题相关类
	- `TWQuestionForRoutesLimited.java` // 线路条数问题相关类
	- `TWQuestionForShortestPath.java` // 最短路线问题相关类
- `model` // Town类定义
	- `TWTown.java`


## 主要的测试类和解释
- `TWDirectedGraphTest.java` // 有向图的测试类
- `TWQuestionTest.java` // 问题类的测试类
- `TWTownMapTest.java` // 封装的地图类的测试类

## 主要的资源文件
- `answer.txt` // 输出答案的文件
- `graph.txt` // 有向图的输入文件
- `question.txt` // 问题输入的文件

## 主要的算法
- 迪杰斯特拉算法最短路径算法
- 深度优先搜索算法

## 程序运行方法
- 使用IDEA设置主类Application运行
- 使用maven构建完毕后命令行运行