//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

/// Directory including xcode resources
struct XCAssets: Directory {
    
    typealias Contents = [XCAssetsItem]
    
    var name: String
    
    /// The items of xcassets
    let contents: [XCAssetsItem]
    
    init(url: URL) throws {
        self.name = url.lastPathComponent
        let contentURLs = try FileManager.default.contentsOfDirectory(at: url,
                                                                      includingPropertiesForKeys: nil,
                                                                      options: [])
        
        var contents: [XCAssetsItem] = []
        contents.append(contentsOf: try contentURLs
            .filter { $0.pathExtension == "colorset" }
            .compactMap { try XCAssetsItem.colorset(Colorset(url: $0)) }
        )
        
        contents.append(contentsOf: try contentURLs
            .filter { $0.pathExtension == "imageset" }
            .compactMap { try XCAssetsItem.imageset(Imageset(url: $0)) }
        )
        
        if let contentsJsonURL: URL = contentURLs.first(where: { $0.lastPathComponent == "Contents.json" }) {
            let data = try Data(contentsOf: contentsJsonURL)
            let rootContents = try JSONDecoder().decode(RootContents.self, from: data)
            contents.append(XCAssetsItem.rootContentsJSON(rootContents))
        }
        
        self.contents = contents
    }
    
}
