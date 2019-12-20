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
    case rootContentsJSON(RootContents)
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
    
    var rootContentsJSON: RootContents? {
        return compactMap {
            if case .rootContentsJSON(let contents) = $0 {
                return contents
            } else {
                return nil
            }
        }.first
    }

    
}
