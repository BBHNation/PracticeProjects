//
//  AddTowNumbers.swift
//  LeetCode
//
//  Created by 白彬涵 on 2017/4/28.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/*
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.
 
 You may assume the two numbers do not contain any leading zero, except the number 0 itself.
 
 Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
 Output: 7 -> 0 -> 8
 */
import Foundation

class AddTwoNumbers {
    class Solution {
        func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
            /*
             算法思想：
             因为是反序存储的链表，
             所以第一个数就是个位数，
             直接遍历相加，
             如果有进位则直接存起来在下一个遍历加时候检测一个进位符
             */
            var newL1 = l1
            var newL2 = l2
            var finalSum : ListNode?
            var flag : Bool = false //true 表示需要进位
            while newL1 != nil && newL2 != nil{
                var intSum = (newL1?.val)! + (newL2?.val)!
                if flag {
                    intSum += 1
                }
                if intSum >= 10 {
                    intSum = intSum % 10
                    flag = true
                } else {
                    flag = false
                }
                let newNode = ListNode(intSum)
                if finalSum == nil {
                    finalSum = newNode
                } else {
                    var preNode = finalSum
                    while preNode?.next != nil {
                        preNode = preNode?.next
                    }
                    preNode?.next = newNode
                }
                
                newL1 = newL1?.next
                newL2 = newL2?.next
            }
            
            var node : ListNode?
            if newL1 == nil {
                node = newL2
            } else {
                node = newL1
            }
            
            while node != nil {
                var newNode : ListNode?
                if flag {
                    var num = (node?.val)! + 1
                    if num >= 10 {
                        num = num % 10
                        flag = true
                    } else{
                        flag = false
                    }
                    newNode = ListNode(num)
                    
                } else {
                    newNode = ListNode((node?.val)!)
                }
                var preNode = finalSum
                while preNode?.next != nil {
                    preNode = preNode?.next
                }
                preNode?.next = newNode
                node = node?.next
            }
            
            if flag {
                let newNode = ListNode(1)
                var preNode = finalSum
                while preNode?.next != nil {
                    preNode = preNode?.next
                }
                preNode?.next = newNode
            }
            return finalSum
        }
    }
    
    func finalAddTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        /*
         算法时间复杂度为O(max(m,n))
         空间复杂度为O(max(m,n)) 因为最终的结果长度为max(m,n)
         其中m和n为两个数的长度
         */
        var finalResult : ListNode?
        var curr : ListNode?
        var p = l1
        var q = l2
        var carry : Int = 0
        while p != nil || q != nil {
            let a = p == nil ? 0 : p?.val ?? 0
            let b = q == nil ? 0 : q?.val ?? 0
            var sum = carry + a + b
            carry = sum / 10
            sum = sum % 10
            if finalResult == nil{
                finalResult = ListNode(sum)
                curr = finalResult
            }else {
                curr?.next = ListNode(sum)
                curr = curr?.next!
            }
            if p != nil { p = p?.next }
            if q != nil { q = q?.next }
        }
        if carry > 0 { curr?.next = ListNode(1) }
        return finalResult
    }
    
    func printList(first : ListNode, seconde : ListNode, l : ListNode) {
        var newL : ListNode? = first
        var fir : String = ""
        while newL != nil {
            fir = fir + "\((newL?.val)!)"
            newL = newL?.next ?? nil
        }
        print(fir)
        
        print(" + ")
        
        newL = seconde
        var sec : String = ""
        while newL != nil {
            sec = sec + "\((newL?.val)!)"
            newL = newL?.next ?? nil
        }
        print(sec)
        
        print(" = ")
        
        newL = l
        var sum : String = ""
        while newL != nil {
            sum = sum + "\((newL?.val)!)"
            newL = newL?.next ?? nil
        }
        print(sum)
    }
    
    func main() {
        let firstNum = ListNode(9)
        firstNum.next = ListNode(8)
        firstNum.next?.next = ListNode(5)
        
        let secondeNum = ListNode(1)
        secondeNum.next = ListNode(8)
        secondeNum.next?.next = ListNode(5)
        
        let result = finalAddTwoNumbers(firstNum, secondeNum)
        self.printList(first: firstNum, seconde: secondeNum, l: result!)
    }
}
