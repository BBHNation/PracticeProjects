//
//  Extensions.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/5/2.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/// 扩展
import Foundation
class Extension {
    /*
     Swift 中的扩展可以:
     • 添加计算型属性和计算型类型属性 
     • 定义实例方法和类型方法
     • 提供新的构造器
     • 定义下标
     • 定义和使用新的嵌套类型
     • 使一个已有类型符合某个协议
     */
    func main() {
        var k = hi.init(k: 2, arr: [2,3,4,5,6,9])
        print(k.instanceNum)
        print(hi.typeNum)
        
        k.instanceFunc()
        hi.typeIIIFunc()
        k = hi.init(k: 3, arr: [])
        print(k)
        
        
    }
}

class hi  {
    var k : Int
    var array : Array<Any>
    init(k : Int, arr : Array<Any>) {
        self.k = k
        self.array = arr
    }
}

protocol helloProtocol {
    func hello()
}

extension Int {
    mutating func square() {
        self = self * self
    }
    
    // 定义下标
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

extension hi : helloProtocol{
    
    func hello() {
        print("hello good")
    }

    // 添加计算型属性和计算型类型属性
    var instanceNum : Double {
        get {
            return 3.5
        }
        set {
            self.k = Int(newValue)
        }
    }
    
    static var typeNum : Double {
        return 5
    }
    
    // 添加实例方法和类型方法
    func instanceFunc() {
        print("instanceFunc")
    }
    
    static func typeIIIFunc() {
        print("typeFunc")
    }
    
    
    
    // 提供新的构造器
    // 扩展能为类添加新的便利构造器，但是它们不能为类添加新的指定构造器或析构器。指定构造器和析构器必须总是由原始的类实现来提供。
    convenience init(newNum : Int, arr : Array<Any>) {
        self.init(k: newNum, arr: arr)
    }

}
