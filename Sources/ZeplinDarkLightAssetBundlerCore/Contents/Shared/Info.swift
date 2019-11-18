//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

/// Meta Information of Contents.json
struct Info: Codable {
    
    /// The version of contents
    var version: Int
    
    /// The author of contents
    var author: String
}
