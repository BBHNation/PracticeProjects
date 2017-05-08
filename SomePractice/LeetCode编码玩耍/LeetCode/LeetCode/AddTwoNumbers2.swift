//
//  AddTwoNumbers2.swift
//  LeetCode
//
//  Created by Hancock on 2017/4/30.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/*
 You are given two non-empty linked lists representing two non-negative integers. The most significant digit comes first and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.
 
 You may assume the two numbers do not contain any leading zero, except the number 0 itself.
 
 Follow up:
 What if you cannot modify the input lists? In other words, reversing the lists is not allowed.
 
 Example:
 
 Input: (7 -> 2 -> 4 -> 3) + (5 -> 6 -> 4)
 Output: 7 -> 8 -> 0 -> 7
 */
import Foundation

 
class AddTwoNumbersII {
    /*
     算法思想
     先反转链表
     再相加
     再反转链表
     */
    
    /*
     函数：
     1、反转链表函数
     2、之前面的相加函数
     */
    /// 反转单链表：时间复杂度O（n），空间复杂度O（1）
    func reverseList(l : ListNode) -> ListNode {
        // 思路：每次将头节点放到链表最后
        let newHead : ListNode? = ListNode(-1)
        var curr : ListNode? = l
        var pre : ListNode? = l
        newHead?.next = l
        
        // O(n) n为List长度
        while curr != nil {
            pre = curr // pre是最后一个节点
            curr = curr?.next
        }
        
        // O(n) n为List长度
        while newHead?.next !== pre {
            let node = newHead?.next
            newHead?.next = newHead?.next?.next // 删除第一个节点
            node?.next = pre?.next// 将node插入到pre的后面
            pre?.next = node
        }
        return (newHead?.next)!
    }
    
    func main() {
        let firstNum = ListNode(9)
        firstNum.next = ListNode(8)
        firstNum.next?.next = ListNode(5)
        
        let secondeNum = ListNode(1)
        secondeNum.next = ListNode(8)
        secondeNum.next?.next = ListNode(5)
        
        _ = addTwoNumbers(firstNum, secondeNum)
        
        
    }
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var finalSum : ListNode?
        let q = reverseList(l: l1!)
        let p = reverseList(l: l2!)
        
        finalSum = AddTwoNumbers().finalAddTwoNumbers(q, p)
        return reverseList(l: finalSum!)
    }
}
