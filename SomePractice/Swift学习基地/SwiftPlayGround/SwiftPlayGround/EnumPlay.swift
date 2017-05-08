//
//  EnumPlay.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/4/24.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

/// 这里是Enum的练习和学习

import Foundation

class EnumPlay {
    
    // 使用Enum来表示错误信息，可以在其中新建函数
    enum PrinterError : Error {
        case OutOfPaper
        case NoToner
        case OnFire
    }
    
    func send(job: Int, toPrinter printerName: String) throws -> String {
        defer {
            // 这里可以写函数最后执行的代码
            // 会在函数最后调用
            print("send")
        }
        print("this is Send")
        if printerName == "Never Has Toner" {
            // 抛出错误
            throw PrinterError.NoToner
        }
        else if printerName == "hello" {
            throw PrinterError.OnFire
        }
        else if printerName == "good" {
            throw PrinterError.OutOfPaper
        }
        return "Job sent"
    }
    
    func enumPlayMain() {
        do {
            // 使用Do Catch函数块来截获Error
            let printerResponse = try send(job: 12, toPrinter: "hello")
            print(printerResponse)
        } catch PrinterError.OnFire {
            print("On fire")
        } catch PrinterError.OutOfPaper {
            print("Out of paper")
        } catch PrinterError.NoToner {
            print("No toner")
        } catch {
            print("hi")
        }
        
        
        // 使用Try？来使得抛出Error时候结果为nil
        let hi = try? send(job: 12, toPrinter: "good")
        print(hi ?? "It's nil")
    }
    
    /*________________________________________________________*/
    
    /// 基础概况
    func basic() {
        /*在 Swift 中，枚举类型是一等(first-class)类型。它们采用了很多在传统上只被类(class)所支持的特 性，
         例如计算属性(computed properties)，用于提供枚举值的附加信息，
         实例方法(instance methods)，用 于提供和枚举值相关联的功能。
         枚举也可以定义构造函数(initializers)来提供一个初始值;
         可以在原始实现 的基础上扩展它们的功能;
         还可以遵循协议(protocols)来提供标准的功能。*/
    }
    
    enum CompassPoint {
        case north
        case south
        case east
        case west
    }
    

    /// 枚举语法
    func expresion() {
                /*注意
         与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的
         nt 例子中， north ， south ， east 和 west 不会被隐式地赋值为 0 ， 1 ， 2 和 3 。相反，这些枚举成员本身 就是完备的值，这些值的类型是已经明确定义好的 CompassPoint 类型。*/
        let k : CompassPoint = .north
        print(k)
    }
    
    /// 使用 Switch 语句匹配枚举值
    func useSwitch(directionToHead : CompassPoint) {
        
        switch directionToHead {
        case .north:
            print("Lots of planets have a north")
        case .south:
            print("Watch out for penguins")
        case .east:
            print("Where the sun rises")
        case .west:
            print("Where the skies are blue")
        }
        // 打印 "Watch out for penguins”
    }
    
