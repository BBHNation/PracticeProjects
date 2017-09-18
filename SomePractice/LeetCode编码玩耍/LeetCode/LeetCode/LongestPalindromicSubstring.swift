//
//  LongestPalindromicSubstring.swift
//  LeetCode
//
//  Created by 白彬涵 on 2017/9/15.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import Cocoa
// https://segmentfault.com/a/1190000003914228
class LongestPalindromicSubstring {
    func longestPalindrome(_ s: String) -> String {
        // 预处理
        var ns = [Character]()
        for c in s.characters {
            ns.append("#")
            ns.append(c)
        }
        ns.append("#")
        
        
        var RL = Array.init(repeating: 0, count: ns.count)
        var MaxRight = 0
        var pos = 0
        var MaxLen = 0
        
        for i in 0..<ns.count {
            if i < MaxRight {
                RL[i] = min(RL[ min(2*pos - 1, ns.count - 1) ], MaxRight - i) // pos = 0 怎么办？
            } else {
                RL[i] = 1
            }
            
            
            // 更新RL[i]
            while i-RL[i] >= 0 && i+RL[i] < ns.count && ns[i-RL[i]] == ns[i+RL[i]] {
                RL[i] += 1
            }
            
            if RL[i]+i-1 > MaxRight {
                MaxRight = RL[i] + i - 1
                pos = i
            }
            MaxLen = max(MaxLen, RL[i])
            
            // 长度是MaxLen-1, 中点是pos, 开始点是 2*maxRight - Pos
        }
        
        
        return String.init(ns[2*pos-MaxRight...MaxRight].filter({ (c) -> Bool in
            return c != "#"
        }))
    }
}
