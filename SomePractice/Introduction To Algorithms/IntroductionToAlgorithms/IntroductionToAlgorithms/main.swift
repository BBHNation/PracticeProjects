//
//  main.swift
//  IntroductionToAlgorithms
//
//  Created by 白彬涵 on 2017/8/23.
//  Copyright © 2017年 CMIOT. All rights reserved.
//

import Foundation
func 堆排序测试() {
    let heapSort = 堆排序()
    var arr = [23, 17, 14, 6, 13, 10, 1, 5, 7, 12]
    heapSort.max_heapify(A: &arr, i: 3)
    print(arr)
    
    var sourceArray = [2,3,1,5,12,32,9]
    heapSort.build_max_heapify(A: &sourceArray)
    print(sourceArray)
    
    heapSort.heapify_sort(A: &sourceArray)
    print(sourceArray)
    
}

func 最大子数组测试() {
//    let strategy = 最大子数组分治算法()
//    let violence = 最大子数组暴力算法()
    let scan = 最大子数组扫描算法()
    //var a = 最大子数组问题(withStrategy: violence)
    //var a = 最大子数组问题(withStrategy: strategy)
    let a = 最大子数组问题(withStrategy: scan)
    //let arr = [1,-2,5,5,-12,3,6,10,-9,-3]
    let arr = [-1,-2,-5,-5,-12,-3,-6,-10,-9,-3]
    
    let date = Date()
    let (left, right, sum) = a.strategy.find_maximum_subarray(A: arr)
    print("time is : \(Date().timeIntervalSince(date)*1000.0)")
    print("左边边界：\(left), 右边边界：\(right),和：\(sum)")
}

func 快速排序测试() {
    let quickSort = 快速排序()
    var sourceArray = [2,3,1,5,12,32,9]
    quickSort.quick_sort(A: &sourceArray, p: 0, r: 6)
    print(sourceArray)
}

func 线性排序测试() {
    let xianxing = 线性时间排序()
    var sourceArray = [0,2,3,1,5,12,32,9]
//    xianxing.计数排序(A: &sourceArray, k: 32)
    xianxing.基数排序(A: &sourceArray, d: 2)
    
    var floatArray = [0.13, 0.3, 0.5, 0.11, 0.12, 0.23, 0.56, 0.9]
    xianxing.桶排序(A: &floatArray)
    print(floatArray)
}


线性排序测试()

