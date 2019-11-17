//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/17.
//

import Foundation

struct Colorset: Directory {
    let name: String
    let removedPrefixName: String
    let colorMode: ColorMode?
    let contents: ColorContents
    
    init(colorsetURL: URL) {
        self.name = colorsetURL.lastPathComponent
        self.colorMode = ColorMode(rawValue: self.name.components(separatedBy: "_")[0])
        if let separatorIndex = self.name.firstIndex(of: "_") {
            self.removedPrefixName = String(self.name[self.name.index(after: separatorIndex)..<self.name.endIndex])
        } else {
            self.removedPrefixName = self.name
        }
        let contentsOfDirectory = try! FileManager.default.contentsOfDirectory(at: colorsetURL,
                                                                               includingPropertiesForKeys: nil,
                                                                               options: [])
        let contentsURL = contentsOfDirectory.first!
        let data = try! Data(contentsOf: contentsURL)
        
        let decoder = JSONDecoder()
        self.contents = try! decoder.decode(ColorContents.self, from: data)
    }
    
    init(name: String, colorMode: ColorMode?, contents: ColorContents) {
        self.name = name
        self.colorMode = colorMode
        self.contents = contents
        self.removedPrefixName = name
    }
    
}
