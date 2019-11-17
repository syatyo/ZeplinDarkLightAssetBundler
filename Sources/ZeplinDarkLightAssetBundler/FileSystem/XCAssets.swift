//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

/// Directory including xcode resources
struct XCAssets {
    
    /// The items of xcassets
    let items: [XCAssetsItem]
    
    init(url: URL) {
        let contentURLs = try! FileManager.default.contentsOfDirectory(at: url,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: [])
        
        var items: [XCAssetsItem] = []
        items.append(contentsOf: contentURLs
            .filter { $0.pathExtension == "colorset" }
            .compactMap { XCAssetsItem.colorset(Colorset(colorsetURL: $0)) }
        )
        
        items.append(contentsOf: contentURLs
            .filter { $0.pathExtension == "imageset" }
            .compactMap { XCAssetsItem.imageset(Imageset(imagesetURL: $0)) }
        )
        self.items = items
    }
    
}
