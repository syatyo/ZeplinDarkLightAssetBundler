//
//  File.swift
//
//
//  Created by 山田良治 on 2019/11/18.
//

import Foundation

struct ZeplinDarkLightAssetBundler {
    
    let sourceXCAssetURL: URL
    let targetXCAssetURL: URL

    func execute() throws {
        let assets = try XCAssets(url: sourceXCAssetURL)
        let bundled = assets.bundled()
        bundled.write(to: targetXCAssetURL.relativePath)
    }
    
}

extension XCAssets: Writable {
    
    func write(to path: String) {
        try? FileManager.default.createDirectory(atPath: path,
                                                 withIntermediateDirectories: true,
                                                 attributes: nil)
        contents.forEach {
            switch $0 {
            case .colorset(let dir):
                dir.write(to: path + dir.name)
                
            case .imageset(let dir):
                dir.write(to: path + dir.name)
                
            case .rootContentsJSON(let file):
                file.write(to: path + "Contents.json")
            }
        }
    }
    
}

extension Colorset: Writable {
    
    func write(to path: String) {
        try? FileManager.default.createDirectory(atPath: path,
                                                 withIntermediateDirectories: true,
                                                 attributes: nil)
        contents.write(to: path + "Contents.json")
    }
    
}

extension ColorContents: Writable {
    
    func write(to path: String) {
        FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
    }
    
}

extension Imageset: Writable {
    
    func write(to path: String) {
        try? FileManager.default.createDirectory(atPath: path,
                                                 withIntermediateDirectories: true,
                                                 attributes: nil)
        contents.write(to: path + "Contents.json")
    }
}

extension ImageContents: Writable {
    
    func write(to path: String) {
        FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
    }
    
}

extension RootContents: Writable {
    
    func write(to path: String) {
        FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
    }
    
}
