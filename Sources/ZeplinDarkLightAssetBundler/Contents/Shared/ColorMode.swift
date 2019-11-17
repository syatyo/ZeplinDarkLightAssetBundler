//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/17.
//

import Foundation

/// Color mode of an asset
enum ColorMode: String, Codable, Equatable {
    case light
    case dark
    
    /// initialize `ColorMode` from string. If you pass neigher light nor dark, the initialized value is `any`
    init?(rawValue: String, allowsLightMode: Bool) {
        if allowsLightMode {
            switch rawValue {
            case ColorMode.light.rawValue:
                self = .light
                
            case ColorMode.dark.rawValue:
                self = .dark
                
            default:
                return nil
            }
        } else {
            switch rawValue {                
            case ColorMode.dark.rawValue:
                self = .dark
                
            default:
                return nil
            }
        }
    }
}
