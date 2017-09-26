//
//  Letter Combinations of a Phone Number.swift
//  LeetCode
//
//  Created by Hancock on 2017/9/24.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

/*
 * Given a digit string, return all possible letter combinations that the number could represent.
 * A mapping of digit to letters (just like on the telephone buttons) is given below.
 * Input:Digit string "23"
 * Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
 */

import Cocoa

class Letter_Combinations_of_a_Phone_Number: NSObject {
    
    // 此算法的时间复杂度是O(n2)
    
    static func letterCombinations(_ digits: String) -> [String] {
        var initStrings = [String]()
        let keyValue = [
            2 : ["a","b","c"],
            3 : ["d","e","f"],
            4 : ["g","h","i"],
            5 : ["j","k","l"],
            6 : ["m","n","o"],
            7 : ["p","q","r","s"],
            8 : ["t","u","v"],
            9 : ["w","x","y","z"]
                        ]
        
        var digitInts = digits.map { (c) -> Int in
            return Int(String.init(c))!
        }
        
        return recursionCombination(keyValue: keyValue,preStrings: &initStrings, digits: &digitInts)
    }
    
    static func recursionCombination(keyValue: [Int:[String]],
                                     preStrings: inout [String],
                                     digits: inout [Int]) -> [String] {
        if digits.count == 0 {
            return [String]()
        }
        let digit = digits.removeFirst()
        let values = keyValue[digit]
        
        var newStrings = [String]()
        if preStrings.count == 0 {
            for c in values! {
                newStrings.append(c)
            }
        } else {
            for s in preStrings {
                for c in values! {
                    newStrings.append(s+c)
                }
            }
        }
        
        if digits.count == 0 {
            return newStrings
        } else {
            return recursionCombination(keyValue: keyValue, preStrings: &newStrings,digits: &digits)
        }
    }
}
