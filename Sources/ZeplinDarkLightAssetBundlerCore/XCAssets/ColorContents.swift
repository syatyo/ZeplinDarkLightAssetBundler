//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

/// The represention of Contents.json
struct ColorContents: Codable {
    
    /// The meta information about colorset
    let info: Info
    
    /// The colors of contents
    var colors: [Color]
    
    mutating func setColorMode(_ colorMode: ColorMode?) {
        let appearances: [Appearance]? = {
            guard let appearance = Appearance(value: colorMode) else {
                return nil
            }
            return [appearance]
        }()
        
        colors = colors.map {
            Color(idiom: $0.idiom,
                  appearances: appearances,
                  value: $0.value)
        }
        
    }

}

extension ColorContents: Mergeable {
    
    mutating func merge(from: ColorContents) {
        colors.append(contentsOf: from.colors)
    }
    
}
