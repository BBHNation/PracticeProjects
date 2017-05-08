//
//  Protocol.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/5/2.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/// 协议
import Foundation

protocol SomeProtocol {
    // 这里是协议的定义部分
    
    /*
     属性要求
     协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性。协议不指定属性是存储型属性还是计
     算型属性，它只指定属性的名称和类型。此外，协议还指定属性是可读的还是可读可写的。
     */
    var mustBeSettable: Int { get set }
    static var doesNotNeedToBeSettable: Int { get }
    
    
    /*
     方法要求
     协议可以要求遵循协议的类型实现某些指定的实例方法或类方法。这些方法作为协议的一部分，像普通方法一样
     放在协议的定义中，但是不需要大括号和方法体。可以在协议中定义具有可变参数的方法，和普通方法的定义方
     式相同。但是，不支持为协议中的方法的参数提供默认值。
     */
    func random() -> Double
    static func other()
    
    /*
     Mutating可变方法要求
     有时需要在方法中改变方法所属的实例。例如，在值类型(即结构体和枚举)的实例方法中，将 mutating 关键 字作为方法的前缀，写在 func 关键字之前，表示可以在该方法中修改它所属的实例以及实例的任意属性的 值。这一过程在在实例方法中修改值类型 (页 0)章节中有详细描述。
     如果你在协议中定义了一个实例方法，该方法会改变遵循该协议的类型的实例，那么在定义协议时需要在方法前 加 mutating 关键字。这使得结构体和枚举能够遵循此协议并满足此方法要求。
     */
    
    mutating func change()//枚举和结构体可以修改自身的属性，但是类其实不需要
    
    init(h : Int)
    /*
     构造器要求在类中的实现
     你可以在遵循协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器。无论哪种情况，你都必须 为构造器实现标上 required 修饰符:
     
     class SomeClass: SomeProtocol {
        required init(someParameter: Int) {
        // 这里是构造器的实现部分 
        }
     }
     使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能符合协议。
     
     如果一个子类重写了父类的指定构造器，并且该构造器满足了某个协议的要求，那么该构造器的实现需要同时标 注 required 和 override 修饰符:
     */
    
    
    /*
     协议作为类型
     尽管协议本身并未实现任何功能，但是协议可以被当做一个成熟的类型来使用。
     协议可以像其他普通类型一样使用，使用场景如下:
     • 作为函数、方法或构造器中的参数类型或返回值类型 
     • 作为常量、变量或属性的类型
     • 作为数组、字典或其他容器中的元素类型
     */
    
}


class testGood {
    let protocolHi : helloProtocol
    init(pro : helloProtocol) {
        self.protocolHi = pro
    }
}

/*
 委托代理模式
 委托是一种设计模式，它允许类或结构体将一些需要它们负责的功能委托给其他类型的实例。委托模式的实现很
 简单:定义协议来封装那些需要被委托的功能，这样就能确保遵循协议的类型能提供这些功能。委托模式可以用
 来响应特定的动作，或者接收外部数据源提供的数据，而无需关心外部数据源的类型。
 */
class Dice {
    let sides: Int
    let generator: SomeProtocol // 只要是遵循了SomeProtocol的类型实例都可以赋予
    init(sides: Int, generator: SomeProtocol) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

/*
class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}
*/

/*
 协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。协议的继承语法与类的继承相
 似，多个被继承的协议间用逗号分隔:
 protocol InheritingProtocol: SomeProtocol, AnotherProtocol { // 这里是协议的定义部分
 }
 */


/*
 你可以在协议的继承列表中，通过添加 class 关键字来限制协议只能被类类型遵循，而结构体或枚举不能遵循 该协议。class 关键字必须第一个出现在协议的继承列表中，在其他继承的协议之前:
 
 protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol { // 这里是类类型专属协议的定义部分
 }
 */



/*协议合成*/
/*
 你可以将多个协议采用 SomeProtocol & AnotherProtocol 这样的格式进行组
 合，称为 协议合成(protocol composition)。
 */
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person: Named, Aged {
    var name: String
    var age: Int
}


/*
 你可以使用类型转换中描述的 is 和 as 操作符来检查协议一致性，即是否符合某协议，并且可以转换到指定 的协议类型。检查和转换到某个协议类型在语法上和类型的检查和转换完全相同:
 • is 用来检查实例是否符合某个协议，若符合则返回 true ，否则返回 false 。
 • as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil 。 • as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误。
 */



/*可选协议*/
/*
 协议可以定义可选要求，遵循协议的类型可以选择是否实现这些要求。在协议中使用 optional 关键字作为前缀 来定义可选要求。可选要求用在你需要和 Objective-C 打交道的代码中。协议和可选要求都必须带上 @objc 属 性。标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举 均不能遵循这种协议。
 */

@objc protocol CounterDataSource {
    @objc optional func incrementForCount(count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}


extension CounterDataSource {
    // 提供默认实现
    func incrementForCount(count: Int) -> Int {
        return count
    }
}


/*限制条件*/
/*
 在扩展协议的时候，可以指定一些限制条件，只有遵循协议的类型满足这些限制条件时，才能获得协议扩展提供 的默认实现。这些限制条件写在协议名之后，使用 where 子句来描述，正如Where子句 (页 0)中所描述的。
 extension CollectionType where Generator.Element: TextRepresentable {
 var textualDescription: String {
 let itemsAsText = self.map { $0.textualDescription }
 return "[" + itemsAsText.joinWithSeparator(", ") + "]"
 }
 }
 */

