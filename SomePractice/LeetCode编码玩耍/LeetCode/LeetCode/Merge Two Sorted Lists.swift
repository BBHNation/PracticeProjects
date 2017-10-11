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
        
        if (l1?.val)! > (l2?.val)! {
            let newNode = ListNode((l2?.val)!)
            newNode.next = mergeTwoLists(l1, l2?.next)
            return newNode
        } else {
            let newNode = ListNode((l1?.val)!)
            newNode.next = mergeTwoLists(l1?.next, l2)
            return newNode
        }
    }
}
