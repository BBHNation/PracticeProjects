import Foundation

public struct optionalVar {
    public var num : Int?
}

infix operator ??? : AdditionPrecedence

/// 模仿??方法，如果optional为nil则返回defaultValue，使用@autoclosure来避开创建显式闭包
public func ??? <T>(optional : T?, defaultValue : @autoclosure ()->T) -> T {
    if let k = optional {
        return k
    } else {
        return defaultValue()
    }
}

extension optionalVar {
    public func main() {
        var k = optionalVar()
        k.num = 9
        if let i = k.num {
            // 如果k.num不为nil，则进入这里
        }
        else {
            // 如果为nil
        }
        
        // 使用 ?? 符号来默认值
        print(k.num ??? 3)
    }
}


