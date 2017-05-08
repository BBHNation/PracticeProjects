//
//  ImagesModel.swift
//  ImageViewer
//
//  Created by 白彬涵 on 2017/4/20.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import UIKit

class ImagesModel: NSObject {
    
    static let sharedModel = ImagesModel()
    
    var imagesArray : NSMutableArray? {
        get {
            return NSMutableArray(array: [UIImage.init(named: "1")!,UIImage.init(named: "2")!,UIImage.init(named: "3")!,UIImage.init(named: "4")!,UIImage.init(named: "5")!])
        }
    }
    
}
