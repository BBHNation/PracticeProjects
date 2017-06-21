import Foundation
import CoreImage
import UIKit



/// 关键内容，定义类型，输入一个CIImage，输出一个CIImage
public struct Filter {
    public var filt : (CIImage) -> CIImage
    public init(f : @escaping (CIImage)->CIImage) {
        filt = f
    }
}

infix operator >>>: AdditionPrecedence

extension Filter {
    
    /// 高斯模糊透镜
    ///
    /// - Parameter radius: 输入一个模糊半径
    /// - Returns: 返回一个能够实现高斯透镜的Filter
    public static func blur(radius : Double) -> Filter {
        return Filter.init(f: { (image) -> CIImage in
            let parameters : [String : Any] = [
                kCIInputRadiusKey : radius,
                kCIInputImageKey : image
            ]
            
            guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parameters) else { fatalError() }
            guard let outPutImage = filter.outputImage else { fatalError() }
            return outPutImage
        })
    }
    
    /// 颜色生成器
    ///
    /// - Parameter color: 需要生成的颜色
    /// - Returns: 返回添加这个颜色的滤镜
    public static func colorGenerator(color : UIColor) -> Filter{
        return Filter.init(f: { _ in
            let c = CIColor(color: color)
            let parameters = [kCIInputColorKey : c]
            guard let filter = CIFilter(name: "CIConstantColorGenerator", withInputParameters: parameters) else { fatalError() }
            guard let outputImage = filter.outputImage else { fatalError() }
            return outputImage
        })
    }
    
    
    
    
    
    /// 组合叠加函数
    ///
    /// - Parameter overlay: 需要叠加的Image
    /// - Returns: 返回能够实现将image和overlay两个图片叠加的滤镜
    public static func compositeSourceOver(overlay : CIImage) -> Filter {
        return Filter.init(f: { (image) -> CIImage in
            let parameters = [
                kCIInputBackgroundImageKey : image,
                kCIInputImageKey : overlay
            ]
            guard let filter = CIFilter(name: "CISourceOverCompositing", withInputParameters: parameters) else { fatalError() }
            guard let outputImage = filter.outputImage else { fatalError() }
            let cropRect = image.extent
            return outputImage.cropping(to: cropRect)
        })
    }
    
    
    
    /// 生成叠加颜色的滤镜
    ///
    /// - Parameter color: 需要叠加的颜色
    /// - Returns: 生成的滤镜，滤镜的作用是将滤镜输入的图片叠加一个固定的颜色
    public static func colorOverlay(color : UIColor) -> Filter {
        return Filter.init(f: { (image) -> CIImage in
            let overlay = self.colorGenerator(color: color).filt(image)//这里得到的是一个通过颜色滤镜的图片
            return self.compositeSourceOver(overlay: overlay).filt(image)
        })
    }
    
    /// 组合两个滤镜
    ///
    /// - Parameters:
    ///   - filter1: 第一滤镜
    ///   - filter2: 第二个滤镜
    /// - Returns: 返回合成的两个滤镜之后的一个滤镜
    public static func composeFilters(filter1 : Filter, filter2 : Filter) -> Filter {
        return Filter.init(f: { (image) -> CIImage in
            return filter2.filt(filter1.filt(image))
        })
    }
    
    /// 重载运算符
    ///
    /// - Parameters:
    ///   - filter1: 滤镜一
    ///   - filter2: 滤镜二
    /// - Returns: 返回新的滤镜
    public static func >>> (filter1 : Filter, filter2 : Filter) -> Filter {
        return Filter.init(f: { (image) -> CIImage in
            return filter2.filt(filter1.filt(image))
        })
    }
    
}














