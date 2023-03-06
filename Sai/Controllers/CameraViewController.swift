//
//  ViewController.swift
//  Sai
//
//  Created by 保坂篤志 on 2023/03/03.
//

import UIKit
import AVFoundation

import PKHUD

class CameraViewController: UIViewController {
    
    let colorDataManager = ColorDataManager.shared
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    var orientation: AVCaptureVideoOrientation = .portrait
    
    let context = CIContext()
    
    @IBOutlet weak var cameraView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraView.frame = view.frame
        
        setupDevice()
        setupInputOutput()
    }
    
    override func viewDidLayoutSubviews() {
        
        orientation = AVCaptureVideoOrientation.portrait
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard getFilterValue() else {
            
            HUD.flash(.labeledError(title: "エラー", subtitle: "フィルターの取得に失敗しました"), delay: 2.0)
            
            return
        }
        
        startSession()
        checkAuthorize()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        stopSession()
    }
    
    private func getFilterValue() -> Bool {
        
        guard colorDataManager.redFilterArray != nil &&
              colorDataManager.greenFilterArray != nil &&
              colorDataManager.blueFilterArray != nil
        else {
            return false
        }
        
        return true
    }
    
    @IBAction func testbutton() {
        
        performSegue(withIdentifier: SegueKey.toSettingView.rawValue, sender: nil)
    }
}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func checkAuthorize() {
        
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) != .authorized {
            
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (authorized) in
                
                DispatchQueue.main.async {
                    
                    if authorized {
                        self.setupInputOutput()
                    }
                }
            })
        }
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            }
            else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        
        currentCamera = backCamera
    }
    
    func setupInputOutput() {
        do {
            setupCorrectFramerate(currentCamera: currentCamera!)
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080
            if captureSession.canAddInput(captureDeviceInput) {
                captureSession.addInput(captureDeviceInput)
            }
            let videoOutput = AVCaptureVideoDataOutput()
            
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer delegate", attributes: []))
            if captureSession.canAddOutput(videoOutput) {
                captureSession.addOutput(videoOutput)
            }
        } catch {
            loggerObject("setupInputOutput Error", error)
        }
    }
    
    func startSession() {
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
    func stopSession() {
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.stopRunning()
        }
    }
    
    func setupCorrectFramerate(currentCamera: AVCaptureDevice) {
        for vFormat in currentCamera.formats {
            
            let ranges = vFormat.videoSupportedFrameRateRanges as [AVFrameRateRange]
            let frameRates = ranges[0]
            
            do {
                if frameRates.maxFrameRate == 240 {
                    try currentCamera.lockForConfiguration()
                    currentCamera.activeFormat = vFormat as AVCaptureDevice.Format
                    currentCamera.activeVideoMinFrameDuration = frameRates.minFrameDuration
                    currentCamera.activeVideoMaxFrameDuration = frameRates.maxFrameDuration
                }
            }
            catch {
                loggerObject("Could not set active format", error)
            }
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        connection.videoOrientation = orientation
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        
        /* フィルタを読み込む */
        let clearFilter = CIFilter(name: "CIColorCrossPolynomial")
        
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let cameraImage = CIImage(cvImageBuffer: pixelBuffer!)
        
        clearFilter!.setValue(CIVector(values: colorDataManager.redFilterArray!, count: 10), forKey: "inputRedCoefficients")
        clearFilter!.setValue(CIVector(values: colorDataManager.greenFilterArray!, count: 10), forKey: "inputGreenCoefficients")
        clearFilter!.setValue(CIVector(values: colorDataManager.blueFilterArray!, count: 10), forKey: "inputBlueCoefficients")
        
        clearFilter!.setValue(cameraImage, forKey: kCIInputImageKey)
        
        let cgImage = self.context.createCGImage(clearFilter!.outputImage!, from: cameraImage.extent)!
        
        DispatchQueue.main.async {
            let filteredImage = UIImage(cgImage: cgImage)
            self.cameraView.image = filteredImage
        }
    }
}
