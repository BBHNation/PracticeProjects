//
//  线性时间排序.swift
//  IntroductionToAlgorithms
//
//  Created by 白彬涵 on 2017/8/25.
//  Copyright © 2017年 CMIOT. All rights reserved.
//

import Cocoa

class 线性时间排序 {
    
    /// 计数排序，已知数据不会超过某一个数k的时候使用，例如人的年龄可以假定不超过200
    /// 时间复杂度
    /// - Parameters:
    ///   - A: 需要排序的数组
    ///   - k: 最大数k
    func 计数排序(A: inout Array<Int>, k: Int) {
        var C = Array.init(repeating: 0, count: k+1) // 用来中间处理
        var B = Array.init(repeating: 0, count: A.count) // 用来保存排序好的数组
        for i in 0..<A.count { // 循环结束之后C中存储的是值A[i]的个数  O(n)
            C[A[i]] += 1
        }
        
        for i in 1...k { // 循环结束之后，C中存储的是比i小的个数   O(k)
            C[i] = C[i] + C[i-1]
        }
        
        for i in 0..<B.count { // O(n)
            B[C[ A[i] ]-1] = A[i]
            C[A[i]] -= 1
        }
        
        A = B
    }
    
    
    
    /// 基数排序，按照最低位到最高位的多次排序
    ///
    /// - Parameters:
    ///   - A: 需要排序的数组
    ///   - d: 位数
    func 基数排序(A: inout Array<Int>, d: Int) {
        for i in 0..<d {
            // 利用一个稳定的排序算法，将数组按照第i位排序 ,这里要将某个位数的排序和整体联系在一起
            let k = pow(10.0, Double(i))
            var digitArr = A.map({$0 / Int(k) % Int(k*10)}) // 取得相应位数的数组
            // 将计数排序做一个变换
            var C = Array.init(repeating: 0, count: 10)
            var B = Array.init(repeating: 0, count: digitArr.count)
            
            for i in 0..<digitArr.count {
                C[digitArr[i]] += 1
            }
            
            for i in 1...9 {
                C[i] += C[i-1]
            }
            
            for i in (0..<B.count).reversed() { // 这里注意要倒序，因为同样的数字是按照大到小排列
                B[C[digitArr[i]] - 1] = A[i] // 这里给排序好的数组不再是单个位数，而是以原数组的数据为元数据
                C[digitArr[i]] -= 1
            }
            
            A = B
        }
    }
    
    
    
    /// 桶排序，属于将0-1分为A.count个桶，每个桶里装一个链表，链表需要排序，桶也是排序好的
    ///
    /// - Parameter A: 需要排序的数组 A的每个元素都是0-1之间的
    class ListNode {
        var next: ListNode?
        var value: Double?
        
        static func appendListNode(head: ListNode, newNode: ListNode) {
            var newHead = head
            while newHead.next != nil {
                newHead = newHead.next!
            }
            newHead.next = newNode
        }
        
        
        /// 有序的插入数据到列表中
        ///
        /// - Parameters:
        ///   - head: 根节点
        ///   - newNode: 新节点
        static func appendListNodeWithOrdered(head: ListNode, newNode: ListNode) {
            var newHead = head
            var preNode = head
            while newHead.next != nil {
                preNode = newHead
                newHead = newHead.next!
                if newNode.value! > newHead.value! {
                    continue
                }
                else {
                    // 如果新的数据比newHead要小
                    // preNode存的是指向当前newHead的Node
                    preNode.next = newNode
                    newNode.next = newHead
                }
            }
            newHead.next = newNode
        }
        
        static func getArrFromList(head: ListNode) -> [Double] {
            var finalArr = [Double]()
            var newHead = head
            while newHead.next != nil {
                newHead = newHead.next!
                finalArr.append(newHead.value!)
            }
            return finalArr
        }
    }
    func 桶排序(A: inout Array<Double>) {
        let n = A.count
        var B = [ListNode]()
        for _ in 0..<n { // 时间复杂度 n
            B.append(ListNode())
        }
        for i in 0..<A.count { // 时间复杂度 n*k
            // insert A[i] into list B[ n*A[i] ] (取下界)
            let index = Int(Double(n)*A[i] / 1)
            let head = B[index]
            let newNode = ListNode()
            newNode.value = A[i]
//            ListNode.appendListNode(head: head, newNode: newNode) // 在最尾部添加节点，这里可以加一个排序判断
            ListNode.appendListNodeWithOrdered(head: head, newNode: newNode) // 这里实现了有序插入
        }
        
        var C = [Double]()
        for i in 0..<A.count {
            C += ListNode.getArrFromList(head: B[i])
        }
        A = C
    }
    
}
