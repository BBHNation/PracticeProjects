//
//  Merge Two Sorted Lists.swift
//  LeetCode
//
//  Created by Hancock on 2017/10/1.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import Cocoa

class Merge_Two_Sorted_Lists: NSObject {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil {
            return l2
        } else if l2 == nil {
            return l1
        }
        
        var newHead: ListNode?
        var move: ListNode?
        var newL1 = l1
        var newL2 = l2
        while newL1 != nil && newL2 != nil {
            if (newL1?.val)! > (newL2?.val)! {
                if newHead == nil {
                    newHead = newL2!
                    move = newHead
                } else {
                    move!.next = newL2
                    move = move!.next!
                }
                move?.next = newL1
                move = move?.next
            } else {
                if newHead == nil {
                    newHead = newL1!
                    move = newHead
                } else {
                    move!.next = newL1
                    move = move!.next!
                }
                move?.next = newL2
                move = move?.next
            }
            newL1 = newL1?.next
            newL2 = newL2?.next
        }
        
        if newL1 == nil {
            while newL2 != nil {
                move?.next = newL2
                move = move?.next
                newL2 = newL2?.next
            }
        } else if newL2 == nil {
            while newL1 != nil {
                move?.next = newL1
                move = move?.next
                newL1 = newL1?.next
            }
        }
        return newHead!
    }
}
