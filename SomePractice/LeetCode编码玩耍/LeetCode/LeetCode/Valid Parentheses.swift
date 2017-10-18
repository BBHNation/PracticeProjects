//
//  Valid Parentheses.swift
//  LeetCode
//
//  Created by 白彬涵 on 2017/9/29.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import Cocoa

public class Stack <T> {
    private var stack = [T]()
    
    public func push(value: T) {
        stack.append(value)
    }
    
    @discardableResult public func pop() -> T? {
        if stack.count >= 1 {
            return stack.removeLast()
        }
        return nil
    }
    
    public func peek() -> T? {
        return stack.last
    }
    
    public func empty() -> Bool {
        return stack.count == 0
    }
    
}

class Valid_Parentheses: NSObject {
    func isValid(_ s: String) -> Bool {
        let stack = Stack<Character>()
        for c in s.characters {
            if isValidCharecter(c: c) {
                if stack.peek() == nil {
                    // stack 为空
                    stack.push(value: c)
                    continue
                } else {
                    // stack 不为空
                    if isValidCharecters(l: c, r: stack.peek()!) {
                        let _ = stack.pop()
                        continue
                    } else {
                        stack.push(value: c)
                    }
                }
            } else {
                continue
            }
        }
        if stack.peek() != nil {
            return false
        } else {
            return true
        }
    }
    
    // 是否是括号
    func isValidCharecter(c: Character) -> Bool {
        if c == "(" || c == ")" || c == "{" || c == "}" || c == "[" || c == "]" {
            return true
        } else {
            return false
        }
    }
    
    // 是否是相对的括号
    func isValidCharecters(l: Character, r: Character) -> Bool {
        if (l == "(" && r == ")") || (l == ")" && r == "(") {
            return true
        } else if (l == "{" && r == "}") || (l == "}" && r == "{") {
            return true
        } else if (l == "[" && r == "]") || (l == "]" && r == "[") {
            return true
        } else {
            return false
        }
    }
}
