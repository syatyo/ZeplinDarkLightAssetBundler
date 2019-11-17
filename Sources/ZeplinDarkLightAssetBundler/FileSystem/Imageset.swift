//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/17.
//

import Foundation

struct Imageset: Directory {
    let name: String
    let removedPrefixName: String
    let colorMode: ColorMode?
    let contents: ImageContents
    let fileURLs: [URL]
    
    init(imagesetURL: URL) {
        self.name = imagesetURL.lastPathComponent
        self.colorMode = ColorMode(rawValue: self.name.components(separatedBy: "_")[0])
        if let separatorIndex = self.name.firstIndex(of: "_") {
            self.removedPrefixName = String(self.name[self.name.index(after: separatorIndex)..<self.name.endIndex])
        } else {
            self.removedPrefixName = self.name
        }

        let contentsOfDirectory = try! FileManager.default.contentsOfDirectory(at: imagesetURL,
                                                                               includingPropertiesForKeys: nil,
                                                                               options: [])
        let contentsURL = contentsOfDirectory.first { $0.pathExtension == "json" }!
        let data = try! Data(contentsOf: contentsURL)
        
        let decoder = JSONDecoder()
        self.contents = try! decoder.decode(ImageContents.self, from: data)

        self.fileURLs = contentsOfDirectory.filter { $0.pathExtension != "json" }
    }

    
    init(name: String, colorMode: ColorMode?, contents: ImageContents, fileURLs: [URL]) {
        self.name = name
        self.colorMode = colorMode
        self.contents = contents
        self.fileURLs = fileURLs
        self.removedPrefixName = name
    }
     
}
