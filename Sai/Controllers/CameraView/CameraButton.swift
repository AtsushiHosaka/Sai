//
//  CameraButton.swift
//  Sai
//
//  Created by 保坂篤志 on 2023/03/06.
//

import UIKit
import SwiftUI

class CameraButton: UIView {
    
    var delegate: CameraButtonDelegate? = nil
    
    var hostingController: UIHostingController<CameraButtonImage>?
    var cameraButtonImage: CameraButtonImage?
    
    func setupButton() {
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        cameraButtonImage = CameraButtonImage(radius: min(self.bounds.width, self.bounds.height), isPressed: false)
        
        hostingController = UIHostingController(rootView: cameraButtonImage!)
        self.addSubview(hostingController!.view)
        
        hostingController?.view.backgroundColor = .clear
        hostingController?.view.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))

        let onPressedAction = UIAction(handler: { _ in self.pressed() })
        let onReleasedAction = UIAction(handler: { _ in self.released() })

        button.addAction(onPressedAction, for: .touchDown)
        button.addAction(onReleasedAction, for: .touchUpInside)

        self.addSubview(button)
    }
    
    func pressed() {
        updateImage(isPressed: true)
    }
    
    func released() {
        updateImage(isPressed: false)
    }
    
    func updateImage(isPressed: Bool) {
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        cameraButtonImage = CameraButtonImage(radius: min(self.bounds.width, self.bounds.height), isPressed: isPressed)
        
        hostingController = UIHostingController(rootView: cameraButtonImage!)
        self.addSubview(hostingController!.view)
        
        hostingController?.view.backgroundColor = .clear
        hostingController?.view.translatesAutoresizingMaskIntoConstraints = false
        
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
//
//        let onPressedAction = UIAction(handler: { _ in self.pressed() })
//        let onReleasedAction = UIAction(handler: { _ in self.released() })
//
//        button.addAction(onPressedAction, for: .touchDown)
//        button.addAction(onReleasedAction, for: .touchUpInside)
//
//        self.addSubview(button)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
////        updateImage(isPressed: true)
////
////        if let delegate {
////            
////            delegate.onPressed()
////        }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//
//    }
//
//
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        updateImage(isPressed: false)
//
//        if let delegate {
//
//            delegate.onRelased()
//        }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        updateImage(isPressed: false)
//
//        if let delegate {
//
//            delegate.onRelased()
//        }
//    }
}

protocol CameraButtonDelegate {
    
    func onPressed()
    func onRelased()
}
