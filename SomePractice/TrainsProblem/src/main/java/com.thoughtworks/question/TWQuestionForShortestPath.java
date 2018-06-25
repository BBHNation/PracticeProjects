package com.thoughtworks.question;

import com.thoughtworks.util.TWTownMap;

import java.util.Arrays;
import java.util.List;

/**
 * 两站之间的最短路线问题
 */
public class TWQuestionForShortestPath implements TWQuestion {
    private String questionContent; // 问题内容
    private String startTown; // 开始站
    private String destTown; // 目的站


    public TWQuestionForShortestPath(String inputString) {
        List<String> inputStringList = Arrays.asList(inputString.split(","));
        this.startTown = inputStringList.get(0);
        this.destTown = inputStringList.get(1);
    }

    /**
     * 解决问题
     * @param map 地图对象
     * @return 问题的答案
     */
    @Override
    public String solveWithTownMap(TWTownMap map) {
        return map.shortestPathDistanceBetween(startTown, destTown).toString();
    }

    /**
     * 设置问题内容
     * @param content 问题内容
     */
    @Override
    public void setQuestionContent(String content) {
        this.questionContent = content;
    }

    @Override
    public String toString() {
        return questionContent;
    }
}
