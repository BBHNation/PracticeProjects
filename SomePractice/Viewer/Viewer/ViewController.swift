//
//  ViewController.swift
//  Viewer
//
//  Created by 白彬涵 on 2017/5/24.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addnotification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.sharedModel.urls().count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let imageView = cell.viewWithTag(1024) as! UIImageView
        imageView.sd_setImage(with: URL.init(string: Model.sharedModel.urls()[indexPath.row]))
        return cell
    }
    
    
    func addnotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChange), name: .UIApplicationDidChangeStatusBarOrientation, object: nil)
    }
    
    func orientationChange() {
        let layout = self.collectionView?.collectionViewLayout as! MyFlowLayout
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let count = ((self.collectionView?.contentOffset.x)! + 146) / height
        print("count is :\(count) and height is:\(height) and width is:\(width) and offset is:\(String(describing: self.collectionView?.contentOffset.x))")
        layout.change(count: Int(count))
    }

}

