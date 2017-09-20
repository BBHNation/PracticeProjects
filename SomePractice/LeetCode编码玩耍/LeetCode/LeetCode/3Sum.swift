//
//  3Sum.swift
//  LeetCode
//
//  Created by 白彬涵 on 2017/9/20.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import Cocoa

class ThreeSum {
    static func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 {
            return [[Int]]()
        }
        
        var finalArr = [[Int]]()
        let newNums = nums.sorted { $0 <= $1 }
        // 先排序，非降序排序
        // 再去重
        // 再使用指针趋近
        for i in 0..<newNums.count - 2 {
            if i >= 1 && newNums[i] == newNums[i-1] {
                continue
            }
            
            var left = i+1
            var right = newNums.count - 1
            while left < right {
                let sum = newNums[i] + newNums[left] + newNums[right]
                if sum == 0 {
                    finalArr.append([newNums[i], newNums[left], newNums[right]])
                    left += 1
                    right -= 1
                    
                    // 接下来是去重
                    while left < right && newNums[left] == newNums[left - 1] {
                        left += 1
                    }
                    while left < right && newNums[right] == newNums[right + 1] {
                        right -= 1
                    }
                } else if sum < 0 {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
        return finalArr
    }
}
