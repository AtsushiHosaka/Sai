//
//  ColorDataManager.swift
//  Sai
//
//  Created by 保坂篤志 on 2023/03/06.
//

import Foundation

class ColorDataManager {
    
    static let shared = ColorDataManager()
    
    var redFilterValue: Float? = 0
    var greenFilterValue: Float? = 0
    var blueFilterValue: Float? = 0
    
    var redFilterArray: [CGFloat]? {
        
        if let redFilterValue {
            return [CGFloat(redFilterValue), 0, 0, 0, 0, 0, 0, 0, 0, 0]
        }else {
            return nil
        }
    }
    var greenFilterArray: [CGFloat]? {
        
        if let greenFilterValue {
            return [0, CGFloat(greenFilterValue), 0, 0, 0, 0, 0, 0, 0, 0]
        }else {
            return nil
        }
    }
    var blueFilterArray: [CGFloat]? {
        
        if let blueFilterValue {
            return [0, 0, CGFloat(blueFilterValue), 0, 0, 0, 0, 0, 0, 0]
        }else {
            return nil
        }
    }
    
    private init() {
        
        for key in UserDefaultsColorKey.allCases {

            UserDefaults.standard.register(defaults: [key.rawValue: 1])
        }
    
        redFilterValue = UserDefaultsColorKey[.red]
        greenFilterValue = UserDefaultsColorKey[.green]
        blueFilterValue = UserDefaultsColorKey[.blue]
    }
    
    func setRGBFilterValue(red: Float, green: Float, blue: Float) {
        
        UserDefaultsColorKey[.red] = red
        UserDefaultsColorKey[.green] = green
        UserDefaultsColorKey[.blue] = blue
        
        redFilterValue = red
        greenFilterValue = green
        blueFilterValue = blue
    }
    
    enum UserDefaultsColorKey: String, CaseIterable {
        
        case red
        case green
        case blue
        
        static subscript<T>(key: Self, type: T.Type = T.self) -> T? {
            
            get {
                UserDefaults.standard.object(forKey: key.rawValue) as? T
            }
            
            set {
                UserDefaults.standard.set(newValue, forKey: key.rawValue)
            }
        }
    }
}
