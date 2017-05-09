//
//  AdvancedOperator.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/5/9.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
// 高级运算符
import Foundation
class advancedOperator {
    /**
     • 位运算符 (页 0)
     • 溢出运算符 (页 0)
     • 优先级和结合性 (页 0) • 运算符函数 (页 0)
     • 自定义运算符 (页 0)
     */
    
    /**
     与 C 语言中的算术运算符不同，Swift 中的算术运算符默认是不会溢出的。所有溢出行为都会被捕获并报告为错 误。如果想让系统允许溢出行为，可以选择使用 Swift 中另一套默认支持溢出的运算符，比如溢出加法运算 符(&+)。所有的这些溢出运算符都是以 & 开头的。
     */
    
    func bitOperator() {
        //按位取反
        let initialBits: UInt8 = 0b00001111
        let invertedBits = ~initialBits // 等于 0b11110000
        print(invertedBits)
        
        //按位与 1&1 = 1 1&0 = 0 0&0 = 0
        let firstSixBits: UInt8 = 0b11111100
        let lastSixBits: UInt8 = 0b00111111
        let middleFourBits = firstSixBits & lastSixBits // 等于 00111100
        print(middleFourBits)
        
        //按位或 1|1 = 1 1|0 = 1 0|0 = 0
        let someBits: UInt8 = 0b10110010
        let moreBits: UInt8 = 0b01011110
        let combinedbits = someBits | moreBits // 等于 11111110
        print(combinedbits)
        
        //按位异或 1^1 = 0 1^0 = 1 0^0 = 0
        let firstBits: UInt8 = 0b00010100
        let otherBits: UInt8 = 0b00000101
        let outputBits = firstBits ^ otherBits // 等于 00010001
        print(outputBits)
        
        //移位
        
        // 无符号数的移位
        // 1. 已经存在的位按指定的位数进行左移和右移。
        // 2. 任何因移动而超出整型存储范围的位都会被丢弃。 
        // 3. 用 0 来填充移位后产生的空白位。（逻辑移位）
        let shiftBits:UInt8 = 4 // 即二进制的 00000100
        shiftBits << 1 // 00001000
        shiftBits << 2 // 00010000
        shiftBits << 5 // 10000000
        shiftBits << 6 // 00000000
        shiftBits >> 2 // 00000001
        
        // 有符号数的移位
        // 有符号整数使用第 1 个比特位(通常被称为符号位)来表示这个数的正负。符号位为 0 代表正数，为 1 代 表负数。
        // 其余的比特位(通常被称为数值位)存储了实际的值。
        // 负数的表示通常被称为二进制补码表示。用这种方法来表示负数乍看起来有点奇怪，但它有几个优点。
        // 首先，如果想对 -1 和 -4 进行加法运算，我们只需要将这两个数的全部 8 个比特位进行相加，并且将计算 结果中超出 8 位的数值丢弃:
        // 其次，使用二进制补码可以使负数的按位左移和右移运算得到跟正数同样的效果，即每向左移一位就将自身的数 值乘以 2，每向右一位就将自身的数值除以 2。
        // 当对整数进行按位右移运算时，遵循与无符号整数相同的规则，但是对于移位产生的空白位使用符号位进行 填充，而不是用 0 。(算数移位)
    }
    
    func overFlowOperation() {
        //Swift 提供的三个溢出运算符来
        //让系统支持整数溢出运算。这些运算符都是以 & 开头的:
        /*
        • 溢出加法 &+
        • 溢出减法 &-
        • 溢出乘法 &*
         */
        var unsignedOverflow = UInt8.max
        // unsignedOverflow 等于 UInt8 所能容纳的最大整数 255
        unsignedOverflow = unsignedOverflow &+ 1
        // 此时 unsignedOverflow 等于 0
        
        unsignedOverflow = UInt8.min
        // unsignedOverflow 等于 UInt8 所能容纳的最小整数 0 
        unsignedOverflow = unsignedOverflow &- 1
        // 此时 unsignedOverflow 等于 255
        
        // 对于无符号与有符号整型数值来说，当出现上溢时，它们会从数值所能容纳的最大数变成最小的数。同样地，当
        // 发生下溢时，它们会从所能容纳的最小数变成最大的数。
    }
    
    func reWriteOperation() {
        
        var a : Vector2D = Vector2D(x: 1, y: 2)
        let b : Vector2D = Vector2D(x: 3, y: 4)
        _ = a + b
        _ = -a
        a++
    }
    
    // 当定义前缀与后缀运算符的时候，我们并没有指定优先级。然而，如果对同一个值同时使用前缀与后缀运算符，则后缀运算符会先参与运算。
    
    
}
struct Vector2D {
    var x = 0.0, y = 0.0
}

//运算符的重载
extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    //要实现前缀或者后缀运算符，需要在声明运算符函数的时候在 func 关键字之前指定 prefix 或者 postfix 修饰符:
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
    static postfix func ++ (vector: inout Vector2D) {
        vector = Vector2D(x: vector.x+1, y: vector.y+1)
    }
}
