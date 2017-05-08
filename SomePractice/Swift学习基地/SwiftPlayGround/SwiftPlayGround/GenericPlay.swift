//
//  GenericPlay.swift
//  SwiftPlayGround
//
//  Created by 白彬涵 on 2017/4/24.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//
/// 这里是泛型的练习和学习

import Foundation

class GenericPlay {
    func repeatItem<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
        var result = [Item]()
        for _ in 0..<numberOfTimes {
            result.append(item)
        }
        return result
    }
    
    
    
    /// 实现Swift中的可选类型，使用泛型
    enum OptionalValue<Wrapped> {
        case None
        case Some(Wrapped)
    }
    
    /// 在类型名后面使用 where 来指定对类型的需求，
    /// 比如，限定类型实现某一个协议，限定两个类型是相同的，
    /// 或者 限定某个类必须有一个特定的父类。
    
    func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T,_ rhs: U) -> Bool where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
        for lhsItem in lhs {
            for rhsItem in rhs {
                if lhsItem == rhsItem {
                    return true
                }
            }
        }
        return false
    }
    
    func commonElements<T: Sequence, U: Sequence, Elemant>(lhs: T, rhs: U) -> [Elemant] where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
        var result = [Elemant]()
        
        for lhsitem in lhs {
            for rhsitem in rhs {
                if lhsitem == rhsitem {
                    if let item = lhsitem as? Elemant {
                        result.append(item)
                    }
                }
            }
        }
        return result
    }
    
    /// 主函数
    func main() {
        print(repeatItem(repeating: "hello", numberOfTimes: 3))
        let hello : OptionalValue<Int> = .None
        let Hi : OptionalValue<Int> = .Some(100)
        print("hello \(hello) and Hi \(Hi)")
        
        print(anyCommonElements([1,2,3], [3]))
        
        print(commonElements(lhs: [2,3,6,5], rhs: [1,2,3]) as [Int])
    }
    
    
    /*________________________________________________________________________*/
    /*这里是Swift官方文档中的介绍*/
    /*目录*/
    /*
     • 泛型所解决的问题 (页 0) • 泛型函数 (页 0)
     • 类型参数 (页 0)
     • 命名类型参数 (页 0)
     • 泛型类型 (页 0)
     • 扩展一个泛型类型 (页 0) • 类型约束 (页 0)
     • 关联类型 (页 0)
     • 泛型 Where 语句 (页 0)
     */
    
    /// 泛型函数交换两个值
    func exchangeTwoValue<T>(a : inout  T, b : inout  T) {
        //你可提供多个类型参数，将它们都写在尖括号中，用逗号分开。
        let c : T = a
        a = b
        b = c
    }
    
    func newMain() {
        var k = "nihao"
        var p = "♥️"
        exchangeTwoValue(a: &k, b: &p)
        print(k)
        
        var stack = Stack<Int>()
        stack.push(e: 5)
        stack.push(e: 3)
        print(stack.pop() ?? "nil")
        stack.push(e: 1)
        print(stack.pop() ?? "nil")
        print(stack.pop() ?? "nil")
        print(stack.pop() ?? "nil")
    }
    
    
    struct Stack<Element> {
        var items = [Element]()
        mutating func push(e : Element) {
            items.append(e)
        }
        mutating func pop() -> Element? {
            if items.isEmpty {
                return nil
            }
            return items.removeLast()
        }
    }
    
    class SomeClass {
        
    }
    func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
        // 这里是泛型函数的函数体部分
    }
}

//扩展泛型
extension GenericPlay.Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

// 下面例子定义了一个 Container 协议，该协议定义了一个关联类型 ItemType :
/*
 Container 协议定义了三个任何采纳了该协议的类型(即容器)必须提供的功能:
 • 必须可以通过 append(_:) 方法添加一个新元素到容器里。
 • 必须可以通过 count 属性获取容器中元素的数量，并返回一个 Int 值。 
 • 必须可以通过索引值类型为 Int 的下标检索到容器中的每一个元素。
 */
protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStack: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // Container 协议的实现部分 typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
    
    
}
/*
 定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分将会非常有用。关联类型为协议中的 某个类型提供了一个占位名(或者说别名)，其代表的实际类型在协议被采纳时才会被指定。你可以通过 atedtype 关键字来指定关联类型。
 */


/*泛型Where语句*/

func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
        // 检查两个容器含有相同数量的元素
        if someContainer.count != anotherContainer.count {
            return false
        }
        // 检查每一对元素是否相等
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            } }
        // 所有元素都匹配，返回 true 
        return true
}

/*
 这个函数的类型参数列表还定义了对两个类型参数的要求:
 • 必须符合   协议(写作 )。
 • C2 必须符合 Container 协议(写作 C2: Container )。
 • C1 的 ItemType 必须和 C2 的 ItemType 类型相同(写作 C1.ItemType == C2.ItemType )。 
 • C1 的 ItemType 必须符合 Equatable 协议(写作 C1.ItemType: Equatable )。

 */

