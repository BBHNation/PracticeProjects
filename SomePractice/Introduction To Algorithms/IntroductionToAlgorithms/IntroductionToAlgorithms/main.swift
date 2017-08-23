//
//  main.swift
//  IntroductionToAlgorithms
//
//  Created by 白彬涵 on 2017/8/23.
//  Copyright © 2017年 CMIOT. All rights reserved.
//

import Foundation
let strategy = 最大子数组分治算法()
let violence = 最大子数组暴力算法()
let scan = 最大子数组扫描算法()
//var a = 最大子数组问题(withStrategy: violence)
//var a = 最大子数组问题(withStrategy: strategy)
var a = 最大子数组问题(withStrategy: scan)
//let arr = [1,-2,5,5,-12,3,6,10,-9,-3]
let arr = [-1,-2,-5,-5,-12,-3,-6,-10,-9,-3]

let date = Date()
let (left, right, sum) = a.strategy.find_maximum_subarray(A: arr)
print("time is : \(Date().timeIntervalSince(date)*1000.0)")
print("左边边界：\(left), 右边边界：\(right),和：\(sum)")

