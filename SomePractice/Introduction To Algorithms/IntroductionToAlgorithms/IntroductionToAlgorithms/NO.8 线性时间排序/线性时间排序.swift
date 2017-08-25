//
//  线性时间排序.swift
//  IntroductionToAlgorithms
//
//  Created by 白彬涵 on 2017/8/25.
//  Copyright © 2017年 CMIOT. All rights reserved.
//

import Cocoa

class 线性时间排序 {
    
    /// 计数排序，已知数据不会超过某一个数k的时候使用，例如人的年龄可以假定不超过200
    /// 时间复杂度
    /// - Parameters:
    ///   - A: 需要排序的数组
    ///   - k: 最大数k
    func 计数排序(A: inout Array<Int>, k: Int) {
        var C = Array.init(repeating: 0, count: k+1) // 用来中间处理
        var B = Array.init(repeating: 0, count: A.count) // 用来保存排序好的数组
        for i in 0..<A.count { // 循环结束之后C中存储的是值A[i]的个数  O(n)
            C[A[i]] += 1
        }
        
        for i in 1...k { // 循环结束之后，C中存储的是比i小的个数   O(k)
            C[i] = C[i] + C[i-1]
        }
        
        for i in 0..<B.count { // O(n)
            B[C[ A[i] ]-1] = A[i]
            C[A[i]] -= 1
        }
        
        A = B
    }
}
