package com.thoughtworks.question;

import com.thoughtworks.model.TWTown;
import com.thoughtworks.util.TWTownMap;
import com.thoughtworks.util.TWTownMapImpl;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 针对多个城镇的距离的问题类
 */
public class TWQuestionForDistance implements TWQuestion {
    private List<TWTown> towns; // 城镇列表
    private String questionContent; // 问题内容

    public TWQuestionForDistance(String inputString) {
        List<String> inputStringList = Arrays.asList(inputString.split(","));
        this.towns = new LinkedList<>();
        for (String input : inputStringList) {
            towns.add(new TWTown(input));
        }
    }

    /**
     * 解决当前的问题
     * @param map 地图对象
     * @return 返回问题解决之后的结果
     * @throws QuestionSolveFaildException 问题解决时候出错
     */
    @Override
    public String solveWithTownMap(TWTownMap map) throws QuestionSolveFaildException {

        List<String> townNames = towns.stream().map(town->town.getName()).collect(Collectors.toList());
        try {
            return map.distanceWithPath(townNames).toString();
        } catch (TWTownMapImpl.NoSuchRouteException e) {
            throw new QuestionSolveFaildException(e.getMessage());
        }
    }

    /**
     * 设置问题内容
     * @param content 问题内容
     */
    @Override
    public void setQuestionContent(String content) {
        questionContent = content;
    }

    @Override
    public String toString() {
        return questionContent;
    }
}
