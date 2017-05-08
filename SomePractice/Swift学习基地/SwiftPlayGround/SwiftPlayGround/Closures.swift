//
//  Closures.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/4/26.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/// 闭包
import Foundation

class Closures {
    
    /// 概况
    func basic() {
        /*闭包和函数都是引用类型*/
        /*闭包是自包含的函数代码块，可以在代码中被传递和使用。Swift 中的闭包与 C 和 Objective-C 中的代码块(b
         locks)以及其他一些编程语言中的匿名函数比较相似。
         闭包可以捕获和存储其所在上下文中任意常量和变量的引用。被称为包裹常量和变量。 Swift 会为你管理在捕获 过程中涉及到的所有内存操作。*/
        
        /*在函数章节中介绍的全局和嵌套函数实际上也是特殊的闭包，闭包采取如下三种形式之一:
         • 全局函数是一个有名字但不会捕获任何值的闭包
         • 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
         • 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包*/
        
        /*Swift 的闭包表达式拥有简洁的风格，并鼓励在常见场景中进行语法优化，主要优化如下:
         • 利用上下文推断参数和返回值类型
         • 隐式返回单表达式闭包，即单表达式闭包可以省略 return 关键字 • 参数名称缩写
         • 尾随闭包语法*/
    }
    
    /// 闭包表达式
    func expresion() {
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        /*sorted(by:) 方法接受一个闭包，该闭包函数需要传入与数组元素类型相同的两个值，并返回一个布尔类型值来 表明当排序结束后传入的第一个参数排在第二个参数前面还是后面。如果第一个参数值出现在第二个参数值前 面，排序闭包函数需要返回 true ，反之返回 false 。*/
        /*该例子对一个 String 类型的数组进行排序，因此排序闭包函数类型需为 (String, String) -> Bool 。
         提供排序闭包函数的一种方式是撰写一个符合其类型要求的普通函数，并将其作为 sorted(by:) 方法的参数传 入:*/
        func backward(_ s1: String, _ s2: String) -> Bool {
            return s1 > s2
        }
        
        var reverseNames = names.sorted(by: backward)
        print(reverseNames)
        reverseNames = names.sorted(by: { (s1, s2) -> Bool in
            return s1 > s2
        })
        
        
        /*闭包表达式语法*/
        /*
         闭包表达式语法有如下的一般形式:
         { (parameters) -> returnType in
         statements
         }
         */
        
        reverseNames = names.sorted(by: {s1, s2 in return s1 > s2})
        
        /*参数名称缩写*/
        /*Swift 自动为内联闭包提供了参数名称缩写功能，你可以直接通过 $0 ， $1 ， $2 来顺序调用闭包的参数，以 此类推。
         如果你在闭包表达式中使用参数名称缩写，你可以在闭包定义中省略参数列表，并且对应参数名称缩写的类型会 通过函数类型进行推断。 in 关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成:*/
        reverseNames = names.sorted(by: {$0 > $1})
        
        
        /*运算符方法*/
        /*实际上还有一种更简短的方式来编写上面例子中的闭包表达式。Swift 的 String 类型定义了关于大于 号(>)的字符串实现，其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。而这正好与
         sorted(by:) 方法的参数需要的函数类型相符合。因此，你可以简单地传递一个大于号，Swift 可以自动推断出 你想使用大于号的字符串函数实现:*/
        reverseNames = names.sorted(by: >)
        
    }
    
    /// 尾随闭包
    func follow() {
        func someFunctionThatTakesAClosure(closure: () -> Void) {
            // 函数体部分
        }
        // 以下是不使用尾随闭包进行函数调用 
        someFunctionThatTakesAClosure(closure: {
        // 闭包主体部分 
        })
        // 以下是使用尾随闭包进行函数调用 
        someFunctionThatTakesAClosure() {
        // 闭包主体部分 
        }
        
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        
        let strings = numbers.map {
            (number) -> String in
            var number = number
            var output = ""
            repeat {
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0
            return output
        }
        print(strings)
        // strings 常量被推断为字符串类型数组，即 [String] // 其值为 ["OneSix", "FiveEight", "FiveOneZero"]
    }
    
    /// 值捕获
    func getValue() {
        /*闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍然可
         以在闭包函数体内引用和修改这些值。*/
        func makeIncrementer(forIncrement amount: Int) -> () -> Int {
            var runningTotal = 0
            func incrementer() -> Int {
                runningTotal += amount
                return runningTotal
            }
            return incrementer
        }
        
        let k = makeIncrementer(forIncrement: 7)
        print(k())
        
        /*闭包是引用类型*/
        /*这是因为函数和闭包都是引用类型。*/
        
    }
    
    /// 逃逸闭包
    func escape() {
        /*当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。*/
        /*一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中。举个例子，很多启动异 步操作的函数接受一个闭包参数作为 completion handler。这类函数会在异步操作开始之后立刻返回，但是闭包 直到异步操作结束后才会被调用。在这种情况下，闭包需要“逃逸”出函数，因为闭包需要在函数返回之后被调 用。例如:*/
        var completionHandlers: [() -> Void] = []
        func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
            completionHandlers.append(completionHandler)
        }
        
        /*将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self 。比如说，在下面的代码中，传递到 s omeFunctionWithEscapingClosure(_:) 中的闭包是一个逃逸闭包，这意味着它需要显式地引用 self 。*/
    }
    
    /// 自动闭包
    func auto() {
        /*自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。*/
        
        /*自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。延迟求值对于那些有副作用(Side Effect)和高计算成本的代码来说是很有益处的，因为它使得你能控制代码的执行时机。下面的代码展示了闭包 如何延时求值。*/
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)
        // 打印出 "5"
        let customerProvider = { customersInLine.remove(at: 0) }
        print(customersInLine.count)
        // 打印出 "5"
        print("Now serving \(customerProvider())!") // Prints "Now serving Chris!" 
        print(customersInLine.count)
        // 打印出 "4"
        
        
        /*将闭包作为参数传递给函数时，你能获得同样的延时求值行为。*/
        // customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
        func serve(customer customerProvider: () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serve(customer: { customersInLine.remove(at: 0) } ) // 打印出 "Now serving Alex!"
        /*上面的 serve(customer:) 函数接受一个返回顾客名字的显式的闭包。下面这个版本的 serve(customer:) 完成 了相同的操作，不过它并没有接受一个显式的闭包，而是通过将参数标记为 @autoclosure 来接收一个自动闭 包。现在你可以将该函数当作接受 String 类型参数(而非闭包)的函数来调用。customerProvider 参数将自 动转化为一个闭包，因为该参数被标记了 @autoclosure 特性。*/
        // customersInLine is ["Ewa", "Barry", "Daniella"]
        func serve1(customer customerProvider: @autoclosure () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serve1(customer: customersInLine.remove(at: 0)) // 打印 "Now serving Ewa!"
    }
}
