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
        
        let dummy = ListNode(-1)
        var tail: ListNode? = dummy
        var tail1 = l1
        var tail2 = l2
        // 到这里l1和l2都不是nil
        while tail1 != nil && tail2 != nil {
            if (tail1?.val)! > (tail2?.val)! {
                tail!.next = ListNode.init((tail2?.val)!)
                tail2 = tail2?.next
            } else {
                tail!.next = ListNode.init((tail1?.val)!)
                tail1 = tail1?.next
            }
            tail = tail?.next
        }
        
        
        var tail3: ListNode?
        if tail1 == nil {
            tail3 = tail2
        } else {
            tail3 = tail1
        }
        
        while tail3 != nil {
            tail?.next = tail3
            tail = tail?.next
            tail3 = tail3?.next
        }
        
        return dummy.next
        
        /* 下面是使用的递归方式
        if (l1?.val)! > (l2?.val)! {
            let newNode = ListNode((l2?.val)!)
            newNode.next = mergeTwoLists(l1, l2?.next)
            return newNode
        } else {
            let newNode = ListNode((l1?.val)!)
            newNode.next = mergeTwoLists(l1?.next, l2)
            return newNode
        }
         */
    }
}
