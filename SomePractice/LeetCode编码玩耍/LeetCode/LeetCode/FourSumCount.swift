//
//  FourSumCount.swift
//  LeetCode
//
//  Created by Hancock on 2017/5/14.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import Foundation
class FourSumCount {
    // y = x^2
    func y(_ x: Int) -> Int {
        return x*x
    }
    
    
    func fourSumCount(_ A: [Int], _ B: [Int], _ C: [Int], _ D: [Int]) -> Int {
        var count = 0
        for i in A {
            for j in B {
                for k in C {
                    for l in D {
                        if i+j+k+l == 0 {
                            count += 1
                        }
                    }
                }
            }
        }
        return count
    }
    
    func fourSumCountII(_ A: [Int], _ B: [Int], _ C: [Int], _ D: [Int]) -> Int {
        var count = 0
        var res = 0
        for i in A {
            for j in B {
                res = i+j
            }
        }
        
        
        for k in C {
            for l in D {
                res = res-k-l
                if res == 0 {
                    count += 1
                }
            }
        }
        
        return count
    }
    
    func main() {
        let A = [ 1, 2]
        let B = [-2,-1]
        let C = [-1, 2]
        let D = [ 0, 2]
        print(fourSumCountII(A, B, C, D))
    }
}
