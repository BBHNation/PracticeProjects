//: Playground - noun: a place where people can play

import Foundation
import UIKit
let image = CIImage(contentsOf: URL.init(string: "http://www.objc.io/images/covers/16.jpg")!)
let finalImage = Filter.blur(radius: 5)
let finalFinalImgae = Filter.colorOverlay(color: .black)
let finelFileter = finalImage >>> finalFinalImgae
let i = finelFileter.filt(image)

