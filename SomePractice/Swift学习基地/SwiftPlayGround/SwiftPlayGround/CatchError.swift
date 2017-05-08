//
//  CatchError.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/4/27.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
// 这里是错误处理
import Foundation

class CatchError {
    // 表示并抛出错误
    enum VendingMachineError : Error {
        case invalidSelection //选择无效 
        case insufficientFunds(coinsNeeded: Int) //金额不足,这里使用了枚举的关联值
        case outOfStock //缺货
    }
    // 注意
    // Swift 中的错误处理和其他语言中用 try ， catch 和 throw 进行异常处理很像。和其他语言中(包括 Objectiv e-C )的异常处理不同的是，Swift 中的错误处理并不涉及解除调用栈，这是一个计算代价高昂的过程。就此而 言， throw 语句的性能特性是可以和 return 语句相媲美的。
    
    func buySomeThing(give : Int) throws -> Int{
        if give<8 {
            throw VendingMachineError.insufficientFunds(coinsNeeded: 8-give)
        }
        return give - 8
    }
    
    struct Item {
        var price: Int
        var count: Int
    }
    
    class VendingMachine {
        var inventory = [
            "Candy Bar": Item(price: 12, count: 7),
            "Chips": Item(price: 10, count: 4),
            "Pretzels": Item(price: 7, count: 11)
        ]
        var coinsDeposited = 0
        func dispenseSnack(snack: String) {
            print("Dispensing \(snack)")
        }
        func vend(itemNamed name: String) throws {
            guard let item = inventory[name] else {
                throw VendingMachineError.invalidSelection
            }
            guard item.count > 0 else {
                throw VendingMachineError.outOfStock
            }
            guard item.price <= coinsDeposited else {
                throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
            }
            coinsDeposited -= item.price
            var newItem = item
            newItem.count -= 1
            inventory[name] = newItem
            print("Dispensing \(name)")
        }
    }
    
    func main() {
        // 这里是一个抛出错误并处理的过程
        do {
            let k = try buySomeThing(give: 5)
            print(k)
        } catch VendingMachineError.insufficientFunds(coinsNeeded: let few) {
            print(few)
        } catch {
            print("error")
        }
        
        
        // 可以使用 try? 通过将错误转换成一个可选值来处理错误。如果在评估 try? 表达式时一个错误被抛出，那么表达 式的值就是 nil 。
        
        // 有时你知道某个   函数实际上在运行时是不会抛出错误的，在这种情况下，你可以在表达式前面写 来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言中。如果真的抛出了错误，你会得到一个运行时错误。
        
        
        
        // 可以使用 defer 语句在即将离开当前代码块时执行一系列语句。
        // 第一条 defer 语句中的代码会在第二条 defer 语句中的 代码被执行之后才执行，以此类推。
        
        defer {
            print("hello")
        }
        
        defer {
            print("\nseconde\n")
        }
        
    }
    
    
}
