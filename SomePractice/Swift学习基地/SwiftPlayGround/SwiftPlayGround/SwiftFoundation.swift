//
//  SwiftFoundation.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/4/24.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/// 这里是Siwft基础
import Foundation

class Foundation {
    func main() {
        print(Int8.max)
        print(Int8.min)
        
        
        
        // 元祖类型
        let (statusCode, statusMessage) = (404, "Not Found")
        print("\(statusCode) and \(statusMessage)")
        // 作为函数返回值等
        
        
        // 使用可选绑定(optional binding)来判断可选类型是否包含值，
        // 如果包含就把值赋给一个临时常量或者变 量。
        var hello : String? = "hello"
        if let constantName = hello {
            print(constantName)
        }

        hello = nil
        if let constantName = hello {
            print(constantName)
        }else {
            print("hello is nil")
        }
        
        // 断言，使用断言来调试程序
        let age = -3
//        assert(age>=0, "A person's age connot be less than zero\n")
        print(age)
    }
    
    /*
     • Double表示64位浮点数。当你需要存储很大或者很高精度的浮点数时请使用此类型。 
     • Float表示32位浮点数。精度要求不高的话可以使用此类型。
     
     注意:
     Double 精确度很高，至少有15位数字，而 Float 只有6位数字。
     选择哪个类型取决于你的代码需要处理的值的范围，
     在两种类型都匹配的情况下，将优先选择 Double 。
     */
    
    
    /*
     整数字面量可以被写作:
     • 一个十进制数，没有前缀
     • 一个二进制数，前缀是 0b
     • 一个八进制数，前缀是 0o
     • 一个十六进制数，前缀是 0x
    */
    
    /*
     浮点字面量可以是十进制(没有前缀)或者是十六进制(前缀是 0x )。小数点两边必须有至少一个十进制数 字(或者是十六进制的数字)。十进制浮点数也可以有一个可选的指数(exponent)，通过大写或者小写的 e 来 指定;十六进制浮点数必须有一个指数，通过大写或者小写的 p 来指定。
    */
    
    /*
     如果一个十进制数的指数为 exp ，那这个数相当于基数和10^exp的乘积: • 1.25e2 表示 1.25 × 10^2，等于 125.0 。
     • 1.25e-2 表示 1.25 × 10^-2，等于 0.0125 。 如果一个十六进制数的指数为 exp ，那这个数相当于基数和2^exp的乘积:
     • 0xFp2 表示 15 × 2^2，等于 60.0 。 • 0xFp-2 表示 15 × 2^-2，等于 3.75 。
     */
    
    /*
     数值类字面量可以包括额外的格式来增强可读性。整数和浮点数都可以添加额外的零并且包含下划线，并不会影
     响字面量:
     let paddedDouble = 000123.456
     let oneMillion = 1_000_000
     let justOverOneMillion = 1_000_000.000_000_1
     */
    
    /*
     所以要调用 UInt16(one) 来创建一个新的 UInt16 数字并用 one 的值来初始化，然后使用 这个新数字来计算:
     let twoThousand: UInt16 = 2_000
     let one: UInt8 = 1
     let twoThousandAndOne = twoThousand + UInt16(one)
     */
    
    /*
     let integerPi = Int(pi)
     // integerPi 等于 3，所以被推测为 Int 类型
     当用这种方式来初始化一个新的整数值时，浮点值会被截断。也就是说 4.75 会变成 4 ， -3.9 会变成 -3 。
     */
    
    /*
     类型别名(type aliases)就是给现有类型定义另一个名字。你可以使用 typealias 关键字来定义类型别名。
     当你想要给现有类型起一个更有意义的名字时，类型别名非常有用。假设你正在处理特定长度的外部资源的数
     据:
     typealias AudioSample = UInt16
     */
    
    
    /// 下标用法
    func xiabiao() {
        /*下标可以定义在类、结构体和枚举中，是访问集合，列表或序列中元素的快捷方式。*/
        struct TimesTable {
            let multiplier: Int
            subscript(index: Int) -> Int {
                return multiplier * index
            }
        }
        let threeTimesTable = TimesTable(multiplier: 3)
        print("six times three is \(threeTimesTable[6])") // 打印 "six times three is 18"
        
        var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        numberOfLegs["bird"] = 2
        
        /*注意
         Swift 的 Dictionary 类型的下标接受并返回可选类型的值。上例中的 numberOfLegs 字典通过下标返回的是一个
         Int? 或者说“可选的int”。 Dictionary 类型之所以如此实现下标，是因为不是每个键都有个对应的值，同时 这也提供了一种通过键删除对应值的方式，只需将键对应的值赋值为 nil 即可。*/
        
        
        /*一个类或结构体可以根据自身需要提供多个下标实现，使用下标时将通过入参的数量和类型进行区分，自动匹配
         合适的下标，这就是下标的重载。*/
        struct Matrix {
            let rows: Int, columns: Int
            var grid: [Double]
            init(rows: Int, columns: Int) {
                self.rows = rows
                self.columns = columns
                grid = Array(repeating: 0.0, count: rows * columns)
            }
            func indexIsValidForRow(row: Int, column: Int) -> Bool {
                return row >= 0 && row < rows && column >= 0 && column < columns
            }
            subscript(row: Int, column: Int) -> Double {
                get {
                    assert(indexIsValidForRow(row: row, column: column), "Index out of range")
                    return grid[(row * columns) + column]
                }
                set {
                    assert(indexIsValidForRow(row: row, column: column), "Index out of range")
                    grid[(row * columns) + column] = newValue
                }
            }
        }
        
        var mat : Matrix = Matrix.init(rows: 3, columns: 4)
        mat[1,3] = 1.5//使用下标语法
        mat[2,4] = 3
        
        
    }
    
    /// 继承
    func inherit() {
        /*一个类可以继承另一个类的方法，属性和其它特性。当一个类继承其它类时，继承类叫子类，被继承类叫超 类(或父类)。在 Swift 中，继承是区分「类」与其它类型的一个基本特征。*/
        
        /*
         注意
         Swift 中的类并不是从一个通用的基类继承而来。如果你不为你定义的类指定一个超类的话，这个类就自动成为 基类。*/
        class SomeSuperclass {
            //这里是父类的实现
        }
        
        class SomeClass: SomeSuperclass {
            // 这里是子类的定义
        }
        
        /*子类可以为继承来的实例方法，类方法，实例属性，或下标提供自己定制的实现。我们把这种行为叫重写。*/
        
        /*关键字会提醒 Swift 编译器去检查该类的超类(或其中一个父类)是否有匹配重写版本的声明。*/
        /*访问超类的方法，属性及下标*/
        /*
         • 在方法 someMethod() 的重写实现中，可以通过 super.someMethod() 来调用超类版本的 someMethod() 方法。
         • 在属性 someProperty 的 getter 或 setter 的重写实现中，可以通过 super.someProperty 来访问超类版本的 someProperty 属性。
         • 在下标的重写实现中，可以通过 super[someIndex] 来访问超类版本中的相同下标。
         */
        
        
        /*
         你可以提供定制的 getter(或 setter)来重写任意继承来的属性，无论继承来的属性是存储型的还是计算型的 属性。子类并不知道继承来的属性是存储型的还是计算型的，它只知道继承来的属性会有一个名字和类型。
         */
        
        /*使用final来防止重写和继承*/
    }
    
}
