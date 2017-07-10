//
//  DrewCircleView.swift
//  CircleAnimation
//
//  Created by 白彬涵 on 2017/7/10.
//  Copyright © 2017年 MR White. All rights reserved.
//

import UIKit

public class DrewCircleView: UIView, CAAnimationDelegate {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        
        // 创建Layer
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 20.0
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        layer.strokeColor = UIColor.red.cgColor
        self.layer.addSublayer(layer)
        
        // 创建贝塞尔路径
        let length = min(rect.size.width, rect.size.height)
        let path = UIBezierPath.init(arcCenter: CGPoint.init(x: length/2, y: length/2), radius: length/2 - 20, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: false)
        
        // 关联贝塞尔路径和layer
        layer.path = path.cgPath
        
        
        // 创建动画
        let animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        layer.autoreverses = false
        animation.duration = 3.0
        animation.delegate = self
        
        layer.add(animation, forKey: "strokeEndAnimation")
    }
    
}
