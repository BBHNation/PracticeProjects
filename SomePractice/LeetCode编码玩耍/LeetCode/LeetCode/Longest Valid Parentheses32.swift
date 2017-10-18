//
//  Longest Valid Parentheses32.swift
//  LeetCode
//
//  Created by 白彬涵 on 2017/10/18.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import Cocoa

extension String {
    public subscript(position: Int) -> Character {
        precondition((0..<characters.count).contains(position), "index out of range")
        let positionIndex = index(startIndex, offsetBy: position)
        return self[positionIndex]
    }
}

class Longest_Valid_Parentheses32: NSObject {
    func longestValidParentheses(_ s: String) -> Int {
        // 使用栈实现
        var maxans = 0
        let stack = Stack<Int>()
        stack.push(value: -1)
        
        for i in 0..<s.characters.count {
            if s[i] == "(" {
                // 如果是等于"(" 则将这个入栈
                stack.push(value: i)
            } else {
                // 如果是")"，先pop，再处理
                stack.pop()
                if stack.empty() {
                    stack.push(value: i)
                } else {
                    // 如果是pop之后不为空，则进行处理
                    maxans = max(maxans, i-stack.peek()!)
                }
            }
            
        }
        return maxans
    }
}
