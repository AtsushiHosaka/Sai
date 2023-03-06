//
//  logger.swift
//  logger
//
//  Created by 保坂篤志 on 2023/02/28.
//

import Foundation

func logger(_ title: String? = nil, _ items: Any..., spacer: String = "") {
    
    print("\n")
    
    if let title {
        print("----", title, "----")
    }
    
    print("↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓\n")
    
    for (i, item) in items.enumerated() {
        print(item)
        
        if i != items.count - 1 {
            print(spacer)
        }
    }
    
    print("\n↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑")
}

func loggerObject(title: String? = nil, _ items: Any..., spacer: String = "") {
    
    print("\n")
    
    if let title {
        print("----", title, "----")
    }
    
    print("↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓\n")
    
    for (i, item) in items.enumerated() {
        dump(item)
        
        if i != items.count - 1 {
            print(spacer)
        }
    }
    
    print("\n↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑")
}
