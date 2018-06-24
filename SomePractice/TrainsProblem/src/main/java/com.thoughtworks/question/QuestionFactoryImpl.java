package com.thoughtworks.question;

import java.util.Arrays;
import java.util.List;

public class QuestionFactoryImpl implements QuestionFactory {

    @Override
    public Question product(String inputQuestionString) {
        List<String> inputStringList = Arrays.asList(inputQuestionString.split("\\:"));
        if (inputStringList.get(0).equals("distance")) {
            new QuestionForDistance(inputStringList.get(1));
        }
        return null;
    }
}
