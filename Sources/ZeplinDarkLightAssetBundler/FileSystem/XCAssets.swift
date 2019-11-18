//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

/// Directory including xcode resources
struct XCAssets: Directory, BundlerProtocol {
    typealias Source = XCAssets
    typealias Contents = [XCAssetsItem]
    
    /// The url of xcassets
    var url: URL
    
    /// The name of xcassets
    var name: String
    
    /// The items of xcassets
    var contents: [XCAssetsItem]
    
    init(url: URL) throws {
        self.url = url
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
    
    func bundled() -> XCAssets {
        let bundledContents: [XCAssetsItem] = {
            let colorBundler = Bundler(source: contents.colorset)
            let bundledColorsets = colorBundler.bundled().map { XCAssetsItem.colorset($0) }
            
            let imageBundler = Bundler(source: contents.imageset)
            let bundledImagesets = imageBundler.bundled().map { XCAssetsItem.imageset($0) }

            if let rootJSON = contents.rootContentsJSON {
                return bundledColorsets + bundledImagesets + [XCAssetsItem.rootContentsJSON(rootJSON)]
            } else {
                return bundledColorsets + bundledImagesets
            }

        }()
        
        var bundledAssets = self
        bundledAssets.contents = bundledContents
        return bundledAssets
    }
    
}
