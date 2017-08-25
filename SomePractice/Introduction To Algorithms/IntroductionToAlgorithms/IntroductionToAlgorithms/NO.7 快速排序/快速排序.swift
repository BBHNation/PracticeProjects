//
//  快速排序.swift
//  IntroductionToAlgorithms
//
//  Created by 白彬涵 on 2017/8/25.
//  Copyright © 2017年 CMIOT. All rights reserved.
//

import Cocoa

class 快速排序 {
    
    /// 快速排序
    ///
    /// - Parameters:
    ///   - A: 数组需要排序的数组A[p...r]
    ///   - p: 左边的下标
    ///   - r: 右边的下标
    func quick_sort(A: inout Array<Int>, p: Int, r: Int) {
        if p < r {
            let q = partition(A: &A, p: p, r: r) // 这一步之后，所有A[p..q-1]都小于A[q],所有A[q+1..r]都大于A[q]
            quick_sort(A: &A, p: p, r: q-1) // 递归的调用自己
            quick_sort(A: &A, p: q+1, r: r) // 递归的调用自己
        }
    }
    
    
    /// 返回一个中间大小的数的下标
    ///
    /// - Parameters:
    ///   - A: 需要修改的数组
    ///   - p: 左边的下标
    ///   - r: 右边的下标
    /// - Returns: 返回的中值的下标
    func partition(A: inout Array<Int>, p: Int, r: Int) -> Int {
        let value = A[r] // 先记录下最后一个数
        var index = p-1 // 记录下标
        for i in p..<r { // 开始循环比较，不包括r自己
            if A[i] < value { // 如果A[i]小于标志值，则和数组较前的数交换（交换的数）
                index += 1 // 给记录的下标自增1，这里的index始终描述的是index（包含）左侧的数小于value
                exchange(a: &A[index], b: &A[i]) // 交换当前较小的数和之前较小数的后一位
            }
            // else ,i自增，但是记录的下标不会自增，i可以遍历所有（不包含r），但是index记录的是小于value的下标
        }
        exchange(a: &A[index+1], b: &A[r]) // 将A[index+1] 也就是比value大的一个数放到最后，这时候index+1的位置就是正确的数了
        // 接下里需要做的就是递归调用自己
        return index + 1 // 返回中值的下标
    }
    
    
    /// 增加随机性的取主元
    ///
    /// - Parameters:
    ///   - A: 需要修改的数组
    ///   - p: 左边的下标
    ///   - r: 右边的下标
    /// - Returns: 返回主元的新位置，也就是下标
    func partition_random(A: inout Array<Int>, p: Int, r: Int) -> Int {
        // 相对于一般的partition函数，这里增加了随机性质的主元
        let random = Int(arc4random()%UInt32(A.count))
        exchange(a: &A[random], b: &A[r])
        let value = A[r]
        var index = p - 1
        for i in p..<r {
            if A[i] < value {
                index += 1
                exchange(a: &A[i], b: &A[index])
            }
        }
        exchange(a: &A[index+1], b: &A[r])
        return index + 1
    }
    
    func exchange(a: inout Int, b: inout Int) {
        let c = b
        b = a
        a = c
    }
}