    /// 关联值
    func relationValue() {
        /*上一小节的例子演示了如何定义和分类枚举的成员。你可以为 Planet.earth 设置一个常量或者变量，并在赋值之 后查看这个值。然而，有时候能够把其他类型的关联值和成员值一起存储起来会很有用。这能让你连同成员值一 起存储额外的自定义信息，并且你每次在代码中使用该枚举成员时，还可以修改这个关联值。*/
        
        /*例如，假设一个库存跟踪系统需要利用两种不同类型的条形码来跟踪商品。有些商品上标有使用 0 到 9 的数字的 UPC 格式的一维条形码。每一个条形码都有一个代表“数字系统”的数字，该数字后接五位代表“厂商代码”的 数字，接下来是五位代表“产品代码”的数字。最后一个数字是“检查”位，用来验证代码是否被正确扫描:
         其他商品上标有 QR 码格式的二维码，它可以使用任何 ISO 8859-1 字符，并且可以编码一个最多拥有 2,953 个 字符的字符串:
         这便于库存跟踪系统用包含四个整型值的元组存储 UPC 码，以及用任意长度的字符串储存 QR 码。 在 Swift 中，使用如下方式定义表示两种商品条形码的枚举:*/
        enum Barcode {
            case upc(Int, Int, Int, Int)
            case qrCode(String)
        }
        // “定义一个名为 Barcode 的枚举类型，它的一个成员值是具有 (Int，Int，Int，Int) 类型关联值的 upc ，另一个
        // 成员值是具有 String 类型关联值的 qrCode 。”
        
        var productBarcode : Barcode = Barcode.upc(8, 85909, 51225, 3)
        print(productBarcode)
        productBarcode = .qrCode("helloWorld")
        
        switch productBarcode {
        case .upc(let numberSystem, let manufacturer, let product, let check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .qrCode(let productCode):
            print("QR code: \(productCode).")
        }
        // 打印 "QR code: ABCDEFGHIJKLMNOP."
        
        
        /*如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注 一个let或者var:*/
        switch productBarcode {
        case let .upc(numberSystem, manufacturer, product, check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case let .qrCode(productCode):
            print("QR code: \(productCode).")
        }
        // 输出 "QR code: ABCDEFGHIJKLMNOP."
        
    }
    
    /// 原始值
    func originalValue() {
        /*作为关联值的替代选 择，枚举成员可以被默认值(称为原始值)预填充，这些原始值的类型必须相同。*/
        enum ASCIIControlCharacter: Character {
            case tab = "\t"
            case lineFeed = "\n"
            case carriageReturn = "\r"
        }
        /*注意
         原始值和关联值是不同的。原始值是在定义枚举时被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚
         
         第 2 章 Swift 教程 | 144
         举成员，它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值
         可以变化。*/
        
        /*原始值的隐式赋值*/
        /*在使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为 你赋值。
         例如，当使用整数作为原始值时，隐式赋值的值依次递增 1 。如果第一个枚举成员没有设置原始值，其原始值将 为0。*/
        enum Planet: Int {
            case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
        }
        
        enum CompassPoint: String {
            case north, south, east, west
        }
        /*上面例子中， CompassPoint.south 拥有隐式原始值 south ，依次类推。 
         使用枚举成员的 rawValue 属性可以访问该枚举成员的原始值:*/
        let earthsOrder = Planet.earth.rawValue // earthsOrder 值为 3
        let sunsetDirection = CompassPoint.west.rawValue // sunsetDirection 值为 "west"
        print(earthsOrder)
        print(sunsetDirection)
        
        /*使用原始值初始化枚举实例*/
        /*如果在定义枚举类型的时候使用了原始值，那么将会自动获得一个初始化方法，这个方法接收一个叫做 的参数，参数类型即为原始值类型，返回值则是枚举成员或 nil 。你可以使用这个初始化方法来创建一个新的枚 举实例。*/
        let possiblePlanet = Planet(rawValue: 7)
        print(possiblePlanet ?? "nil")
        // possiblePlanet 类型为 Planet? 值为 Planet.uranus
    }
    
    /// 递归枚举
    func recursion() {
        /*递归枚举是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译
        器会插入一个间接层。你可以在枚举成员前加上 indirect 来表示该成员可递归。*/
        enum ArithmeticExpression {
            case number(Int)
            indirect case addition(ArithmeticExpression, ArithmeticExpression)
            indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
        }
        
        /*你也可以在枚举类型开头加上 indirect 关键字来表明它的所有成员都是可递归的:*/
        indirect enum ArithmeticExpression1 {
            case number(Int)
            case addition(ArithmeticExpression1, ArithmeticExpression1)
            case multiplication(ArithmeticExpression1, ArithmeticExpression1)
        }
        
        let five = ArithmeticExpression.number(5)
        let four = ArithmeticExpression.number(4)
        let sum = ArithmeticExpression.addition(five, four)
        let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
        print(product)
        
        
        func evaluate(_ expression: ArithmeticExpression) -> Int {
            switch expression {
            case let .number(value):
                return value
            case let .addition(left, right):
                return evaluate(left) + evaluate(right)
            case let .multiplication(left, right):
                return evaluate(left) * evaluate(right)
            }
        }
        print(evaluate(product))
    }
}

