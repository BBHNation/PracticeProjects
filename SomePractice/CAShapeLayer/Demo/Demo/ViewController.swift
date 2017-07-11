//
//  ViewController.swift
//  Demo
//
//  Created by 白彬涵 on 2017/7/10.
//  Copyright © 2017年 MR White. All rights reserved.
//

import UIKit
import CircleAnimation

class ViewController: UIViewController {

    @IBOutlet weak var circleView: DrewCircleView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let layer = CALayer()
        
        layer.frame = CGRect(x: 75, y: 75, width: 150, height: 150)
        layer.backgroundColor = UIColor.darkGray.cgColor
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        
        let contactShadowSize: CGFloat = 20
        let shadowPath = CGPath(ellipseIn: CGRect(x: -contactShadowSize,
                                                  y: -contactShadowSize * 0.5,
                                                  width: layer.bounds.width + contactShadowSize * 2,
                                                  height: contactShadowSize),
                                transform: nil)
        
        layer.shadowPath = shadowPath
        
        self.view.layer.addSublayer(layer)
 */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

