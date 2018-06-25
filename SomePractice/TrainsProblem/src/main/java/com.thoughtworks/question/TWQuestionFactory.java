package com.thoughtworks.question;

/**
 * 问题工厂抽象类
 */
public interface TWQuestionFactory {
    /**
     * 产出问题对象的方法
     * @param inputQuestionString 问题内容
     * @return 返回具体的问题对象
     */
    public TWQuestion product(String inputQuestionString);
}
