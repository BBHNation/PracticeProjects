//
//  最大子数组问题.swift
//  IntroductionToAlgorithms
//
//  Created by 白彬涵 on 2017/8/23.
//  Copyright © 2017年 CMIOT. All rights reserved.
//

import Cocoa
/// 采用策略（strategy）设计模式
/// 面向协议编程
protocol 最大子数组协议 {
    func find_maximum_subarray(A: Array<Int>)
        ->
        (maxLeft: Int, maxRight: Int, sum: Int)
}


/// 主要的类
class 最大子数组问题 {
    var strategy: 最大子数组协议
    init(withStrategy strategy: 最大子数组协议) {
        self.strategy = strategy
    }
}


/// 分治算法
class 最大子数组分治算法: 最大子数组协议 {
    /// 找到跨中位的最大子数组
    ///
    /// - Parameters:
    ///   - A: 原来的数组
    ///   - low: 最低位
    ///   - mid: 中位
    ///   - high: 最高位
    /// - Returns: 返回（左边边界，右边边界，最大子数组和）
    
    /// 时间复杂度为n，时间复杂度为常量
    func find_max_crossing_subarray
        (A: Array<Int>, low: Int, mid: Int, high: Int)
        ->
        (leftIndex: Int, rightIndex: Int, sum: Int)
    {
        var left_sum = Int.min // 当前最大的子数组和
        var sum = 0 // 左边数组总和
        var max_left = 0 // 记录最大的左边边界
        for i in (low...mid).reversed() { // 遍历mid～low（包括mid和low）
            // 时间复杂度为n
            sum += A[i]
            if sum > left_sum {
                left_sum = sum
                max_left = i
            }
        }
        
        var right_sum = Int.min // 当前最大的右边子数组和
        var max_right = 0 // 记录最大的右边边界
        sum = 0
        for i in mid+1 ... high { // 遍历mid+1～high-1
            // 时间复杂度为n
            sum += A[i]
            if sum > right_sum {
                right_sum = sum
                max_right = i
            }
        }
        
        return (max_left, max_right, left_sum + right_sum)
    }
    
    
    
    /// 寻找最大子数组
    ///
    /// - Parameters:
    ///   - A: 原来的数组
    ///   - low: 低位，可以递归调用
    ///   - high: 高位，可以递归调用
    /// - Returns: 返回元祖（低位的下标，高位的下标，最大子数组和）
    func find_maximum_subarray(A: Array<Int>, low: Int, high: Int)
        ->
        (maxLeft: Int, maxRight: Int, sum: Int)
    {
        if high == low { // 高位等于低位，查找范围只有一个数字，直接返回
            return (low, high, A[low])
        }
        else {
            let mid = (high-low)/2 + low // 这样的做法可以防止溢出
            // 假设最大子数组在中位数左侧, 递归调用自己
            let (left_low, left_high, left_sum) = find_maximum_subarray(A: A, low: low, high: mid)
            // 假设最大子数组在中位数的右侧, 递归调用自己
            let (right_low, right_high, right_sum) = find_maximum_subarray(A: A, low: mid+1, high: high)
            // 假设最大子数组跨越了中位数
            let (cross_low, cross_higth, cross_sum) = find_max_crossing_subarray(A: A, low: low, mid: mid, high: high)
            
            // 三种假设中，谁的子数组和计算出最大，就采用哪种方法
            if left_sum >= right_sum && left_sum >= cross_sum {
                return (left_low, left_high, left_sum)
            } else if right_sum >= left_sum && right_sum >= cross_sum {
                return (right_low, right_high, right_sum)
            } else {
                return (cross_low, cross_higth, cross_sum)
            }
        }
    }
    
    /// 协议函数
    func find_maximum_subarray(A: Array<Int>) -> (maxLeft: Int, maxRight: Int, sum: Int) {
        if A.count == 0 {
            return (0, 0, 0)
        }
        return find_maximum_subarray(A: A, low: 0, high: A.count-1)
    }
}


/// 暴力求解方法 时间复杂度是 O（n2）
class 最大子数组暴力算法: 最大子数组协议 {
    func find_maximum_subarray(A: Array<Int>) -> (maxLeft: Int, maxRight: Int, sum: Int) {
        if A.count == 0 {
            return (0, 0, 0)
        }
        var leftIndex = 0
        var rightIndex = 0
        var maxSum = Int.min
        
        for i in 0..<A.count {
            var temSum = 0
            for j in i..<A.count {
                temSum += A[j] // 先加上，如果加上一个比之前的大，则修改数据
                if temSum > maxSum {
                    maxSum = temSum
                    leftIndex = i
                    rightIndex = j
                }
            }
        }
        return (leftIndex, rightIndex, maxSum)
    }
}

class 最大子数组扫描算法: 最大子数组协议 {
    
    /// 扫描一次的算法
    ///
    /// - Parameter A: 数组
    /// - Returns: 返回（左边界，右边界，和）
    func find_maximum_subarray(A: Array<Int>) -> (maxLeft: Int, maxRight: Int, sum: Int) {
        var leftIndex = 0
        var rightIndex = 0
        var sum = 0
        
        for i in 0..<A.count {
            if A[i] > 0 {
                sum += A[i]
                rightIndex = i
            } else if A[i] < 0 {
                if sum < 0 || (sum + A[i]) < 0 {
                    sum = 0
                    leftIndex = i
                    rightIndex = i
                }
            }
        }
        
        if leftIndex == rightIndex && leftIndex == A.count-1 && sum != A[rightIndex]{
            sum = A.max()! // 时间复杂度为n
            leftIndex = A.index(of: sum)! // 时间复杂度为n
            rightIndex = leftIndex
        }
        return (leftIndex, rightIndex, sum)
    }
}
