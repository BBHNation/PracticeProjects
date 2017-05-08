//
//  Properties.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/4/26.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import Foundation
/// 属性
class Properties {
    /// 目录和概况
    func basic() {
        /*
         • 存储属性 (页 0)
         • 计算属性 (页 0)
         • 属性观察器 (页 0)
         • 全局变量和局部变量 (页 0) • 类型属性 (页 0)
         */
        
        
        /*
         属性将值跟特定的类、结构或枚举关联。存储属性存储常量或变量作为实例的一部分，而计算属性计算(不是存
         储)一个值。计算属性可以用于类、结构体和枚举，存储属性只能用于类和结构体。
         存储属性和计算属性通常与特定类型的实例关联。但是，属性也可以直接作用于类型本身，这种属性称为类型属
         性。
         另外，还可以定义属性观察器来监控属性值的变化，以此来触发一个自定义的操作。属性观察器可以添加到自己
         定义的存储属性上，也可以添加到从父类继承的属性上。
         */
    }
    
    /// 存储属性 在类和结构体中可以使用
    func saveProperty() {
        struct FixedLengthRange {
            var firstValue: Int
            let length: Int
        }
        var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3) // 该区间表示整数0，1，2
        rangeOfThreeItems.firstValue = 6
        // 该区间现在表示整数6，7，8
        
        /*这种行为是由于结构体(struct)属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常 量。
         属于引用类型的类(class)则不一样。把一个引用类型的实例赋给一个常量后，仍然可以修改该实例的变量属 性。*/
        
        
        /*延迟存储属性*/
        // 延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延迟存 储属性。
        
        class DataImporter {
            /*
             DataImporter 是一个负责将外部文件中的数据导入的类。 这个类的初始化会消耗不少时间。
             */
            var fileName = "data.txt"
            // 这里会提供数据导入功能 }
        }
        class DataManager {
            lazy var importer = DataImporter()
            var data = [String]()
            // 这里会提供数据管理功能
        }
        // DataImporter 实例的 importer 属性还没有被创建
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")
        
        print(manager.importer.fileName)
        
        // DataImporter 实例的 importer 属性现在被创建了 // 输出 "data.txt”
    }
    
    /// 计算属性 可以在类，结构体和枚举中使用
    func caculateProperty() {
        /*
         除存储属性外，类、结构体和枚举可以定义计算属性。计算属性不直接存储值，而是提供一个 getter 和一个可 选的 setter，来间接获取和设置其他属性或变量的值。
         */
        struct Point {
            var x = 0.0, y = 0.0
        }
        struct Size {
            var width = 0.0, height = 0.0
        }
        struct Rect {
            var origin = Point()
            var size = Size()
            var center: Point {
                get {
                    let centerX = origin.x + (size.width / 2)
                    let centerY = origin.y + (size.height / 2)
                    return Point(x: centerX, y: centerY)
                }
                set(newCenter) {
                    origin.x = newCenter.x - (size.width / 2)
                    origin.y = newCenter.y - (size.height / 2)
                }
            } }
        var square = Rect(origin: Point(x: 0.0, y: 0.0),
                          size: Size(width: 10.0, height: 10.0))
        let initialSquareCenter = square.center
        print(initialSquareCenter)
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))") // 打印 "square.origin is now at (10.0, 10.0)”
        
        
        
        
        /*简化 setter 声明*/
        struct AlternativeRect {
            var origin = Point()
            var size = Size()
            var center: Point {
                get {
                    let centerX = origin.x + (size.width / 2)
                    let centerY = origin.y + (size.height / 2)
                    return Point(x: centerX, y: centerY)
                }
                set {
                    origin.x = newValue.x - (size.width / 2)
                    origin.y = newValue.y - (size.height / 2)
                }
            }
        }
        // 只有 getter 没有 setter 的计算属性就是只读计算属性。只读计算属性总是返回一个值，可以通过点运算符访 问，但不能设置新的值。
        
        // 注意必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let 关键字只用来声明 常量属性，表示初始化后再也无法修改的值。
        
        // 只读计算属性的声明可以去掉 get 关键字和花括号:
        struct Cuboid {
            var width = 0.0, height = 0.0, depth = 0.0
            var volume: Double {
                return width * height * depth
            }
        }
    }
    
    /// 属性观察器
    func ovserveProperty() {
        /*
         可以为属性添加如下的一个或全部观察器:
         • 在新的值被设置之前调用
         • 在新的值被设置之后立即调用
         */
        /*
         注意
         父类的属性在子类的构造器中被赋值时，它在父类中的willSet和didSet观察器会被调用，随后才会调用子类的观察器。在父类的初始化方法调用之前，子类给属性赋值时候，观察器不会被调用
         */
        
        class StepCounter {
            var totalSteps: Int = 0 {
                willSet(newTotalSteps) {
                    print("About to set totalSteps to \(newTotalSteps)")
                }
                didSet {
                    if totalSteps > oldValue  {
                        print("Added \(totalSteps - oldValue) steps")
                    } }
            } }
        let stepCounter = StepCounter()
        stepCounter.totalSteps = 200
        // About to set totalSteps to 200
        // Added 200 steps
        stepCounter.totalSteps = 360
        // About to set totalSteps to 360
        // Added 160 steps
        stepCounter.totalSteps = 896
        // About to set totalSteps to 896
        // Added 536 steps
    }
    
    /// 类型属性（类属性）
    func propertyType() {
        /*全局变量和局部变量*/
        /*
         计算属性和属性观察器所描述的功能也可以用于全局变量和局部变量。全局变量是在函数、方法、闭包或任何类型之外定义的变量。局部变量是在函数、方法或闭包内部定义的变量。
         */
        /*
         注意
         全局的常量或变量都是延迟计算的，跟延迟存储属性 (页 0)相似，不同的地方在于，全局的常量或变量不需要 标记 lazy 修饰符。
         局部范围的常量或变量从不延迟计算。
         */
        // 使用关键字 static 来定义类型属性。
        var _ : String = "good"
        
        struct SomeStructure {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 1 }
        }
        enum SomeEnumeration {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 6 }
        }
        class SomeClass {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 27 }
            class var overrideableComputedTypeProperty: Int {
                return 107
            } }
    }
}


