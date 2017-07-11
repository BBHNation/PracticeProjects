//
//  DrewCircleView.swift
//  CircleAnimation
//
//  Created by 白彬涵 on 2017/7/10.
//  Copyright © 2017年 MR White. All rights reserved.
//

import UIKit

let redColor_alpha = UIColor.init(red: 1.0, green: 0.2, blue: 0.2, alpha: 0.3).cgColor
let greenColor_alpha = UIColor.init(red: 0.2, green: 1.0, blue: 0.2, alpha: 0.3).cgColor
let blueColor_alpha = UIColor.init(red: 0.2, green: 0.2, blue: 1.0, alpha: 0.3).cgColor

let redColor = UIColor.init(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0).cgColor
let greenColor = UIColor.init(red: 0.2, green: 1.0, blue: 0.2, alpha: 1.0).cgColor
let blueColor = UIColor.init(red: 0.2, green: 0.5, blue: 1.0, alpha: 1.0).cgColor

public class DrewCircleView: UIView, CAAnimationDelegate {

    var redCircleLayer: CALayer?
    var greenCircleLayer: CALayer?
    var blueCircleLayer: CALayer?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        let length = min(rect.size.width, rect.size.height)
        // 创建Layer
        // 绘制底层Layers
        self.layer.addSublayer(circleLayerWith(color: redColor_alpha, radius: length/2 - length/8, viewWidth: length, percent: 1.0))
        self.layer.addSublayer(circleLayerWith(color: greenColor_alpha, radius: length/2 - length/4, viewWidth: length, percent: 1.0))
        self.layer.addSublayer(circleLayerWith(color: blueColor_alpha, radius: length/2 - length*3/8, viewWidth: length, percent: 1.0))
        
        // 绘制上层Layers并添加动画
        redCircleLayer = circleLayerWith(color: redColor, radius: length/2 - length/8, viewWidth: length, percent: 0.8).addCircleAnimation(duration: 3.0).1.addShadow()
        greenCircleLayer = circleLayerWith(color: greenColor, radius: length/2 - length/4, viewWidth: length, percent: 0.7).addCircleAnimation(duration: 3.0).1.addShadow()
        blueCircleLayer = circleLayerWith(color: blueColor, radius: length/2 - length*3/8, viewWidth: length, percent: 0.9).addCircleAnimation(duration: 3.0).1.addShadow()
        
        
        // 添加动画
        self.layer.addSublayer(redCircleLayer!.addGradientLayer(rect: rect))
        self.layer.addSublayer(greenCircleLayer!)
        self.layer.addSublayer(blueCircleLayer!)
    }
    
    
    /// 创建一个圆圈Layer，但是还没有动画
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - radius: 半径
    ///   - viewWidth: 视图宽度
    ///   - percent: 百分比
    /// - Returns: 返回一个CAShapeLayer
    private func circleLayerWith(color: CGColor, radius: CGFloat, viewWidth: CGFloat, percent: CGFloat) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = viewWidth/8 - 10
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        layer.strokeColor = color
        let path = UIBezierPath.init(arcCenter: CGPoint.init(x: viewWidth/2, y: viewWidth/2),
                                     radius: radius,
                                     startAngle: -CGFloat.pi*0.5,
                                     endAngle: CGFloat.pi*2*percent-CGFloat.pi*0.5,
                                     clockwise: true)
        layer.path = path.cgPath
        return layer
    }
    
    public func drewThreeCircleWith(redPercent: Double, greenPercent: Double, bluePercent: Double) {
        
    }
}


extension CAShapeLayer {
    func addCircleAnimation(duration: TimeInterval) -> (CAAnimation, CAShapeLayer) {
        // 创建动画
        let animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = duration
        self.add(animation, forKey: "strokeEndAnimation")
        return (animation, self)
    }
    
    func addShadow() -> CALayer {
        // Create shadow layer
        let shadowLayer = CALayer()
        shadowLayer.frame = self.frame
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize.zero
        shadowLayer.shadowRadius = 10
        shadowLayer.shadowOpacity = 1.0
        shadowLayer.backgroundColor = UIColor.clear.cgColor
        shadowLayer.insertSublayer(self, at: 0)
        
        // Shadow path animation
        let shadowPathAnimation: CABasicAnimation = CABasicAnimation(keyPath: "shadowPath")
        shadowPathAnimation.fromValue = 0.0
        shadowPathAnimation.toValue = self.path
        shadowLayer.add(shadowPathAnimation, forKey: "shadowPathAnimation")
        
        return shadowLayer
    }
}

extension CALayer {
    
    func addGradientLayer(rect: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = rect
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.mask = self
        return gradientLayer
    }
}
