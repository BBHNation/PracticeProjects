//
//  ControlFlow.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/4/26.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import Foundation
class ControlFlow {
    
    /// 目录
    func List() {
        /*
         • For-In 循环 (页 0)
         • While 循环 (页 0)
         • 条件语句 (页 0)
         • 控制转移语句(Control Transfer Statements) (页 0)
         • 提前退出 (页 0)
         • 检测 API 可用性 (页 0)
         */
    }
    
    /// 概况
    func main() {
        /*
         Swift提供了多种流程控制结构，包括可以多次执行任务的 while 循环，基于特定条件选择执行不同代码分支的 i
         f 、 guard 和 switch 语句，还有控制流程跳转到其他代码位置的 break 和 continue 语句。
         Swift 还提供了 for-in 循环，用来更简单地遍历数组(array)，字典(dictionary)，区间(range)，字符
         串(string)和其他序列类型。
         Swift 的 switch 语句比 C 语言中更加强大。在 C 语言中，如果某个 case 不小心漏写了 break ，这个 case 就 会贯穿至下一个 case，Swift 无需写 break ，所以不会发生这种贯穿的情况。case 还可以匹配很多不同的模 式，包括间隔匹配(interval match)，元组(tuple)和转换到特定类型。 switch 语句的 case 中匹配的值可 以绑定成临时常量或变量，在case体内使用，也可以用 where 来描述更复杂的匹配条件。
         */
    }
    
    /// For-In循环
    func ForIn() {
        for index in 1...5 {
            print("(index) times 5 is \(index * 5)")
        }
        
        let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        for (animalName, legCount) in numberOfLegs {
            print("\(animalName)s have \(legCount) legs")
        }
    }
    
    /// While循环
    func WhileLoop() {
        /*while 循环会一直运行一段语句直到条件变成 false 。*/
        /*
         • while循环，每次在循环开始时计算条件是否符合;
         • repeat-while循环，每次在循环结束时计算条件是否符合。
         */
        var i = 10
        while i>0{
            i = i-1
        }
        
        i = 10
        repeat {
            i = i-1
        } while i>0
    }

    /// 条件语句
    func Conditions() {
        /*Swift 提供两种类型的条件语句: if 语句和 switch 语句。
         通常，当条件较为简单且可能的情况很少时，使用 i f 语句。
         而 switch 语句更适用于条件较复杂、有更多排列组合的时候。
         并且 switch 在需要用到模式匹配(patte rn-matching)的情况下会更有用。*/
        
        
        
        /*_______________________________________*/
        /*IF*/
        let temperatureInFahrenheit : Int
        temperatureInFahrenheit = 89
        var i = 0
        if (temperatureInFahrenheit <= 32) {
            i = i+1
            print("It's very cold. Consider wearing a scarf.")
        } else if (temperatureInFahrenheit >= 86) {
            i = i-1
            print("It's really warm. Don't forget to wear sunscreen.")
        } else {
            print("else")
        }
        
        
        
        /*_______________________________________*/
        /*Switch*/
        /*
         switch some value to consider {
         case value 1:
         respond to value 1
         case value 2,
         value 3:
         respond to value 2 or 3
         default:
         otherwise, do something else
         }
        */
        var someCharacter: Character = "z"
        switch someCharacter {
        case "a":
            print("The first letter of the alphabet")
        case "z":
            print("The last letter of the alphabet")
        default:
            print("Some other character")
        }
        // 输出 "The last letter of the alphabet"
        //每一个 case 分支都必须包含至少一条语句。像下面这样书写代码是无效的，因为第一个 case 分支是空的:
        /*
         let anotherCharacter: Character = "a" switch anotherCharacter {
         case "a": // 无效，这个分支下面没有语句 case "A":
         print("The letter A")
         default:
         print("Not the letter A")
         }
         // 这段代码会报编译错误
         */
        
        // 为了让单个case同时匹配 a 和 A ，可以将这个两个值组合成一个复合匹配，并且用逗号分开:
        let anotherCharacter: Character = "a"
        switch anotherCharacter {
        case "a", "A":
            print("The letter A")
        default:
            print("Not the letter A")
        }
        // 输出 "The letter A
        
        /*注意: 如果想要显式贯穿case分支，请使用 fallthrough 语句*/
        
        /*_______________________________________*/
        /*区间匹配*/
        let approximateCount = 62
        let countedThings = "moons orbiting Saturn"
        var naturalCount: String
        switch approximateCount {
        case 0:
            naturalCount = "no"
        case 1..<5:
            naturalCount = "a few"
        case 5..<12:
            naturalCount = "several"
        case 12..<100:
            naturalCount = "dozens of"
        case 100..<1000:
            naturalCount = "hundreds of"
        default:
            naturalCount = "many"
        }
        print("There are \(naturalCount) \(countedThings).") // 输出 "There are dozens of moons orbiting Saturn."
        
        /*_______________________________________*/
        /*元组*/
        /*我们可以使用元组在同一个 switch 语句中测试多个值。元组中的元素可以是值，也可以是区间。另外，使用下划 线( _ )来匹配所有可能的值。*/
        let somePoint = (1, 1)
        switch somePoint {
        case (0, 0):
            print("(0, 0) is at the origin")
        case (_, 0):
            print("(\(somePoint.0), 0) is on the x-axis")
        case (0, _):
            print("(0, \(somePoint.1)) is on the y-axis")
        case (-2...2, -2...2):
            print("(\(somePoint.0), \(somePoint.1)) is inside the box")
        default:
            print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
        }
        // 输出 "(1, 1) is inside the box"
        
        /*_______________________________________*/
        /*值绑定*/
        /*
         case 分支允许将匹配的值绑定到一个临时的常量或变量，并且在case分支体内使用 —— 这种行为被称为值绑 定(value binding)，因为匹配的值在case分支体内，与临时的常量或变量绑定。
         */
        let anotherPoint = (2, 0)
        switch anotherPoint {
        case (let x, 0):
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y):
            print("somewhere else at (\(x), \(y))")
        }
        // 输出 "on the x-axis with an x value of 2"
        
