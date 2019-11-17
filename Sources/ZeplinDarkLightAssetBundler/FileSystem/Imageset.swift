//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/17.
//

import Foundation

/// Direcotry of imageset
struct Imageset: Directory, ColorModeIdentifiable {
    
    typealias Content = ImageContents
    
    /// The name of imageset directory
    var name: String
    
    /// The contents of imageset
    var contents: ImageContents
    
    /// The image urls in imageset directory
    var sourceImageURLs: [URL]
    
    init(url: URL) throws {
        self.name = url.lastPathComponent
        
        let contentsOfDirectory = try FileManager.default.contentsOfDirectory(at: url,
                                                                              includingPropertiesForKeys: nil,
                                                                              options: [])
        let contentsURL = contentsOfDirectory.first { $0.pathExtension == "json" }!
        let data = try Data(contentsOf: contentsURL)
        
        let decoder = JSONDecoder()
        self.contents = try decoder.decode(ImageContents.self, from: data)
        
        self.sourceImageURLs = contentsOfDirectory.filter { $0.pathExtension != "json" }
        
        self.contents.setColorMode(colorMode)
    }
    
    init(name: String, contents: ImageContents, fileURLs: [URL]) {
        self.name = name
        self.contents = contents
        self.sourceImageURLs = fileURLs
    }
         
}

extension Imageset: Mergeable {
    
    mutating func merge(from: Imageset) {
        contents.merge(from: from.contents)
        sourceImageURLs.append(contentsOf: from.sourceImageURLs)
    }
    
}
