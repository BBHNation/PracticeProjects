package com.thoughtworks;

import com.thoughtworks.service.TWTrainProblemServiceImpl;
import java.io.FileNotFoundException;

public class Application {
    public static void main(String[] args) {
        try {
            TWTrainProblemServiceImpl service = new TWTrainProblemServiceImpl();
            // 初始化服务
            service.initWithFile("src/resource/graph.txt");
            // 初始化服务问题
            service.inputQuestionWithFile("src/resource/question.txt");
            // 输入问题答案
            System.out.println(service.outputAnswer()); // 输出数据，并保存在本地txt中
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

    }
}
