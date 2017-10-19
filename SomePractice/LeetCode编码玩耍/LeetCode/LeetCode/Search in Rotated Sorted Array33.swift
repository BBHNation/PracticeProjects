//
//  Search in Rotated Sorted Array33.swift
//  LeetCode
//
//  Created by 白彬涵 on 2017/10/19.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import Cocoa

class Search_in_Rotated_Sorted_Array33: NSObject {
    func search(_ nums: [Int], _ target: Int) -> Int {
        if nums.count == 0 {
            return -1
        }
        var lo = 0
        var hi = nums.count - 1
        while lo <= hi {
            let mid = Int(ceil((Double(lo) + Double(hi))/2)) // 这里是Int，应该是想下取整
            if nums[mid] == target {
                return mid
            }
            
            if nums[mid] > nums[lo] {
                if target >= nums[lo] && target < nums[mid] {
                    hi = mid - 1
                } else {
                    lo = mid + 1
                }
            } else {
                if target > nums[mid] && target <= nums[hi] {
                    lo = mid + 1
                } else {
                    hi = mid - 1
                }
            }
        }
        if lo > 1 {
            lo = lo - 1
        }
        return nums[lo] == target ? lo : -1
    }
}
