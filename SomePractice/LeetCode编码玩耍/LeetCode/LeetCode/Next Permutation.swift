//
//  Next Permutation.swift
//  LeetCode
//
//  Created by 白彬涵 on 2017/10/18.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import Cocoa

class Next_Permutation: NSObject {
    func nextPermutation(_ nums: inout [Int]) {
        // 1 2 3 4 -> 1 2 4 3 -> 1 3 2 4 -> 1 3 4 2 -> ...
        // 从尾向头找到非递增的那个数字，再跟遍历过的数字比较大小，找到比它还小的数，交换位置，递增排序交换后的尾巴数列
        var indexLeft = -1
        var indexRight = -1
        for i in (1..<nums.count).reversed() {
            if nums[i] <= nums[i-1] {
                continue
            } else {
                // 找到了非递增的i
                indexLeft = i-1
                break
            }
        }
        if indexLeft == -1 {
            nums = nums.reversed()
            return
        }
        
        for i in (0..<nums.count).reversed() {
            if nums[indexLeft] < nums[i] {
                indexRight = i
                break
            } else {
                continue
            }
        }
        
        // Swap
        let tem = nums[indexLeft]
        nums[indexLeft] = nums[indexRight]
        nums[indexRight] = tem
        
        // Resort
        var left = Array.init(nums[0...indexLeft])
        let right = Array.init(nums[(indexLeft+1)..<nums.count].reversed())
        for i in right {
            left.append(i)
        }
        nums = left
    }
}
