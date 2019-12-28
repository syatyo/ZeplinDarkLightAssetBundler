//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/12/28.
//

import Foundation

/// Processing data to simplify handling it.
struct Preprocesser {
    
    /// The source xcassets
    var assets: XCAssets
    
    /// The default appearance that zeplin exported is nil. so, We need to set light/dark appearance from outside.
    mutating func setAppearances() {
    }
    
}
