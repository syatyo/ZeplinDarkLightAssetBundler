//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

/// This represent Contents.json of imageset
struct ImageContents: Codable {
    let info: Info
    let images: [Image]
    
    struct Image: Codable {
        var idiom: String
        var filename: String
        var scale: String
    }
    
}
