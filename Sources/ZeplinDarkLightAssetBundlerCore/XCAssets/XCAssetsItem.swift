//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/17.
//

import Foundation

/// Item in xcassets
enum XCAssetsItem {
    case colorset(Colorset)
    case imageset(Imageset)
}

extension Collection where Self.Element == XCAssetsItem {
    
    var colorset: [Colorset] {
        return compactMap {
            if case .colorset(let value) = $0 {
                return value
            } else {
                return nil
            }
        }
    }
    
    var imageset: [Imageset] {
        return compactMap {
            if case .imageset(let value) = $0 {
                return value
            } else {
                return nil
            }
        }
    }
    
}
