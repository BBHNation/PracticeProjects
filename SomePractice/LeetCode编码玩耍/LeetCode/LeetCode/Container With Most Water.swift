//
//  Container With Most Water.swift
//  LeetCode
//
//  Created by 白彬涵 on 2017/9/19.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

/*
 Given n non-negative integers a1, a2, ..., an, where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.
 
 Note: You may not slant the container and n is at least 2.
 */

import Cocoa

class Container_With_Most_Water {
    static func maxArea(_ height: [Int]) -> Int {
        var maxValue = 0
        var leftIndex = 0
        var rightIndex = height.count - 1
        while leftIndex < rightIndex {
            let value = min(height[leftIndex], height[rightIndex]) * (rightIndex - leftIndex)
            if value > maxValue {
                maxValue = value
            }
            if height[leftIndex] < height[rightIndex] {
                leftIndex += 1
            } else {
                rightIndex -= 1
            }
        }
        return maxValue
    }
}
