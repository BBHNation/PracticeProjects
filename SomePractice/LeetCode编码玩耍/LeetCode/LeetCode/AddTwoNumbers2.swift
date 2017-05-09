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
    
    
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var finalSum : ListNode?
        let q = reverseList(l: l1!)
        let p = reverseList(l: l2!)
        
        finalSum = AddTwoNumbers().finalAddTwoNumbers(q, p)
        return reverseList(l: finalSum!)
    }
    
    
    /**
      Follow up:
     What if you cannot modify the input lists? In other words, reversing the lists is not allowed.
     */
    
    /**
     思路：
     1、补0
     2、相加
     3、保存进位链表和tag
     4、递归调用自己
     */
    
    func calculateZero(_ l1 : ListNode, _ l2 : ListNode) -> (Int, Bool) {
        var q : ListNode? = l1
        var p : ListNode? = l2
        while q != nil && p != nil{
            q = q?.next
            p = p?.next
        }
        var count = 0
        var x = q==nil ? p : q
        let isFirstList : Bool = x===q ? true : false
        while x != nil {
            x = x?.next
            count += 1
        }
        return (count, isFirstList)
    }
    
    func addZero(_ l : ListNode?, _ zeroCount : Int) -> ListNode {
        let head = ListNode(0)
        head.next = l
        for _ in 0..<zeroCount {
            let newNode = ListNode(0)
            newNode.next = head.next
            head.next = newNode
        }
        return head.next!
    }
    
    func addTwoList(_ l1 : ListNode, _ l2 : ListNode) -> ListNode{
        // 保证位数相同
        var q : ListNode? = l1
        var p : ListNode? = l2
        let carryList : ListNode? = ListNode(-1)// 存储进位链表
        var carryFinal : ListNode? = carryList// 存储carry的最后一个节点
        var carryTag : Bool = false// 存储有无进位
        
        var sumList : ListNode? = ListNode(-1)// 存储无进位信息的和
        var sumFinal : ListNode? = sumList// 存储sumList的最后一个节点
        
        
        while q != nil && p != nil {
            var sum = (q?.val)! + (p?.val)!
            let newNode = ListNode(sum/10)//进位信息
            
            // 存储进位信息到carry中
            if sum/10 == 1 { carryTag = true }//如果有进位，设置进位表示符为true
            carryFinal?.next = newNode
            carryFinal = newNode
            
            sum = sum % 10//当前位的结果，去除了进位信息
            
            let xinNode = ListNode(sum)
            
            // 存储非进位信息的和到sumList中
            sumFinal?.next = xinNode
            sumFinal = xinNode
            
            q = q?.next
            p = p?.next
        }
        
        if carryTag {// 如果有进位，则让结果与进位相加
            
            // 给非进位的链表头加一个0
            let newNode = ListNode(0)
            newNode.next = sumList?.next
            sumList?.next = newNode
            
            // 给进位信息链表尾加一个0
            let zeroNode = ListNode(0)
            carryFinal?.next = zeroNode
            
            // 递归调用
            return addTwoList((sumList?.next!)!, (carryList?.next!)!)
        }
        else {
            while sumList?.next?.val == 0 && sumList?.next?.next != nil {
                sumList = sumList?.next
            }
            return (sumList?.next!)!
        }
    }
    
    func newAddTwoNumberII(_ l1 : ListNode, _ l2 : ListNode) -> ListNode {
        let firstNum = l1
        let secondeNum = l2
        
        let result = calculateZero(firstNum, secondeNum)
        var newFirstList = result.1 ? secondeNum : firstNum
        newFirstList = addZero(newFirstList, result.0)
    
        let newSecondeList = result.1 ? firstNum : secondeNum
        return addTwoList(newFirstList, newSecondeList)
    }
    
    func main() {
        let firstNum = ListNode(8)
        firstNum.next = ListNode(9)
        firstNum.next?.next = ListNode(9)
        // 985
        
        let secondeNum = ListNode(2)
//        secondeNum.next = ListNode(8)
//        secondeNum.next?.next = ListNode(5)
//        secondeNum.next?.next?.next = ListNode(5)
//        secondeNum.next?.next?.next?.next = ListNode(5)
        // 38555
        
        
        let resultList = newAddTwoNumberII(firstNum, secondeNum)
        print(resultList.val)
    }
    
}
