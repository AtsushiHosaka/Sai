//
//  CameraButtonImage.swift
//  Sai
//
//  Created by 保坂篤志 on 2023/03/06.
//

import SwiftUI

struct CameraButtonImage: View {
    
    var radius: Double
    var isPressed: Bool
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .stroke(
                    .white,
                    lineWidth: 4
                )
                .frame(width: radius + 8)
            
            if isPressed {
                Circle()
                    .fill(.white)
                    .frame(width: radius - 10)
            }else {
                Circle()
                    .fill(.white)
                    .frame(width: radius)
            }
        }
    }
}

struct CameraButtonImage_Previews: PreviewProvider {
    static var previews: some View {
        CameraButtonImage(radius: 50, isPressed: true)
            
    }
}
