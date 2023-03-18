//
//  CameraButton.swift
//  Sai
//
//  Created by 保坂篤志 on 2023/03/06.
//

import UIKit
import SwiftUI

class CameraButtonModel: ObservableObject {
    @Published var isPressed: Bool = false
}

class CameraButton: UIView {
    
    var cameraButtonModel = CameraButtonModel()
    
    var delegate: CameraButtonDelegate? = nil
    
    var hostingController: UIHostingController<CameraButtonImage>?
    
    func setupButton() {

        for view in self.subviews {
            view.removeFromSuperview()
        }

        let cameraButtonImage = CameraButtonImage(radius: min(self.bounds.width, self.bounds.height), cameraButtonModel: cameraButtonModel)

        hostingController = UIHostingController(rootView: cameraButtonImage)
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
        
        if let delegate {
            delegate.onPressed()
        }
    }
    
    func released() {
        updateImage(isPressed: false)
        
        if let delegate {
            delegate.onRelased()
        }
    }
    
    func updateImage(isPressed: Bool) {
        cameraButtonModel.isPressed = isPressed
    }
}

protocol CameraButtonDelegate {
    
    func onPressed()
    func onRelased()
}
