package com.thoughtworks.service;

import java.io.FileNotFoundException;

/**
 * 问题服务类，服务于Main函数
 */
public interface TWTrainProblemService {
    /**
     * 通过Graph文件来初始化（graph.txt）
     * @param filePath 文件路径
     * @throws FileNotFoundException 文件没找到的错误
     */
    public void initWithFile(String filePath) throws FileNotFoundException;

    /**
     * 通过问题的本地文件来初始化问题（question.txt）
     * @param filePath 文件路径
     * @throws FileNotFoundException 文件没找到的错误
     */
    public void inputQuestionWithFile(String filePath) throws FileNotFoundException;

    /**
     * 输出所有问题的答案，并写入本地文件（answer.txt）
     * @return 返回所有问题的答案
     */
    public String outputAnswer();
}
