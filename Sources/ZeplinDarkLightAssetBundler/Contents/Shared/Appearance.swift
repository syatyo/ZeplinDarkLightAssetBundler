//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

/// Aappearance of item
struct Appearance: Codable, Hashable {
    
    /// The type of appearance.(e.g. luminosity)
    ///
    /// I don't know well about this property
    let appearance: String
    
    /// The color mode's value of appearance. When value is nil, it represent `any`
    let value: ColorMode?
    
    init?(appearance: String, value: ColorMode?) {
        guard value != nil else {
            return nil
        }
        
        self.appearance = appearance
        self.value = value
    }
    
    init?(value: ColorMode?) {
        guard value != nil else {
            return nil
        }

        self.appearance = "luminosity"
        self.value = value
    }
    
}
