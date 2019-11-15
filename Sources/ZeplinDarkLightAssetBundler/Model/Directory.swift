//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

enum ColorMode: String {
    case light
    case dark
}

extension ColorMode: Equatable { }

struct ColorSetDirectory {
    let name: String
    let colorMode: ColorMode?
    let contents: ColorContents
    
    init(colorsetURL: URL) {
        self.name = colorsetURL.lastPathComponent
        self.colorMode = ColorMode(rawValue: self.name.components(separatedBy: "_")[0])

        let contentsOfDirectory = try! FileManager.default.contentsOfDirectory(at: colorsetURL,
                                                                               includingPropertiesForKeys: nil,
                                                                               options: [])
        let contentsURL = contentsOfDirectory.first!
        let data = try! Data(contentsOf: contentsURL)
        
        let decoder = JSONDecoder()
        self.contents = try! decoder.decode(ColorContents.self, from: data)
    }
}

struct ImageSetDirectory {
    let name: String
    let colorMode: ColorMode?
    let contents: ImageContents
    let fileURLs: [URL]
    
    init(imagesetURL: URL) {
        self.name = imagesetURL.lastPathComponent
        self.colorMode = ColorMode(rawValue: self.name.components(separatedBy: "_")[0])

        let contentsOfDirectory = try! FileManager.default.contentsOfDirectory(at: imagesetURL,
                                                                               includingPropertiesForKeys: nil,
                                                                               options: [])
        let contentsURL = contentsOfDirectory.first { $0.pathExtension == "json" }!
        let data = try! Data(contentsOf: contentsURL)
        
        let decoder = JSONDecoder()
        self.contents = try! decoder.decode(ImageContents.self, from: data)

        self.fileURLs = contentsOfDirectory.filter { $0.pathExtension != "json" }
    }

}