        /*_______________________________________*/
        /*Where*/
        /*case 分支的模式可以使用 where 语句来判断额外的条件。*/
        let yetAnotherPoint = (1, -1)
        switch yetAnotherPoint {
        case let (x, y) where x == y:
            print("(\(x), \(y)) is on the line x == y")
        case let (x, y) where x == -y:
            print("(\(x), \(y)) is on the line x == -y")
        case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        // 输出 "(1, -1) is on the line x == -y"
        
        /*_______________________________________*/
        /*符合匹配*/
        /*当多个条件可以使用同一种方法来处理时，可以将这几种可能放在同一个 case 后面，并且用逗号隔开。当case后 面的任意一种模式匹配的时候，这条分支就会被匹配。并且，如果匹配列表过长，还可以分行书写:*/
        someCharacter = "e"
        switch someCharacter {
        case "a", "e", "i", "o", "u":
            print("\(someCharacter) is a vowel")
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
             "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            print("\(someCharacter) is a consonant")
        default:
            print("\(someCharacter) is not a vowel or a consonant")
        }
        // 输出 "e is a vowel"
    }
    
    /// 控制转移语句
    func ControlBreak() {
        /*
         • continue
         • break
         • fallthrough • return
         • throw
         */
        
        // continue 语句告诉一个循环体立刻停止本次循环，重新开始下次循环。就好像在说“本次循环我已经执行完 了”，但是并不会离开整个循环体。
        
        // break 语句会立刻结束整个控制流的执行。当你想要更早的结束一个 switch 代码块或者一个循环体时，你都可以 使用 break 语句。
        
        // 如果你确实需要 C 风格的贯穿的特性，你可以在每个需要该特性的 case 分支中使用 fallthrough 关键字。下面 的例子使用 fallthrough 来创建一个数字的描述语句。
        
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe {
        case 2, 3, 5, 7, 11, 13, 17, 19:
            description += " a prime number, and also"
            fallthrough
        default:
            description += " an integer."
        }
        print(description)
        // 输出 "The number 5 is a prime number, and also an integer."
        
        
        /*带标签的语句*/
        /*在 Swift 中，你可以在循环体和条件语句中嵌套循环体和条件语句来创造复杂的控制流结构。并且，循环体和条 件语句都可以使用 break 语句来提前结束整个代码块。因此，显式地指明 break 语句想要终止的是哪个循环体或 者条件语句，会很有用。类似地，如果你有许多嵌套的循环体，显式指明 continue 语句想要影响哪一个循环体也 会非常有用。*/
        firstLoop: for var i in 0..<10 {
            secondeLoop: while i < 5 {
                i = i+1
                if i>8 {
                    continue firstLoop
                }
                break secondeLoop
            }
        }
        
        /*________________________________________________*/
        /*Guard*/
        /*
         像 if 语句一样， guard 的执行取决于一个表达式的布尔值。我们可以使用 guard 语句来要求条件必须为真 时，以执行 guard 语句后的代码。不同于 if 语句，一个 guard 语句总是有一个 else 从句，如果条件不为真则执 行 else 从句中的代码。
         */
        func greet(person: [String: String]) {
            guard let name = person["name"] else {
                return }
            print("Hello \(name)")
            guard let location = person["location"] else {
                print("I hope the weather is nice near you.")
                return }
            print("I hope the weather is nice in \(location).")
        }
        greet(person: ["name": "John"])
        // 输出 "Hello John!"
        // 输出 "I hope the weather is nice near you." greet(["name": "Jane", "location": "Cupertino"]) // 输出 "Hello Jane!"
        // 输出 "I hope the weather is nice in Cupertino."
    }
    
    /// API可用性
    func useAble() {
        if #available(iOS 10, macOS 10.12, *) {
            // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
        } else {
            // 使用先前版本的 iOS 和 macOS 的 API
        }
        
        /*
         以上可用性条件指定，在iOS中， if 语句的代码块仅仅在 iOS 10 及更高的系统下运行;在 macOS中，仅在 macO S 10.12 及更高才会运行。最后一个参数， * ，是必须的，用于指定在所有其它平台中，如果版本号高于你的设 备指定的最低版本，if语句的代码块将会运行。
         在它一般的形式中，可用性条件使用了一个平台名字和版本的列表。平台名字可以是 iOS ， macOS ， watchOS 和 tvOS ——请访问声明属性来获取完整列表。除了指定像 iOS 8的主板本号，我们可以指定像iOS 8.3 以及 macOS
         10.10.3的子版本号。
         
         if #available(platform name version, ..., *) { APIs 可用，语句将执行
         } else {
         APIs 不可用，语句将不执行
         }
         */
    }
   
}