/// 方法
class Functions {
    /// 结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一。
    
    /// 实例方法
    func instanceFunc() {
        // 类型的每一个实例都有一个隐含属性叫做 self ， self 完全等同于该实例本身。你可以在一个实例的实例方法中 使用这个隐含的 self 属性来引用当前实例。
        
        /*在实例方法中修改值类型*/
        // 结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。
        struct Point {
            var x = 0.0, y = 0.0
            mutating func moveByX(deltaX: Double, y deltaY: Double) {
                x += deltaX
                y += deltaY }
        }
        var somePoint = Point(x: 1.0, y: 1.0)
        somePoint.moveByX(deltaX: 2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))") // 打印 "The point is now at (3.0, 4.0)"
        
        /*在可变方法中给 self 赋值*/
        struct newPoint {
            var x = 0.0, y = 0.0
            mutating func moveBy(x deltaX: Double, y deltaY: Double) {
                self = newPoint(x: x + deltaX, y: y + deltaY)
                }
        }
        
        /*枚举的可变方法可以把 self 设置为同一枚举类型中不同的成员:*/
        enum TriStateSwitch {
            case Off, Low, High
            mutating func next() {
                switch self {
                case .Off:
                    self = .Low
                case .Low:
                    self = .High
                case .High:
                    self = .Off }
            } }
        var ovenLight = TriStateSwitch.Low
        ovenLight.next()
        // ovenLight 现在等于 .High ovenLight.next()
        // ovenLight 现在等于 .Off
        
    }
    
    /// 类型方法
    func classFunc() {
        // 在方法的 func 关键字之前加上关键字 static ，来指定类型方法。类还可以用关键字 class 来允许子类重写 父类的方法实现。
        // 注意在 Objective-C 中，你只能为 Objective-C 的类类型(classes)定义类型方法(type-level methods)。在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。每一个类型方法都被它所支持的类型显式包含。
        
        class SomeClass {
            class func someTypeMethod() {
                // 在这里实现类型方法 }
                // 允许子类重写实现
            }
            static func typeMethod() {
                // 不允许子类重写实现
            }
        }
        SomeClass.someTypeMethod()
        SomeClass.typeMethod()

    }
}
