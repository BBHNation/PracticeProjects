//
//  ViewController.swift
//  QRCodeDemo
//
//  Created by 白彬涵 on 2017/10/18.
//  Copyright © 2017年 CMIOT. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    @IBOutlet weak var contentLabel: UILabel!
}

// MARK: - Life Circle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initCaptureDevice()
        initQrCodeView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


// MARK: - Some Functions
extension ViewController {
    func initCaptureDevice() {
        // 初始化一个设备对象
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            // 使用设备对象初始化输入
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            
            // 给Session设置输入
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            // 输出的设置
            let captureMetadataOutput = AVCaptureMetadataOutput()
            
            
            // 给Session设置输出
            captureSession?.addOutput(captureMetadataOutput)
            
            // 需要先给Session设置output，才可以设置类型
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        } catch {
            print(error)
            return
        }
        
        // 设置预览layer
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        // Session开始工作
        captureSession?.startRunning()
    }
    
    func initQrCodeView() {
        qrCodeFrameView = UIView()
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubview(toFront: qrCodeFrameView)
        }
        view.bringSubview(toFront: contentLabel)
    }
}


// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension ViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // 如果为空，则直接返回
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            contentLabel.text = "没有扫描到二维码"
            return
        }
        
        // 获取到metadata object
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr  {
            // 如果找到了QRCode 的数据
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            // 截取metadata 对象的string内容
            if metadataObj.stringValue != nil {
                print(metadataObj.stringValue!)
                contentLabel.text = metadataObj.stringValue!
            }
        }
    }
}
