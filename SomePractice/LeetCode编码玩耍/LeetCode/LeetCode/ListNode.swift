//
//  ListNode.swift
//  LeetCode
//
//  Created by Hancock on 2017/4/30.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import Foundation
//Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
