//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

struct XCAssets {
    let colorsetDirectories: [ColorSetDirectory]
    let imagesetDirectories: [ImageSetDirectory]
    
    init(url: URL) {
        let contentURLs = try! FileManager.default.contentsOfDirectory(at: url,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: [])
        
        self.colorsetDirectories = contentURLs
            .filter { $0.pathExtension == "colorset" }
            .compactMap { ColorSetDirectory(colorsetURL: $0) }
        
        self.imagesetDirectories = contentURLs
            .filter { $0.pathExtension == "imageset" }
            .compactMap { ImageSetDirectory(imagesetURL: $0) }
    }
    
}
