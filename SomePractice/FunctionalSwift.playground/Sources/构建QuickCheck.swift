import Foundation
/// 这里是构建了一个QuickCheck的Swift版本
/// QuickCheck实现了半自动随机测试函数



///*******************************************************************
/// 第一步，随机函数（包含数字，字符，字符串）

/// 一个协议来描述可以生成随机数


public protocol Smaller {
    func smaller() -> Self?;
}

public protocol Arbitrary : Smaller {
    static func arbitrary () -> Self;
}

// MARK: - 使得Int可以生成随机数
extension Int : Arbitrary {
    public static func arbitrary() -> Int {
        return Int(arc4random()%100)
    }
    
    public static func random(from : Int, to : Int) -> Int {
        return from + (Int(arc4random())%(to - from))
    }
}

// MARK: - 扩展Character
extension Character : Arbitrary {
    
    /// 缩小范围，一个字符则缩小成nil
    ///
    /// - Returns: 返回nil
    public func smaller() -> Character? {
        return nil
    }

    
    /// 生成一个随机字母，目前是随机大写字母
    ///
    /// - Returns: 返回的字母
    public static func arbitrary() -> Character {
        return Character(UnicodeScalar(Int.random(from: 65, to: 90))!)
    }
}

/// 生成一个长度为times的数组
///
/// - Parameters:
///   - times: 长度
///   - transform: 转换方式，由Int到A的函数
/// - Returns: 返回类型为A的数组
public func tabulate<A>(times : Int, transform : (Int) -> A) -> [A] {
    return (0..<times).map(transform)
}

// MARK: - 扩展String
extension String : Arbitrary {
    
    
    
    /// 生成一个随机String
    ///
    /// - Returns: 返回一个包含随机字符的字符串
    public static func arbitrary() -> String {
        let randomLength = Int.random(from: 0, to: 40)// 随机长度，0到40，可修改
        let randomCharacters = tabulate(times: randomLength) { (_) -> Character in
            Character.arbitrary()// 使用字符的函数来生成随机字符
        }
        return String(randomCharacters)
    }
}


///*******************************************************************
/// 第二步，实现check函数


public func check1<A : Arbitrary> (message : String, property : (A) -> Bool) {
    for _ in 0..<10 {
        let value = A.arbitrary()
        guard property(value) else {
            print("\"\(message)\" doesn't hold: \(value)")
            return
        }
    }
    print("\"\(message)\" passed \(10) tests")
}


///*******************************************************************
/// 第三步，缩小范围



extension Int : Smaller {
    public func smaller() -> Int? {
        return self == 0 ? nil : self/2
    }
}


extension String : Smaller {
    public func smaller() -> String? {
        return isEmpty ? nil : String(characters.dropFirst())
    }
}


/// 满足条件的时候递归调用自己来缩小范围
///
/// - Parameters:
///   - condition: 条件函数
///   - initial: 初始化状态
///   - next: 缩小范围函数
/// - Returns: 返回一个满足条件缩小后的A
public func iterateWhile<A>(condition : (A)->Bool, initial : A, next : (A)->A?) -> A {
    if let x = next(initial) {// 先将x定义为被缩小范围的下一个状态
        if condition(x) {// 如果满足条件
            return iterateWhile(condition: condition, initial: x, next: next)// 则递归调用自己
        }
    }
    return initial// 如果并不满足条件或者x为空，则直接返回初始状态
}




/// check2是加入了缩小范围功能，发现不符合的条件则缩小范围，最终确定最小不符合要求的测试用例
///
/// - Parameters:
///   - message: 提示信息
///   - property: 判断是否符合测试要求
public func check2<A : Arbitrary>(message : String, _ property: (A) -> Bool) {
    for _ in 0..<10 {
        let value = A.arbitrary()
        guard property(value) else {
            /// property为测试函数，所以condition为 ！property($0)    意思是，在不满足测试通过的情况下，可以缩小自己
            /// 初始化是最早的随机测试数，这个数没有通过测试，所以可以来缩小范围
            /// next指的是缩小操作函数。这个函数在这里是使用了smaller函数来缩小范围，而smaller函数可以自定义
            let smallerValue = iterateWhile(condition: { !property($0) }, initial: value, next: { $0.smaller() })//找到不满足条件的最小的边界值
            print("\"\(message)\" doesn't hold: \(smallerValue)")
            return
        }
    }
    print("\"\(message)\" passed \(10) tests.")
}






