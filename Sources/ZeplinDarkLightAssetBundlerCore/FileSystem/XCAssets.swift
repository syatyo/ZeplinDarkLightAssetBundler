//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

/// Directory including xcode resources
struct XCAssets: Directory, BundlerProtocol {
    
    struct BundleResult {
        let success: XCAssets
        let errors: [Error]
    }
    
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
    
    func bundled() -> BundleResult {
                
        let colorAssets = Bundler(source: contents.colorset).bundled()
        let colorBundleSuccessValues: [XCAssetsItem] = colorAssets
            .compactMap { try? $0.get() }
            .compactMap { .colorset($0) }
        
        let colorBundleErrors = colorAssets.compactMap { $0.error }
        
        let imageAssets = Bundler(source: contents.imageset).bundled()
        let imageBundleSuccessValues: [XCAssetsItem] = imageAssets
            .compactMap { try? $0.get() }
            .compactMap { .imageset($0)}
        
        let imageBundleErrors = imageAssets.compactMap { $0.error }
        
        let bundledSuccessValues: [XCAssetsItem] = {
            if let rootJSON = contents.rootContentsJSON {
                return colorBundleSuccessValues + imageBundleSuccessValues + [XCAssetsItem.rootContentsJSON(rootJSON)]
            } else {
                return colorBundleSuccessValues + imageBundleSuccessValues
            }
        }()
        
        let bundledErrors: [Error] = colorBundleErrors + imageBundleErrors
        
        /// I may use `Prototype` pattern in this context.
        var bundledAssets = self
        bundledAssets.contents = bundledSuccessValues
        return BundleResult(success: bundledAssets, errors: bundledErrors)
    }
        
}

extension Result {
    
    var error: Error? {
        if case .failure(let aError) = self {
            return aError
        } else {
            return nil
        }
    }
    
}
