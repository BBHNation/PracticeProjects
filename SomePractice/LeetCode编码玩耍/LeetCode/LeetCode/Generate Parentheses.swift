//
//  Generate Parentheses.swift
//  LeetCode
//
//  Created by 白彬涵 on 2017/10/11.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import Cocoa

class Generate_Parentheses: NSObject {
    func generateParenthesis(_ n: Int) -> [String] {
        var list = [String]()
        backtrack(list: &list, str: "", open: 0, close: 0, max: n)
        return list
    }
    
    func backtrack(list: inout [String], str: String, open: Int, close: Int, max: Int) {
        if str.count == max*2 {
            list.append(str)
            return
        }
        
        if open < max {
            backtrack(list: &list, str: str+"(", open: open+1, close: close, max: max)
        }
        
        if close < open {
            backtrack(list: &list, str: str+")", open: open, close: close+1, max: max)
        }
    }
}
