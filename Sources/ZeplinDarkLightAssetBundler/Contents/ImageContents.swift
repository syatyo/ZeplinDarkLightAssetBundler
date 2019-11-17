//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

/// The represention of Contents.json
struct ImageContents: Codable {
    
    /// The meta information about colorset
    let info: Info

    /// The images of  contens
    let images: [Image]
}
