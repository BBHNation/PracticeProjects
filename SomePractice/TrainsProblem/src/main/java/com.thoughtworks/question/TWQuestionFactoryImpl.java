package com.thoughtworks.question;

import java.util.Arrays;
import java.util.List;

/**
 * 实现问题工厂抽象接口的工厂类
 */
public class TWQuestionFactoryImpl implements TWQuestionFactory {

    /**
     * 生产问题对象
     * @param inputQuestionString 问题内容
     * @return 返回问题对象
     */
    @Override
    public TWQuestion product(String inputQuestionString) {
        List<String> inputStringList = Arrays.asList(inputQuestionString.split("\\:"));
        String keyword = inputStringList.get(0);
        TWQuestion question = null;
        switch (keyword) {
            case "distance_of_towns":
                question = new TWQuestionForDistance(inputStringList.get(1));
                break;
            case "length_of_shortest_path":
                question = new TWQuestionForShortestPath(inputStringList.get(1));
                break;
            case "num_of_routes_with_max_stations":
                question = new TWQuestionForRoutesLimited(inputStringList.get(1), true, false);
                break;
            case "num_of_routes_with_stations":
                question = new TWQuestionForRoutesLimited(inputStringList.get(1),false, false);
                break;
            case "num_of_routes_with_max_distance":
                question = new TWQuestionForRoutesLimited(inputStringList.get(1),false, true);
                break;
            default:
                break;
        }
        question.setQuestionContent(inputQuestionString);
        return question;
    }
}
