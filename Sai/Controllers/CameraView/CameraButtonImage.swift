//
//  CameraButtonImage.swift
//  Sai
//
//  Created by 保坂篤志 on 2023/03/06.
//

import SwiftUI

struct CameraButtonImage: View {
    
    var radius: Double
    @ObservedObject var cameraButtonModel: CameraButtonModel
    
    var body: some View {
        
        ZStack {
            Circle()
                .stroke(
                    .white,
                    lineWidth: 4
                )
                .frame(width: radius)
            
            Circle()
                .fill(.white)
                .frame(width: cameraButtonModel.isPressed ? radius - 18 : radius - 8)
            
//                .simultaneousGesture(
//                    DragGesture(minimumDistance: 0)
//                        .onChanged({ _ in
//                            cameraButtonModel.isPressed = true
//                        })
//                        .onEnded({ _ in
//                            cameraButtonModel.isPressed = false
//                        })
//                )
//            
        }
    }
}

struct CameraButtonImage_Previews: PreviewProvider {
    static var previews: some View {
        CameraButtonImage(radius: 58, cameraButtonModel: CameraButtonModel())
        
    }
}
