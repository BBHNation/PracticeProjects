//
//  main.swift
//  IntroductionToAlgorithms
//
//  Created by 白彬涵 on 2017/8/23.
//  Copyright © 2017年 CMIOT. All rights reserved.
//

import Foundation
let strategy = 最大子数组分治算法()
var a = 最大子数组问题(withStrategy: strategy)
let arr = [1,-2,5,5,-12,3,6,10,-9,-3]

let date = Date()
let (left, right, sum) = a.strategy.find_maximum_subarray(A: arr, low: 0, high: 9)
print("time is : \(Date().timeIntervalSince(date)*1000.0)")

print("左边边界：\(left), 右边边界：\(right),和：\(sum)")

