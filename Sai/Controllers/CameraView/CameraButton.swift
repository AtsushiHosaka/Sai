//
//  CameraButton.swift
//  Sai
//
//  Created by 保坂篤志 on 2023/03/06.
//

import UIKit
import SwiftUI

class CameraButton: UIButton {
    
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
    }
    
    func pressed() {
        
        cameraButtonImage?.isPressed = true
    }
    
    func released() {
        
        
    }
}
