//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/17.
//

import Foundation

struct Imageset: Directory, ColorModeIdentifiable {
    let name: String
    let contents: ImageContents
    let sourceImageURLs: [URL]
    
    init(url: URL) {
        self.name = url.lastPathComponent

        let contentsOfDirectory = try! FileManager.default.contentsOfDirectory(at: url,
                                                                               includingPropertiesForKeys: nil,
                                                                               options: [])
        let contentsURL = contentsOfDirectory.first { $0.pathExtension == "json" }!
        let data = try! Data(contentsOf: contentsURL)
        
        let decoder = JSONDecoder()
        self.contents = try! decoder.decode(ImageContents.self, from: data)

        self.sourceImageURLs = contentsOfDirectory.filter { $0.pathExtension != "json" }
    }

    
    init(name: String, contents: ImageContents, fileURLs: [URL]) {
        self.name = name
        self.contents = contents
        self.sourceImageURLs = fileURLs
    }
     
}
