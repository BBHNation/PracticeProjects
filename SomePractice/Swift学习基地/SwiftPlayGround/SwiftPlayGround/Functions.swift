//
//  Functions.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/4/26.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/// 函数
import Foundation
class Functionss {
    /*
     如果函数返回的元组类型有可能整个元组都“没有值”，你可以使用可选的( optional ) 元组返回类型反映 整个元组可以是 nil 的事实。你可以通过在元组类型的右括号后放置一个问号来定义一个可选元组，例如 Int)? 或 (String, Int, Bool)?
     */
    /*
     注意 可选元组类型如 (Int, Int)? 与元组包含可选类型如 (Int?, Int?) 是不同的.可选的元组类型，整个 元组是可选的，而不只是元组中的每个元素值。
     */
    func minMax(array: [Int]) -> (min: Int, max: Int)? {
        if array.isEmpty { return nil }
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    
    /*
     每个函数参数都有一个参数标签( argument label )以及一个参数名称( parameter name )。参数标签在调用函 数的时候使用;调用的时候需要将函数的参数标签写在对应的参数前面。参数名称在函数的实现中使用。默认情 况下，函数参数使用参数名称来作为它们的参数标签。
     */
    
    
    /*默认参数值*/
    /*
     你可以在函数体中通过给参数赋值来为任意一个参数定义默认值(Deafult Value)。当默认值被定义后，调用这 个函数时可以忽略这个参数。
     */
    func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
        // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
        someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault = 6
        someFunction(parameterWithoutDefault: 4) // parameterWithDefault = 12
    }
    
    /*可变参数*/
    /*
     一个可变参数(variadic parameter)可以接受零个或多个值。
     */
    func canChange() {
        func arithmeticMean(_ numbers: Double...) -> Double {
            var total: Double = 0
            for number in numbers {
                total += number
            }
            return total / Double(numbers.count)
        }
        print(arithmeticMean(1, 2, 3, 4, 5))
        // 返回 3.0, 是这 5 个数的平均数。 arithmeticMean(3, 8.25, 18.75)
        // 返回 10.0, 是这 3 个数的平均数。
        // 注意:
        // 一个函数最多只能拥有一个可变参数。
    }
    
    /*输出输入参数inout*/
    /*通过输入输出参数，函数可以修改外部传进来的参数，相当于传入的不是值而是对原参数的引用，所以调用时候参数要加上&*/
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    func main() {
        var i = 3,j = 4
        swapTwoInts(&i, &j);
        var k : (Int, Int) -> Void?
        func hi(a : Int, b : Int) {
            
        }
        k = hi(a:b:)
    }
    
    
    /*函数类型*/
    /*每个函数都有种特定的函数类型，函数的类型由函数的参数类型和返回类型组成。*/
    // (Int, Int) -> Int
    // () -> Void
    // 函数作为一类成员，可以作为返回值和参数，

    
    /*嵌套函数*/
    /*函数式编程*/
    func hello(k : (Int)->Int) -> (Int)->Bool {
        func newResult(hi : Int) -> Bool {
            if hi < 8 {
                return false
            }else {
                return true
            }
        }
        
        if k(8) > 2 {
            return newResult(hi:)
        }
        else {
            return newResult(hi:)
        }
        
    }
    
}
