import Foundation

/*
 * 这里讲述了函数式思想，使用函数式的方法解决一个简答的具体问题
 * 判断一我军军舰距离敌军和友军军舰之间的距离
 */


/// 描述军舰的位置
public struct Position {
    var x : Double
    var y : Double
    public init(nx : Double, ny : Double) {
        x = nx
        y = ny
    }
}

extension Position {
    
    /// 返回一个位移后的点
    ///
    /// - Parameter p: 位移量
    /// - Returns: 返回自己被位移后的新点（位移方式是反向位移，例如（1，1）位移（2，2）得到的是（-1，-1））
    public func minus(p : Position) -> Position {
        return Position(nx: x-p.x, ny: y-p.y)
    }
    
    /// 非存储变量，获取本点到原点的距离
    public var length : Double {
        return sqrt(x*x + y*y)
    }
}


/// 描述一个领域，给定一个点是否在这个领域之中
//public typealias Region = (Position) -> Bool
public struct Region {
    public var lookUp : (Position) -> Bool
    public init(look : @escaping (Position)->Bool) {
        lookUp = look
    }
}



extension Region {
    /// 添加一个半径，来生成一个圆
    ///
    /// - Parameter radius: 半径
    /// - Returns: 返回一个描述圆的领域，这个描述方式是给定一个点，返回点是否在领域之中
    public static func circle(radius : Double) -> Region {
        
        /// 生成一个Region函数来描述一个圆
        let cir = Region.init(look: { (p : Position) in
            /// 实现内部逻辑
            if sqrt(p.x*p.x + p.y*p.y) <= radius { return true }
            return false
        })
        /// 返回这个Region函数
        return cir
    }
    
    
    /// 添加一个半径和圆心，来生成一个范围，描述一个圆
    ///
    /// - Parameters:
    ///   - radius: 半径
    ///   - center: 圆心
    /// - Returns: 范围，用来描述一个范围（圆）
    public static func circle2(radius : Double, center : Position) -> Region {
        return Region.init(look: { p in
            return self.circle(radius: radius).lookUp(p.minus(p: center))
        })
    }
    
    
    /// 将某一个领域位移一部分距离
    ///
    /// - Parameters:
    ///   - region: 需要位移的领域
    ///   - offset: 位移量
    /// - Returns: 返回位移后的领域（位移是正向位移，例如（1，1）位移（2，2）则位移后是（3，3））
    public static func shift(region : Region, offset : Position) -> Region {
        return Region.init(look: { p in
            /// region是描述之前的领域
            /// 新的领域是描述位移之后的领域
            /// 可以使用将输入的点位移之后放在原来的领域中，
            return region.lookUp(p.minus(p: offset))
        })
    }
    
    
    /// 反转某个领域，相当于取非
    ///
    /// - Parameter region: 需要反转的领域
    /// - Returns: 返回已经被反转的领域
    public static func invert(region : Region) -> Region {
        return Region.init(look: { p in
            return !region.lookUp(p)
        })
    }
    
    /// 返回两个领域的交集
    ///
    /// - Parameters:
    ///   - region1: 领域一
    ///   - region2: 领域二
    /// - Returns: 返回两个领域的交集领域
    public static func  intersection(region1 : Region, region2 : Region) -> Region {
        return Region.init(look: { p in
            return region1.lookUp(p) && region2.lookUp(p)
        })
    }
    
    /// 返回两个领域的并集
    ///
    /// - Parameters:
    ///   - region1: 领域一
    ///   - region2: 领域二
    /// - Returns: 返回并集领域
    public static func union(region1 : Region, region2 : Region) -> Region {
        return Region.init(look: { p in
            return region1.lookUp(p) || region2.lookUp(p)
        })
    }
    
    
    /// 取两个领域的差
    ///
    /// - Parameters:
    ///   - region1: 原来的领域
    ///   - region2: 需要被减去的领域
    /// - Returns: 原来的领域减去某个领域之后的领域
    public static func deffer(region1 : Region, region2 : Region) -> Region {
        return intersection(region1: region1, region2:invert(region: region2))
    }
}










