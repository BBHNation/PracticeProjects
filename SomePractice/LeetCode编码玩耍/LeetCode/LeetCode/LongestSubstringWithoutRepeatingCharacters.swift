//
//  LongestSubstringWithoutRepeatingCharacters.swift
//  LeetCode
//
//  Created by 白彬涵 on 2017/5/2.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

/*
 没有重复字母的最长子字符串
 Given a string, find the length of the longest substring without repeating characters.
 
 Examples:
 
 Given "abcabcbb", the answer is "abc", which the length is 3.
 
 Given "bbbbb", the answer is "b", with the length of 1.
 
 Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
 */
import Foundation
class LongestSubstringWithoutRepeatingCharacters {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        /* 
         算法分析：
         时间复杂度：
         最差O(n+m) n为输入字符串长度，m为出现重复字母时候的最长子字符串长度
         最好O(n) n为输入字符串长度
         空间复杂度:
         最坏O(2*n)
         最好O(1)
         */
        
        print("字符串长度是：\(s.characters.count)");
        var count = 0
        var countTwo = 0
        var currSubString = ""
        var longestSubString = ""
        for c in s.characters {
            if currSubString.contains("\(c)") {
                //_________
                //删除有c前包含c的string
                for _ in 0..<currSubString.characters.count {
                    if currSubString.substring(to: currSubString.index(after: currSubString.startIndex)) == "\(c)" {
                        currSubString.remove(at: currSubString.startIndex)
                        count += 1
                        countTwo += 1
                        break
                    }
                    else {
                        currSubString.remove(at: currSubString.startIndex)
                        count += 1
                        countTwo += 1
                    }
                    
                    
                }
                //_________
                currSubString += "\(c)"
            } else {
                currSubString += "\(c)"
                if currSubString.characters.count > longestSubString.characters.count {
                    longestSubString = currSubString
                }
            }
            count += 1
        }
        print("代码运行行数：\(count)")
        print("删除行数时候：\(countTwo)")
        return longestSubString.characters.count
    }
}
