import Foundation

/*
 * 这里讲述了函数式思想，使用函数式的方法解决一个简答的具体问题
 * 判断一我军军舰距离敌军和友军军舰之间的距离
 */


/// 描述军舰的位置
struct Position {
    var x : Double
    var y : Double
}


/// 描述一个领域，给定一个点是否在这个领域之中
typealias Region = (Position) -> Bool


/// 添加一个半径，来生成一个圆
///
/// - Parameter radius: 半径
/// - Returns: 返回一个描述圆的领域，这个描述方式是给定一个点，返回点是否在领域之中
func circle(radius : Double) -> Region {
    
    /// 生成一个Region函数来描述一个圆
    let cir : Region = { (p : Position) in
        /// 实现内部逻辑
        if sqrt(p.x*p.x + p.y*p.y) <= radius { return true }
        return false
    }
    /// 返回这个Region函数
    return cir
}






