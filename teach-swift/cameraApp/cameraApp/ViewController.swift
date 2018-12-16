//
//  ViewController.swift
//  cameraApp
//
//  Created by 大江祥太郎 on 2018/12/16.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class ViewController: UIViewController {
    

    //AVCaputureの立ち上げ
    var captureSession = AVCaptureSession()
    //バックカメラかフロントカメラか現在のカメラかの選択
    var backCamera:AVCaptureDevice?
    var frontCamera:AVCaptureDevice?
    var currentCamera:AVCaptureDevice?
    
    //写真のアウトプット
    var Output:AVCapturePhotoOutput?
    
    var PreviewLayer:AVCaptureVideoPreviewLayer?
    
    //撮影したものの入る箱
    var image :UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //カメラの許可を出す
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status){
            case .notDetermined:
                print("notDetermined")
                
            case .restricted:
                print("restricted")
                
            case .denied:
                print("denied")
            case .authorized:
                print("許可")
            }
            
        }
        
        DispatchQueue.main.async {
            self.setUpCaptureSession()
            self.setUpDevice()
            self.setUpInputOutput()
            self.setUpPreviewLayer()
            self.startRunningCaptureSession()
        }
        
        
    }
    func setUpCaptureSession(){
        //sessionPresetはカメラの画質を決定する値を設定します。
        //sessionPreset値は公式リファレンスに列挙されています。
        //今回は、高解像度の画像出力ができるphotoを設定します。
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setUpDevice(){
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes:[AVCaptureDevice.DeviceType.builtInWideAngleCamera],mediaType:AVMediaType.video,position:AVCaptureDevice.Position.unspecified
        )
        
        let device = deviceDiscoverySession.devices
        for device in device{
            if device.position == AVCaptureDevice.Position.back{
                backCamera = device
            }else if device.position == AVCaptureDevice.Position.back{
                frontCamera = device
                
            }
        }
        
        currentCamera = backCamera
        
        
    }
    
    func setUpInputOutput(){
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            
            Output = AVCapturePhotoOutput()
            
            photoOutput.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format:[AVVideoCodecKey:AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSessi0on.addOutput(photoOutput)
            
        } catch  {
            print(error)
        }
        
    }
    
    func setUpPreviewLayer(){
        PreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        PreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        PreviewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        PreviewLayer.frame = self.view.frame
        self.view.layer.insertSublayer(PreviewLayer, at: 0)
        
    }
    
    func startRunningCaptureSession(){
        captureSession.startRunning()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            
            let preVC = segue.destination as! PreViewController
            preVC.image = self.image!
        }
    }
    
    
    @IBAction func cameraButton(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if let imageDate = photo.fileDataRepresentation(){
            
            image = UIImage(data: imageDate)!
            performSegue(withIdentifier: "next", sender: nil)
            
        }
    }



}

