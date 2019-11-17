//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/17.
//

import Foundation

struct Colorset: Directory, ColorModeIdentifiable {
    let name: String
    let contents: ColorContents
    
    init(url: URL) {
        self.name = url.lastPathComponent
        let contentsOfDirectory = try! FileManager.default.contentsOfDirectory(at: url,
                                                                               includingPropertiesForKeys: nil,
                                                                               options: [])
        let contentsURL = contentsOfDirectory.first!
        let data = try! Data(contentsOf: contentsURL)
        
        let decoder = JSONDecoder()
        self.contents = try! decoder.decode(ColorContents.self, from: data)
    }
    
    init(name: String, contents: ColorContents) {
        self.name = name
        self.contents = contents
    }
    
}
