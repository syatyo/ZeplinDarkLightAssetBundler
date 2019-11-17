//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

/// Aappearance of item
struct Appearance: Codable {
    
    /// The type of appearance.(e.g. luminosity)
    ///
    /// I don't know well about this property
    let appearance: String
    
    /// The color mode's value of appearance.
    let value: ColorMode
}
