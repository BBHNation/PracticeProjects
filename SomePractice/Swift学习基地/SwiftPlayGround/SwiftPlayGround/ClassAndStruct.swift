//
//  ClassAndStruct.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/4/26.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import Foundation
/// 类和结构体
class ClassAndStruct {
    
    /// 类和结构体的对比
    func theDeffer() {
        /*
         Swift 中类和结构体有很多共同点。共同处在于:
         • 定义属性用于存储值
         • 定义方法用于提供功能
         • 定义下标操作使得可以通过下标语法来访问实例所包含的值
         • 定义构造器用于生成初始化值
         • 通过扩展以增加默认实现的功能 
         • 实现协议以提供某种标准功能
         */
        
        /*
         与结构体相比，类还有如下的附加功能:
         • 继承允许一个类继承另一个类的特征
         • 类型转换允许在运行时检查和解释一个类实例的类型 
         • 析构器允许一个类实例释放任何其所被分配的资源
         • 引用计数允许对一个类的多次引用
         */
    }
    
    /// 基础
    func basic() {
        /*定义*/
        struct Resolution {
            var width = 0
            var height = 0
        }
        class VideoMode {
            var resolution = Resolution()
            var interlaced = false
            var frameRate = 0.0
            var name: String?
        }
        
        let someResolution = Resolution()
        let someVideoMode = VideoMode()
        
        print("The width of someResolution is \(someResolution.width)") // 打印 "The width of someResolution is 0"
        print("The width of someVideoMode is \(someVideoMode.resolution.width)") // 打印 "The width of someVideoMode is 0"
        someVideoMode.resolution.width = 1280
        print("The width of someVideoMode is now \(someVideoMode.resolution.width)") // 打印 "The width of someVideoMode is now 1280"
        var vga = Resolution(width:640, height: 480)
        vga.width = 100
        
        
        /*结构体和枚举是值类型*/
        //值类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
        // 实际上，在 Swift 中，所有的基本类型:整数(Integer)、浮 点数(floating-point)、布尔值(Boolean)、字符串(string)、数组(array)和字典(dictionary)，都是 值类型，并且在底层都是以结构体的形式所实现。
        
        /*类是引用类型*/
        // 与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，引用的是已存在的实例本身而不是其拷贝。
        
        
        /*恒等表达式*/
        /*
         等价于 ===
         不等价于 !==
         */
        // 运用这两个运算符检测两个常量或者变量是否引用同一个实例:
        let k = VideoMode()
        let j = k
        print(j===k)//true
        let m = VideoMode()
        print(m===k)//false
        
        /*
        指针
        如果你有 C，C++ 或者 Objective-C 语言的经验，那么你也许会知道这些语言使用指针来引用内存中的地址。一 个引用某个引用类型实例的 Swift 常量或者变量，与 C 语言中的指针类似，但是并不直接指向某个内存地 址，也不要求你使用星号( * )来表明你在创建一个引用。Swift 中的这些引用与其它的常量或变量的定义方式 相同。
        */
        
        
        /*类和结构体的选择*/
        /*
         当符合一条或多条以下条件时，请考虑构建结构体:
         • 该数据结构的主要目的是用来封装少量相关简单数据值。
         • 有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。 
         • 该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用。
         • 该数据结构不需要去继承另一个既有类型的属性或者行为。
         */
        
        /*以下情境中适合使用结构体:
         • 几何形状的大小，封装一个 width 属性和 height 属性，两者均为 Double 类型。
         • 一定范围内的路径，封装一个 start 属性和 length 属性，两者均为 Int 类型。 
         • 三维坐标系内一点，封装 x ， y 和 z 属性，三者均为 Double 类型。
         */
        
        
        /*字符串、数组、字典类型的赋值和复制行为*/
        /*Swift 中，许多基本类型，诸如 String ， Array 和 Dictionary 类型均以结构体的形式实现。这意味着被赋值给 新的常量或变量，或者被传入函数或方法中时，它们的值会被拷贝。
         Objective-C 中 NSString ， NSArray 和 NSDictionary 类型均以类的形式实现，而并非结构体。它们在被赋值或 者被传入函数或方法时，不会发生值拷贝，而是传递现有实例的引用。*/
        /*
         注意 以上是对字符串、数组、字典的“拷贝”行为的描述。在你的代码中，拷贝行为看起来似乎总会发生。然而，Sw ift 在幕后只在绝对必要时才执行实际的拷贝。Swift 管理所有的值拷贝以确保性能最优化，所以你没必要去回 避赋值来保证性能最优化。
         */
    }
}
