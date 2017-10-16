//
//  Merge k Sorted Lists.swift
//  LeetCode
//
//  Created by 白彬涵 on 2017/10/12.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

// 使用优先队列来做，也就是使用大顶堆来实现
// 或者多次使用merge two sorted lists方法来做
import Cocoa

/// 堆
protocol Heep {
    associatedtype T
    func add(t: T)
    func poll() -> T
    func isEmpty() -> Bool
}

class ListNode_Heap: Heep {
    typealias T = ListNode
    func add(t: ListNode) {}
    func poll() -> ListNode { return ListNode.init(-1) }
    func isEmpty() -> Bool { return true }
}

protocol Merge_K {
    func mergeKLists(_ lists: [ListNode?]) -> ListNode?
}

class Merge_k_Sorted_Lists: NSObject {
    
    func mergeKLists1(_ lists: [ListNode?]) -> ListNode? {
        let h = ListNode_Heap()
        for node in lists {
            if node != nil {
                h.add(t: node!)
            }
        }
        
        let dummy = ListNode(0)
        var tail: ListNode? = dummy
        
        while !h.isEmpty() {
            tail!.next = h.poll()
            tail = tail!.next
            
            if tail!.next != nil {
                h.add(t: tail!.next!)
            }
        }
        return dummy.next
    }
    
    
    func mergeKLists2(_ lists: [ListNode?]) -> ListNode? {
        var arr = lists
        let mergeTwoList = Merge_Two_Sorted_Lists()
        if lists.count > 2 {
            let count = arr.count
            let l1 = arr.remove(at: count-1)
            let l2 = arr.remove(at: count-2)
            let newNode = mergeTwoList.mergeTwoLists(l1, l2)
            arr.append(newNode)
            return self.mergeKLists2(arr)
        } else {
            return mergeTwoList.mergeTwoLists(lists.first!, lists.last!)
        }
    }
}
