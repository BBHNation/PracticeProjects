//
//  MedianOfTwoSortedArrays.swift
//  LeetCode
//
//  Created by 白彬涵 on 2017/5/9.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/**
 There are two sorted arrays nums1 and nums2 of size m and n respectively.
 
 Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).
 
 nums1 = [1, 3]
 nums2 = [2]
 
 The median is 2.0
 
 nums1 = [1, 2]
 nums2 = [3, 4]
 
 The median is (2 + 3)/2 = 2.5
 
 */
import Foundation
class MedianTwoSortedArrays {
    /**
     算法思路
     两个排序好的数组求其共有的中位数
     中位数其实作用是分割一个数组，两个数组也是同样
     问题变为：
     1、找到一个i，分割nums1，左侧为nums1Left（0 —— i-1），右侧为nums1Right（i —— n）
     2、找到一个j，分割nums2，左侧为nums2Left（0 —— j-1），右侧为nums2Right（j —— m）
     3、将nums1Left和nums2Left统称为Left，将nums1Right和nums2Right统称为Right，使得满足条件：
        （1）max（Left）<= min（Right） 左边群体中最大的数小于等于右边最小的数（实现有序分割）
        （2）len（Left）== len（Right） 左边的长度是等于右边的长度（实现中位）
     4、如果3的条件满足，则中位数为：（max（Left）+ min（Right））／2
     
     将3中的条件实现为代码：
        （1）max(Left) <= min(Right)  ===>  max(nums1[i-1],nums2[j-1]) <= min(nums[i],nums[j]) （获得判断条件） B[j-1] <= A[i] and A[i-1] <= B[j]   (因为原数组有序)
        （2）len(Left) == len(Right)  ===>  i+j == (n-i) + (m-j)  ===>  i == (m+n)/2-j   （获得了i和j的关系）  if n >= m, we just need to set: i = 0 ~ m, j = (m + n + 1)/2 - i ？？？
                ps.1 For simplicity, I presume A[i-1],B[j-1],A[i],B[j] are always valid even if i=0/i=m/j=0/j=n . I will talk about how to deal with these edge values at last.
                ps.2 Why n >= m? Because I have to make sure j is non-nagative since 0 <= i <= m and j = (m + n + 1)/2 - i. If n < m , then j may be nagative, that will lead to wrong result.
     
     问题就转化为了寻找符合条件的i，
     这时候使用binarySearch，则可以达到O（Log（m+n））的复杂度
     */
    func main() {
        var nums1 = [1, 3]
        var nums2 = [2]
        print(findMedianSortedArrays(nums1, nums2))
    }
    
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var q = nums1
        var p = nums2
        if nums2.count < nums1.count {
            q = nums2
            p = nums1
        }
        
        var i = 0 // 需要去查找的i
        var j = 0
        // 查找i的范围从minI到maxI
        var minI = 0
        var maxI = q.count-1
        while minI<=maxI {
            i = (maxI + maxI)/2
            j = (q.count + p.count + 1)/2 - i //根据之前的关系推来,左右群体的长度相同
            
            if q[i-1] > p[j] && i>0 {
                // i太大，减小i
                maxI = i-1
            } else if q[i] < p[j-1] && i<q.count {
                //i太小
                minI = i+1
            }
            else {
                // 找到了符合条件的i，可以计算中位数
                return Double((max(q[i-1], p[j-1]) + min(q[i], p[j])))/2
            }
        }
        return -1.0
        
    }
}
