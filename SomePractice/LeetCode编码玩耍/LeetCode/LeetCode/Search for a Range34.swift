//
//  Search for a Range34.swift
//  LeetCode
//
//  Created by 白彬涵 on 2017/10/20.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import Cocoa

class Search_for_a_Range34: NSObject {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.count == 0 {
            return [-1, -1]
        }
        let index = binarySearch(nums: nums, target: target, low: 0, high: nums.count-1)
        if index == -1 {
            return [-1, -1]
        } else {
            var low = index
            var high = index
            while low >= 0 {
                if nums[low] == target {
                    low -= 1
                } else {
                    break
                }
            }
            while high <= nums.count - 1  {
                if nums[high] == target {
                    high += 1
                } else {
                    break
                }
            }
            return [low+1, high-1]
        }
    }
    
    func binarySearch(nums: [Int], target: Int, low: Int, high: Int) -> Int {
        let mid = (high - low)/2 + low // 向下取整
        if mid > nums.count-1 {
            return -1
        }
        if nums[mid] == target {
            return mid
        } else if target < nums[mid] {
            return binarySearch(nums: nums, target: target, low: low, high: mid-1)
        } else if target > nums[mid] {
            return binarySearch(nums: nums, target: target, low: mid+1, high: high)
        }
        return -1
    }
}
