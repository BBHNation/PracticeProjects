package com.thoughtworks.question;

import com.thoughtworks.model.TWTown;
import com.thoughtworks.util.TWDirectedGraph;
import com.thoughtworks.util.TWTownMap;
import com.thoughtworks.util.TWTownMapImpl;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

public class QuestionForDistance implements Question {
    private List<TWTown> towns;

    public QuestionForDistance(String inputString) {
        List<String> inputStringList = Arrays.asList(inputString.split("//,"));
        this.towns = new LinkedList<>();
        for (String input : inputStringList) {
            towns.add(new TWTown(input));
        }
    }

    @Override
    public String solveWithTownMap(TWTownMap map) throws QuestionSolveFaildException {

        List<String> townNames = towns.stream().map(town->town.getName()).collect(Collectors.toList());
        try {
            return map.distanceWithPath(townNames).toString();
        } catch (TWTownMapImpl.NoSuchRouteException e) {
            throw new QuestionSolveFaildException(e.getMessage());
        }
    }
}
