//
//  ViewController.swift
//  Core ML Demo
//
//  Created by 白彬涵 on 2017/9/18.
//  Copyright © 2017年 CMIOT. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {
    let mlmodel = Resnet50()

    override func viewDidLoad() {
        super.viewDidLoad()
        let buffer = ImageProcessor.pixelBuffer(forImage: #imageLiteral(resourceName: "plane").cgImage!)
        let result = try? mlmodel.prediction(image: buffer!)
        print(result?.classLabel ?? "nil")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

