//
//  动态贵哈.swift
//  IntroductionToAlgorithms
//
//  Created by 白彬涵 on 2017/9/8.
//  Copyright © 2017年 CMIOT. All rights reserved.
//

import Cocoa

/**
 背包问题：
 你是一个小偷，背包有4kg的容量，你在店里偷东西，
 店中的物品和重量分别是：
 吉他：1500¥ 1kg
 音响：3000¥ 4kg
 笔记本电脑：2000¥ 3kg
 iPhone：2000¥ 1kg
 要求偷到东西价值最大
 */


let 吉他 = Object(price: 1500, weight: 1)
let 音响 = Object(price: 3000, weight: 4)
let 笔记本电脑 = Object(price: 2000, weight: 3)
let iPhone = Object(price: 2000, weight: 1)
let objects = [吉他, 音响, 笔记本电脑, iPhone]
let dataArray = [(77,92), (22, 22), (29, 87), (50, 46), (99, 90)]


struct Object {
    let price: Double
    let weight: Double
    var valueble: Double {
        get {
            return price/weight
        }
    }
}

struct ObjectArr {
    var arr = [Object]()
    init(Arr: [(Int, Int)]) {
        for item in Arr {
            arr.append(Object(price: Double(item.0), weight: Double(item.1)))
        }
    }
}



class 背包问题简单处理 {
    /**
     思路如下，
     计算出单个价值最大者
     排序，选择偷单个价值最大者
     */
    func main() {
        let arr = ObjectArr.init(Arr: dataArray)
        let valuebleObjects = arr.arr.sorted { (left, right) -> Bool in
            return left.valueble > right.valueble
        }
        print(valuebleObjects)
        var sum = 0.0
        var weight = 100.0
        for item in valuebleObjects {
            if item.weight < weight {
                weight -= item.weight
                sum += item.price
            }
        }
        print(sum)
    }
}

class 动态规划 {
    
}
