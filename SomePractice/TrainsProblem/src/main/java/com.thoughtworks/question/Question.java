package com.thoughtworks.question;

import com.thoughtworks.util.*;

public interface Question {
    static public class QuestionSolveFaildException extends RuntimeException {
        public QuestionSolveFaildException(String message) {
            super(message);
        }
    }
    public String solveWithTownMap(TWTownMap map);
}
