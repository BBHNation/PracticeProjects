package com.thoughtworks;

import com.thoughtworks.service.*;

import java.io.FileNotFoundException;


public class Application {
    public static void main(String[] args) {
        try {
            TWTrainProblemServiceImpl service = new TWTrainProblemServiceImpl("src/resource/graph.txt");
            service.inputQuestionWithFile("src/resource/question.txt");
            System.out.println(service.outputAnwser()); // 输出数据，并保存在本地txt中
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

    }
}
