//
//  堆排序.swift
//  IntroductionToAlgorithms
//
//  Created by 白彬涵 on 2017/8/24.
//  Copyright © 2017年 CMIOT. All rights reserved.
//

import Cocoa

class 堆排序 {
    // 建立一个大顶堆
    // 维持大顶堆属性的MaxHeapify（A，i）函数 （  O（lgn） ）
    // 使用MaxHeapify来创建大顶堆
    // 每次剔除大顶堆堆顶，然后维持属性，完成堆排序（  O（n*lgn） ）
    
    // 数据机构的设置方面：可以使用结构体描述，可以使用数组加上下标来描述：下标i的左孩子是下标2*i+1，右孩子是2*i-1
    
    /// 检查某一位是否是符合大顶堆要求 时间复杂度 O(lgn)
    ///
    /// - Parameters:
    ///   - A: 数组
    ///   - i: 下标
    func max_heapify(A: inout Array<Int>, i: Int) {
        if A.count == 0 {
            return
        }
        let (li, lv) = left(A: A, i: i)
        let (ri, rv) = right(A: A, i: i)
        if lv > A[i] && lv > rv {// lv最大
            exchange(a: &A[li], b: &A[i])
            max_heapify(A: &A, i: li) // 递归调用自己
        } else if rv > lv && rv > A[i] {
            exchange(a: &A[ri], b: &A[i])
            max_heapify(A: &A, i: ri) // 递归调用自己
        } else {
            return
        }
    }
    
    
    /// 将给出的数组转化为大顶堆 时间复杂度 O(n*lgn)
    ///
    /// - Parameter A: 数组
    func build_max_heapify(A: inout Array<Int>) {
        for i in (0..<A.count).reversed() { // 从底向上的开始新建大顶堆
            max_heapify(A: &A, i: i)
        }
    }
    
    
    /// 堆排序 时间复杂度O(2*n*lgn) 空间复杂度 O(n)
    ///
    /// - Parameter A: 需要排序的数组
    func heapify_sort(A: inout Array<Int>) {
        build_max_heapify(A: &A) // 将A建立为大顶堆 O(n*lgn)
        var sortedArr = [Int]() // 空间复杂度n
        let count = A.count
        // n次操作
        for i in (0..<count).reversed() { // 每次取出大顶堆的顶,i = A.count-1,最后一个
            exchange(a: &A[i], b: &A[0]) // 交换最后一个和第一个，也就是交换了最大的和较小的，最大的数到了A【i】中  O(1)
            sortedArr.append(A[i]) // 将最大的数保存到排序好的数组中 O(1)
            A.removeLast() // 删除最后一个，这里并不会出现i out range的情况 O(1)
            max_heapify(A: &A, i: 0) // 重新将数组排序为大顶堆 O(lgn)
        }
        A = sortedArr
    }
    
    // 交换两者
    func exchange(a: inout Int, b: inout Int) {
        let c = b
        b = a
        a = c
    }
    
    // 返回数组A中，下标i的左孩子
    func left(A: Array<Int>, i: Int) -> (index: Int, value: Int){
        let index = 2*i+1
        if index > A.count-1 {
            return (index, Int.min)
        }
        return (index, A[index])
    }
    
    // 返回数组A中，下标i的右孩子
    func right(A: Array<Int>, i: Int) -> (index: Int, value: Int) {
        let index = 2*i+2
        if index > A.count-1 {
            return (index, Int.min)
        }
        return (index, A[index])
    }
    
    
}
