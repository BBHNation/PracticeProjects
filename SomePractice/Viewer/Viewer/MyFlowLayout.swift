//
//  MyFlowLayout.swift
//  Viewer
//
//  Created by 白彬涵 on 2017/5/24.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import UIKit

class MyFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        self.itemSize = CGSize.init(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height)
        self.minimumLineSpacing = 0
        self.scrollDirection = .horizontal
    }
    
    func change(count : Int) {
        let width : Int = Int(UIScreen.main.bounds.size.width)
        let height : Int = Int(UIScreen.main.bounds.size.height)
        self.itemSize = CGSize.init(width: width, height: height)
        self.collectionView?.setContentOffset(CGPoint.init(x: count * width, y: 0), animated: false)
        self.collectionView?.reloadData()
    }
}
