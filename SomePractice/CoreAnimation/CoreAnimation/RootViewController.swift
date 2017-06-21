//
//  RootViewController.swift
//  CoreAnimation
//
//  Created by 白彬涵 on 2017/6/19.
//  Copyright © 2017年 MR White. All rights reserved.
//

import UIKit


class RootViewController: UIViewController {

    var layer : CALayer? = nil
    var view1 : UIView? = nil
    var view2 : UIView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layer = CALayer()
        layer?.frame = CGRect(x: ScreenW/2-50, y: ScreenH/2-50, width: 100, height: 100)
        layer?.backgroundColor = UIColor.black.cgColor
//        self.view.layer.addSublayer(layer!)
//        addAnimation()
//        addKeyAnimation()
        view1 = UIView.init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view1?.backgroundColor = UIColor.orange
        
        view2 = UIView.init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view2?.backgroundColor = UIColor.blue
        self.view.addSubview(view1!)
        self.view.addSubview(view2!)
    }
    
    /// 过渡动画
    private func addTransition() {
        
        let transition = CATransition()
        transition.startProgress = 0.5
        transition.endProgress = 1.0
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 2.0
        
        view1?.layer.add(transition, forKey: "transition")
        view2?.layer.add(transition, forKey: "transition")
        
        
        view1?.isHidden = false
        view2?.isHidden = true
    }
    
    
    @IBAction func action(_ sender: Any) {
        addTransition()
    }
    /// 普通显式动画
    private func addAnimation() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1.0
        animation.byValue = 0.7
        
        layer?.add(animation, forKey: "opacity")
        layer?.opacity = 1.0
    }
    
    
    /// 关键帧动画
    private func addKeyAnimation() {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 100, y: 100))
        path.addCurve(to: CGPoint(x: 300, y: 100), control1: CGPoint(x: 300, y: 500), control2: CGPoint(x: 100, y: 500))
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path
        animation.duration = 3.0
        animation.timingFunctions = [CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)]
        
        layer?.add(animation, forKey: "position")
        layer?.position = CGPoint(x: 300, y: 100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
