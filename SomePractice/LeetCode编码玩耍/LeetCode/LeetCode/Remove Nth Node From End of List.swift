//
//  Remove Nth Node From End of List.swift
//  LeetCode
//
//  Created by 白彬涵 on 2017/9/26.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

/*
 Given a linked list, remove the nth node from the end of list and return its head.
 
 For example,
 
 Given linked list: 1->2->3->4->5, and n = 2.
 
 After removing the second node from the end, the linked list becomes 1->2->3->5.
 Note:
 Given n will always be valid.
 Try to do this in one pass.
 
将链表的倒数第N个节点删除，直接使用两个指针遍历，先指针先走N步，后指针再开始走，先指针到尾，后指针就是需要删除的节点
 */

import Cocoa

class Remove_Nth_Node_From_End_of_List: NSObject {
    static func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var fastPointer = head
        var slowPointer = head
        var prePointer = head
        var count = n
        while fastPointer?.next != nil {
            fastPointer = fastPointer?.next
            
            if count <= 1 {
                prePointer = slowPointer
                slowPointer = slowPointer?.next
            } else {
                count -= 1
            }
        }
        if slowPointer === head {
            return slowPointer?.next
        }
        prePointer?.next = slowPointer?.next
        return head
    }
}
