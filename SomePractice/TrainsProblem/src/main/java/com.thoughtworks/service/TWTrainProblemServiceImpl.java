package com.thoughtworks.service;

import com.thoughtworks.util.*;
import com.thoughtworks.question.*;

import java.io.FileNotFoundException;
import java.util.List;

public class TWTrainProblemServiceImpl implements TWTrainProblemService {
    private TWTownMapImpl townMap;
    private List<Question> questions;

    public TWTrainProblemServiceImpl(String filePath) throws FileNotFoundException {
        townMap.initWithFile(filePath);
    }

    @Override
    public void initWithFile(String filePath) throws FileNotFoundException {
        townMap.initWithFile(filePath);
    }

    @Override
    public void inputQuestionWithFile(String filePath) throws FileNotFoundException {

    }

    @Override
    public String outputAnwser() {
        return null;
    }

}
