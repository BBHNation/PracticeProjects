package com.thoughtworks.question;

import com.thoughtworks.util.TWTownMap;

import java.util.Arrays;
import java.util.List;

/**
 * 针对某个条件下有多少条路径的问题
 */
public class TWQuestionForRoutesLimited implements TWQuestion {
    private boolean isMaxStation = false; // 是最大站条件
    private boolean isMaxDistance = false; // 是最大距离条件
    private String startTown; // 开始站
    private String destTown; // 目的站
    private Integer stations; // 停靠数量
    private String questionContent; // 问题内容


    public TWQuestionForRoutesLimited(String inputString, boolean isMaxStation, boolean isMaxDistance) {
        List<String> inputStringList = Arrays.asList(inputString.split(","));
        this.startTown = inputStringList.get(0);
        this.destTown = inputStringList.get(1);
        this.stations = Integer.valueOf(inputStringList.get(2));
        this.isMaxStation = isMaxStation;
        this.isMaxDistance = isMaxDistance;
    }

    /**
     * 解决问题
     * @param map 地图对象
     * @return 问题解决之后的结果
     */
    @Override
    public String solveWithTownMap(TWTownMap map) {
        if (isMaxStation) {
            return map.numOfRoutesWithMaxStations(startTown,destTown,stations).toString();
        } else if (isMaxDistance) {
            return map.numOfRoutesWithMaxDistance(startTown, destTown, stations).toString();
        } else {
            return map.numOfRoutesWithStations(startTown,destTown,stations).toString();
        }
    }

    @Override
    public void setQuestionContent(String content) {
        this.questionContent = content;
    }

    @Override
    public String toString() {
        return questionContent;
    }
}
