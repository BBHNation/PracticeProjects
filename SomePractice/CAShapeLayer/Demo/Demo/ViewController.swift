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

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = DrewCircleView()
        view.frame = CGRect.init(x: 100, y: 100, width: 200, height: 200)
        self.view.addSubview(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

