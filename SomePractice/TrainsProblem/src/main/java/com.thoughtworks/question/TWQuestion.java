package com.thoughtworks.question;

import com.thoughtworks.util.*;

/**
 * 问题抽象接口
 */
public interface TWQuestion {
    /**
     * 问题解决时候出现错误
     */
    static public class QuestionSolveFaildException extends RuntimeException {
        public QuestionSolveFaildException(String message) {
            super(message);
        }
    }

    /**
     * 解决当前问题
     * @param map 地图对象
     * @return 返回执行之后返回的接口
     */
    public String solveWithTownMap(TWTownMap map);

    /**
     * 设置问题内容
     * @param content 问题内容
     */
    public void setQuestionContent(String content);
}
