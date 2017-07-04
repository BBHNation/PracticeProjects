import Foundation
import UIKit
/// 这里是对Core Graphics的函数式封装

/// 核心数据结构

/// 绘制三种类型的元素
///
/// - Ellipse: 椭圆
/// - Rectangle: 矩形
/// - Text: 文字
enum Primitive {
    case Ellipse
    case Rectangle
    case Text(String)
}

enum Attribute {
    case FillColor(UIColor)
}


/// 一些排版方式
///
/// - Prim: 带有尺寸的绘制类型
/// - Beside: 左右排版
/// - Below: 上下排版
/// - Attributed: 填充色
/// - Align: 对齐方式
indirect enum Diagram {
    case Prim(CGSize, Primitive)
    case Beside(Diagram, Diagram)
    case Below(Diagram, Diagram)
    case Attributed(Attribute, Diagram)
    case Align(CGVector, Diagram)
}


extension Diagram {
    
    /// 获取整个画布的大小
    var size: CGSize {
        switch self {
        case .Prim(let size, _):
            return size
        case .Attributed(_, let r):
            return r.size
        case .Beside(let l, let r):
            let sizeL = l.size
            let sizeR = r.size
            return CGSize(width: sizeL.width+sizeR.width, height: max(sizeL.height, sizeR.height))
        case .Below(let l, let r):
            let sizeL = l.size
            let sizeR = r.size
            return CGSize(width: max(sizeL.width, sizeR.width), height: sizeL.height+sizeR.height)
        case .Align(_, let r):
            return r.size
        }
    }
}

/// 一些方便计算的扩展
extension CGVector {
    var point: CGPoint {
        return CGPoint(x: dx, y: dy)
    }
    
    var size: CGSize {
        return CGSize(width: dx, height: dy)
    }
}

extension CGPoint {
    static func -(l: CGPoint, r: CGPoint) -> CGPoint {
        return CGPoint(x: l.x - r.x, y: l.y - r.y)
    }
}

extension CGSize {
    /// 扩展一些计算方式
    static func *(l: CGFloat, r: CGSize) -> CGSize {
        return CGSize(width: l * r.width, height: l * r.height)
    }
    
    static func /(l: CGSize, r: CGSize) -> CGSize {
        return CGSize(width: l.width / r.width, height: l.height / r.height)
    }
    
    static func *(l: CGSize, r: CGSize) -> CGSize {
        return CGSize(width: l.width * r.width, height: l.height * r.height)
    }
    
    static func -(l: CGSize, r: CGSize) -> CGSize {
        return CGSize(width: l.width - r.width, height: l.height - r.height)
    }
    
    var point: CGPoint {
        return CGPoint(x: self.width, y: self.height)
    }
    
    /// 适配函数
    /*
     * 例如：
     * CGSize(width: 1, height: 1).fit (
            CGVector(dx: 0.5, dy: 0.5), CGRect(x: 0, y: 0, width: 100, height: 200)// 在100*200的图层中剧中显示一个1*1的点
        )
     */
    func fit(vector: CGVector, _ rect: CGRect) -> CGRect {
        let scaleSize = rect.size / self// 大小比
        let scale = min(scaleSize.width, scaleSize.height)// 长宽比例
        let size = scale * self
        let space = vector.size * (size - rect.size)
        return CGRect(origin: rect.origin - space.point, size: size)
    }
}
