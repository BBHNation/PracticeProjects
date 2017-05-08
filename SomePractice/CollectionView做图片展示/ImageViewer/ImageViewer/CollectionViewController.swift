//
//  CollectionViewController.swift
//  ImageViewer
//
//  Created by 白彬涵 on 2017/4/20.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addnotification()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.allowOrentation = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.allowOrentation = false
    }
    
    func addnotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChange), name: .UIApplicationDidChangeStatusBarOrientation, object: nil)
    }
    
    func orientationChange() {
        let layout = self.collectionView?.collectionViewLayout as! ImageFlowLayout
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let count = ((self.collectionView?.contentOffset.x)! + 146) / height
        print("count is :\(count) and height is:\(height) and width is:\(width) and offset is:\(String(describing: self.collectionView?.contentOffset.x))")
        layout.change(count: Int(count))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (ImagesModel.sharedModel.imagesArray?.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let imageView = cell.viewWithTag(1024) as! UIImageView
        imageView.image = ImagesModel.sharedModel.imagesArray![indexPath.row] as? UIImage
        return cell
    }
}
