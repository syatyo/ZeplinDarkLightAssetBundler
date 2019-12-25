//
//  File.swift
//
//
//  Created by 山田良治 on 2019/11/18.
//

import Foundation

// The facade of this tool.
public struct ZeplinDarkLightAssetBundler {
    
    /// The source xcassets url
    var sourceXCAssetURL: URL
    
    /// The source xcassets that is pure
    var sourceXCAssets: XCAssets!
    
    /// The target xcassets url
    var targetXCAssetURL: URL
    
    /// The target xcassets that has already processed
    var targetXCAssets: XCAssets!

    /// Execute processing steps
    public mutating func execute() throws {
        try self.parse()
        try self.validate()
        try self.bundle()
        try self.write()
    }
    
    private mutating func parse() throws {
        self.sourceXCAssets = try XCAssets(url: sourceXCAssetURL)
    }
    
    private mutating func validate() throws {
        
    }
        
    private mutating func bundle() throws {
//        self.targetXCAssets = sourceXCAssets.bundled()
    }
    
    private mutating func write() throws {
        // Write successed values
//        bundled.success.write(to: targetXCAssetURL)
//
//        // Print errors
//        bundled.errors.forEach { print($0.localizedDescription) }

    }
    
    public init(sourceXCAssetURL: URL, targetXCAssetURL: URL) {
        self.sourceXCAssetURL = sourceXCAssetURL
        self.targetXCAssetURL = targetXCAssetURL
    }
    
}

extension XCAssets: Writable {
    
    func write(to url: URL) {
        try? FileManager.default.createDirectory(atPath: url.relativePath,
                                                 withIntermediateDirectories: true,
                                                 attributes: nil)
        contents.forEach {
            switch $0 {
            case .colorset(let dir):
                dir.write(to: url.appendingPathComponent(dir.name))
                
            case .imageset(let dir):
                dir.write(to: url.appendingPathComponent(dir.name))
                
            case .rootContentsJSON(let file):
                file.write(to: url.appendingPathComponent("Contents.json"))
            }
        }
    }
    
}

extension Colorset: Writable {
    
    func write(to url: URL) {
        try? FileManager.default.createDirectory(atPath: url.relativePath,
                                                 withIntermediateDirectories: true,
                                                 attributes: nil)
        contents.write(to: url.appendingPathComponent("Contents.json"))
    }
    
}

extension ColorContents: Writable {
    
    func write(to url: URL) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(self)
        FileManager.default.createFile(atPath: url.relativePath, contents: data, attributes: nil)
    }
    
}

extension Imageset: Writable {
    
    func write(to url: URL) {
        try? FileManager.default.createDirectory(atPath: url.relativePath,
                                                 withIntermediateDirectories: true,
                                                 attributes: nil)
        contents.write(to: url.appendingPathComponent("Contents.json"))
        sourceImageURLs.forEach { sourceImageURL in
            let at = sourceImageURL.relativePath
            let to = url.appendingPathComponent(sourceImageURL.lastPathComponent).relativePath
            try? FileManager.default.copyItem(atPath: at, toPath: to)
        }
        
    }
}

extension ImageContents: Writable {
    
    func write(to url: URL) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(self)
        FileManager.default.createFile(atPath: url.relativePath, contents: data, attributes: nil)
    }
    
}

extension RootContents: Writable {
    
    func write(to url: URL) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(self)
        FileManager.default.createFile(atPath: url.relativePath, contents: data, attributes: nil)
    }
    
}
