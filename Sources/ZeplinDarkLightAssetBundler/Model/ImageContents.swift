//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

/// This represent Contents.json of imageset
struct ImageContents: Codable {
    let images: [Image]
    let info: Info
    
    struct Image: Codable {
        let idiom: String
        let filename: String
        let appearances: [AppearanceSet]?
        let scale: String
    }
    
}
