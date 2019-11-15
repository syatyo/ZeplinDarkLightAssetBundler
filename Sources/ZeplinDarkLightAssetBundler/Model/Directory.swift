//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

struct ColorSetDirectory {
    let contents: ColorContents
    
    init(colorsetURL: URL) {
        let contentsOfDirectory = try! FileManager.default.contentsOfDirectory(at: colorsetURL,
                                                                               includingPropertiesForKeys: nil,
                                                                               options: [])
        let contentsURL = contentsOfDirectory.first!
        let data = try! Data(contentsOf: contentsURL)
        
        let decoder = JSONDecoder()
        self.contents = try! decoder.decode(ColorContents.self, from: data)
    }
}

