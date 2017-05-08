//
//  AutoResourceCount.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/4/27.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/// 这里是自动引用计数
import Foundation

class AutomaticReferenceCounting {
    var name = "BBH"
    func main() {
        class Person {
            var name : String
            var apar : Apartment? {
                willSet {
                    print("set apar")
                }
            }
            init(name : String) {
                self.name = name
                print(self.name)
            }
            deinit {
                print("deinit \(self.name)")
            }
        }
        
        class Apartment {
            var unit : Int
            var per : Person? {
                didSet {
                    print("set per")
                }
            }
            // 弱引用
            weak var weakPerson : Person?
            init(unit : Int) {
                self.unit = unit
            }
            deinit {
                print("apartment deinit \(self.unit)")
            }
        }
        
        // 这里演示ARC和强引用
        var per : Person? = Person(name: "BBH")
        
        var reference1: Person?
        var reference2: Person?
        var reference3: Person?
        
        reference1 = per
        reference2 = reference1
        reference3 = reference1
        reference1 = nil
        reference2 = nil
        reference3 = nil
        print("\(String(describing: reference1)),\(String(describing: reference2)),\(String(describing: reference3))")
        print(per ?? "nil")
        per = nil
        print(per ?? "nil")
        
        // 这里演示循环强引用
        print("\n循环引用开始")
        var newPer : Person? = Person.init(name: "BBH")
        var apar : Apartment? = Apartment.init(unit: 4)
        newPer?.apar = apar
        apar?.per = newPer
        newPer = nil
        apar = nil
        
        // 介绍 弱引用(weak reference)和无 主引用(unowned reference)。
        print("\n使用弱引用之后")
        var allNewPerson : Person? = Person.init(name: "RQQ")
        var newApartment : Apartment? = Apartment.init(unit: 3)
        allNewPerson?.apar = newApartment
        newApartment?.weakPerson = allNewPerson
        allNewPerson = nil
        newApartment = nil
        
        
        // 这里介绍 无主引用
        // 无主引用通常都被期望拥有值。不过 ARC 无法在实例被销毁后将无主引用设为 nil ，因为非可选类型的变量不允 许被赋值为 nil 。
        // 重要
        // 使用无主引用，你必须确保引用始终指向一个未销毁的实例。
        // 如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。
        class Customer {
            var name : String
            var card : CreditCard? {
                didSet {
                    print("card id is \(String(describing: card?.cardId))")
                }
            }
            
            init(name : String) {
                self.name = name
            }
            deinit {
                print("customer deinit \(self.name)")
            }
        }
        
        class CreditCard {
            let cardId : UInt
            unowned let customer : Customer//这个属性不能为空时候，使用无引用
            init(id : UInt, customer : Customer) {
                self.cardId = id
                self.customer = customer
            }
            deinit {
                print("credit card deinit #\(self.cardId)")
            }
        }
        
        var cus : Customer? = Customer.init(name: "BBH")
        cus!.card = CreditCard.init(id: 1245235325, customer: cus!)
        cus = nil
        
        
        // 下面介绍 隐式解析可选属性
        class Country {
            let name : String
            var capitalCity : City!
            init(name: String, capitalCity : String) {
                self.name = name
                self.capitalCity = City.init(name: capitalCity, County: self)
                // 这里使用了self来初始化City，属于构造函数的第二阶段，但是第一阶段一定要保证所有属性初始化了，这里capitalCity没有初始化，所有在capitalCity后面加一个 ！，这样capitalCity默认值为nil，但是不需要展开他就能访问他。
            }
            
            deinit {
                print("deinit with \(self.name)")
            }
        }
        
        class City {
            let name : String
            unowned let County : Country
            init(name : String, County : Country) {
                self.name = name
                self.County = County
            }
            
            deinit {
                print("deinit with \(self.name)")
            }
        }
        
        
        //_____________________________________________
        // 这里介绍闭包引起的循环强引用
        
        // 循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了这个类实例时。这 个闭包体中可能访问了实例的某个属性，例如 self.someProperty ，或者闭包中调用了实例的某个方法，例如 f.someMethod() 。这两种情况都导致了闭包“捕获” self ，从而产生了循环强引用。
        
        // Swift 提供了一种优雅的方法来解决这个问题，称之为 闭包捕获列表 
        // closure capture list
        // 如类 HTMLElement 中描述，在闭包中使用了self的属性或方法则强引用了自己
        
        // 使用捕获列表
        print("name is \(self.asHTML())")
        
    }
    
    lazy var asHTML: () -> String = {
        [unowned self] in
        // 在闭包和捕获的实例总是互相引用并且总是同时销毁时，将闭包内的捕获定义为 无主引用 。 相反的，在被捕获的引用可能会变为 nil 时，将闭包内的捕获定义为 弱引用 。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为 nil 。这使我们可以在闭包体内检查它们是否存在。
        // 注意
        // 如果被捕获的引用绝对不会变为 nil ，应该用无主引用，而不是弱引用。
        return self.name
    }
}


class HTMLElement {
    let name: String
    let text: String?
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    //注意
    // asHTML 声明为 lazy 属性，因为只有当元素确实需要被处理为 HTML 输出的字符串时，才需要使用 asHTML 。也就是说，在默认的闭包中可以使用 self ，因为只有当初始化完成以及 self 确实存在后，才能访问 lazy 属性。

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
