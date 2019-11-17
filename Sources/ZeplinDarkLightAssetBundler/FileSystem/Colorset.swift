//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/17.
//

import Foundation

/// Direcotry of colorset
struct Colorset: Directory, ColorModeIdentifiable {
    
    typealias Contents = ColorContents
    
    /// The name of color set directory
    let name: String
    
    /// The contents of color set
    let contents: ColorContents
    
    init(url: URL) throws {
        self.name = url.lastPathComponent
        let contentsOfDirectory = try FileManager.default.contentsOfDirectory(at: url,
                                                                              includingPropertiesForKeys: nil,
                                                                              options: [])
        let contentsURL = contentsOfDirectory.first!
        let data = try Data(contentsOf: contentsURL)
        
        let decoder = JSONDecoder()
        self.contents = try decoder.decode(ColorContents.self, from: data)
    }
    
    init(name: String, contents: ColorContents) {
        self.name = name
        self.contents = contents
    }
    
}
