//
//  ImageFlowLayout.swift
//  ImageViewer
//
//  Created by 白彬涵 on 2017/4/20.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import UIKit

class ImageFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        self.itemSize = CGSize.init(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.minimumLineSpacing = 0;
        self.scrollDirection = .horizontal
        self.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func change(count : Int) {
        let width : Int = Int(UIScreen.main.bounds.size.width)
        let height : Int = Int(UIScreen.main.bounds.size.height)
        self.itemSize = CGSize.init(width: width, height: height)
        self.collectionView?.setContentOffset(CGPoint.init(x: count * width, y: 0), animated: false)
        self.collectionView?.reloadData()
    }
    
}
