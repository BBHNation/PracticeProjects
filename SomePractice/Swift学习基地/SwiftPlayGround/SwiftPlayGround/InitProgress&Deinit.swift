//
//  InitProgress.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/4/27.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/// 这里是Swift构造过程 和 析构过程
import Foundation

/// 构造过程
class InitProgress {
    
    /// 目录和主要内容
    func menuList() {
        /*
         • 存储属性的初始赋值 (页 0) 
         • 自定义构造过程 (页 0)
         • 默认构造器 (页 0)
         • 值类型的构造器代理 (页 0) 
         • 类的继承和构造过程 (页 0) 
         • 可失败构造器 (页 0)
         • 必要构造器 (页 0)
         • 通过闭包或函数设置属性的默认值 (页 0)
         */
        
        /*构造过程是使用类、结构体或枚举类型的实例之前的准备过程。*/
        /*与 Objective-C 中的构造器不同，Swift 的构造器无需返回值，它们的主要任务是保证新实例在第一次使用前完成正确的初始 化。*/
    }
    
    /// 一些基础知识
    func aboutInit() {
        /*_______________________*/
        //存储属性的初始化赋值
        /*
        注意
        当你为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观察
        者。
         */
        
        
        /*________________________*/
        //自定义构造过程
        /*
         构造器并不像函数和方法那样在括号前有一个可辨别的名字。因此在调用构造器时，主要通过构造器中的 参数名和类型来确定应该被调用的构造器。正因为参数如此重要，如果你在定义构造器时没有提供参数的外部名 字，Swift 会为构造器的每个参数自动生成一个跟内部名字相同的外部名。
         */
        
        /*
         不带外部名的构造器参数
         你可以使用下划线( _ )来显式描述它的外部名，以此重写上面 所说的默认行为。
         */
        
        
        /*可选属性类型*/
        /*如果你定制的类型包含一个逻辑上允许取值为空的存储型属性——无论是因为它无法在初始化时赋值，还是因为 它在之后某个时间点可以赋值为空——你都需要将它定义为 可选类型 。可选类型的属性将自动初始化为 nil ，表 示这个属性是有意在初始化时设置为空的。*/
        
        
        /*________________________*/
        /*默认构造器*/
        /*如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默 认构造器(default initializers)。这个默认构造器将简单地创建一个所有属性值都设置为默认值的实例。*/
        
        /*构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能减少多个构造器间
         的代码重复。*/
        
    }
    
    /// 类的继承和构造过程
    // 类的指定构造器的写法跟值类型简单构造器一样:
    
    init(parameters : String) {
        
    }
    
    // 便利构造器也采用相同样式的写法，但需要在 init 关键字之前放置 convenience 关键字，并使用空格将它们俩分 开:
    convenience init(parameters : Int) {
        self.init(parameters: "hi")
        // 你应当只在必要的时候为类提供便利构造器，比方说某种情况下通过使用便利构造器来快捷调用某个指定构造器，能够节省更多开发时间并让类的构造过程更清晰明了。
    }
    
    class childClass: InitProgress {
        override init(parameters: String) {
            super.init(parameters: parameters)
            // 重写父类构造器
        }
    }
    
    func aboutClassInit() {
        // 类的构造器代理规则

        /*
         规则 1 指定构造器必须调用其直接父类的的指定构造器。
         规则 2 便利构造器必须调用同类中定义的其它构造器。
         规则 3 便利构造器必须最终导致一个指定构造器被调用。
         */
        
        /*
         • 指定构造器必须总是向上代理 
         • 便利构造器必须总是横向代理
         */
        
        
        /*________________________________*/
        /*两段式构造过程*/
        /*注意
         Swift 的两段式构造过程跟 Objective-C 中的构造过程类似。最主要的区别在于阶段 1，Objective-C 给每一 个属性赋值 0 或空值(比如说 0 或 nil )。Swift 的构造流程则更加灵活，它允许你设置定制的初始值，并自 如应对某些属性不能以 0 或 nil 作为合法默认值的情况。*/
        
        
        /*子类在默认情况下不会继承父类的构造器。但是如果满足特定条件，父类构造器是可以被自动继承
         的。在实践中，这意味着对于许多常见场景你不必重写父类的构造器，并且可以在安全的情况下以最小的代价继
         承父类的构造器。*/
        
        /*
         假设你为子类中引入的所有新属性都提供了默认值，以下 2 个规则适用:
         规则 1 如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。
         规则 2 如果子类提供了所有父类指定构造器的实现——无论是通过规则 1 继承过来的，还是提供了自定义实现——它将 自动继承所有父类的便利构造器。
         */
        
        /*可失败构造器*/
        /*如果一个类、结构体或枚举类型的对象，在构造过程中有可能失败，则为其定义一个可失败构造器。这里所指
         的“失败”是指，如给构造器传入无效的参数值，或缺少某种所需的外部资源，又或是不满足某种必要的条件
         等。*/
        
        /*注意
         可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其参数类型相同。*/
        
    }
    
    class Food {
        var name: String
        init(name: String) {
            self.name = name
        }
        convenience init() {
            self.init(name: "[Unnamed]")
        }
        
        init?(type : Int) {
            // 可失败构造器
            return nil//表示失败
            // 但是不能用 return 来表示成功
        }
    }
    
    class RecipeIngredient: Food {
        var quantity: Int
        init(name: String, quantity: Int) {
            self.quantity = quantity
            super.init(name: name)
        }
        override convenience init(name: String) {
            // 将指定父类构造器重写为便利构造器
            self.init(name: name, quantity: 1)
        }
        init?(no : Int) {
            if no>8 {
                return nil
            }
            self.quantity = 2
            super.init(type: no)
        }
    }
    
    func others() {
        /*在类的构造器前添加 required 修饰符表明所有该类的子类都必须实现该构造器:*/
        class SomeClass {
            required init() {
                // 构造器的实现代码
            }
            var hi = 6
            
            
            
            let some : Int = {
                
                return 5
            }()// 使用闭包来初始化，注意 如果你使用闭包来初始化属性，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能在闭包 里访问其它属性，即使这些属性有默认值。同样，你也不能使用隐式的 self 属性，或者调用任何实例方法。
            
        }
        // 在子类重写父类的必要构造器时，必须在子类的构造器前也添加 required 修饰符，表明该构造器要求也应用于继 承链后面的子类。在重写父类中必要的指定构造器时，不需要添加 override 修饰符:
        class SomeSubclass: SomeClass {
            required init() {
                // 构造器的实现代码 
            }
        }
    }
}

/// 析构过程
class DeinitProgress {
    deinit {
        print("DeinitProgress")
        // 每个类只能有一个析构器
        // Swift通过使用ARC来做内存管理。
        
        /*
         析构器是在实例释放发生前被自动调用。你不能主动调用析构器。子类继承了父类的析构器，并且在子类析构器
         实现的最后，父类的析构器会被自动调用。即使子类没有提供自己的析构器，父类的析构器也同样会被调用。
         */
    }
}

class SomeClassHH : DeinitProgress {
    deinit {
        print("SomeClass")
    }
}

class ChildClass : SomeClassHH {
    deinit {
        print("ChildClass")
    }
}

