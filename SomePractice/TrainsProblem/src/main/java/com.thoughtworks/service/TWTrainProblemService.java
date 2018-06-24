package com.thoughtworks.service;

import java.io.FileNotFoundException;

public interface TWTrainProblemService {
	
    public void initWithFile(String filePath) throws FileNotFoundException;

    public void inputQuestionWithFile(String filePath) throws FileNotFoundException;

    public String outputAnwser();
}
