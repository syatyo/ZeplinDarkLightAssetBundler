//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/17.
//

import Foundation

/// Image representation of `Contents.json` in `imageset`
struct Image: Codable {
    
    /// The idiom of image. e.g. universal
    let idiom: String
    
    /// The filename of image
    let filename: String
    
    /// The appearances of image
    let appearances: [Appearance]?
    
    /// The scale of image. e.g. 1x, 2x, 3x
    let scale: String
}

extension Image: Comparable {
    
    public static func < (lhs: Image, rhs: Image) -> Bool {
        return lhs.scale < rhs.scale
    }
    
    
}
