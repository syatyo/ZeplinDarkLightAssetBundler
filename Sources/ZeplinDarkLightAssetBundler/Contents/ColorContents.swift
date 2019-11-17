//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

/// The represention of Contents.json
struct ColorContents: Codable {
    
    /// The meta information about colorset
    let info: Info
    
    /// The colors of contents
    let colors: [Color]
    
}
