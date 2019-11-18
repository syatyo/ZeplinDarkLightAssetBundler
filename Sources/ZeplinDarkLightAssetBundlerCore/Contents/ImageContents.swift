//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

/// The represention of Contents.json
struct ImageContents: Codable {
    
    /// The meta information about colorset
    let info: Info

    /// The images of  contens
    var images: [Image]
    
    mutating func setColorMode(_ colorMode: ColorMode?) {
        let appearances: [Appearance]? = {
            guard let appearance = Appearance(value: colorMode) else {
                return nil
            }
            return [appearance]
        }()
        
        images = images.map {
            Image(idiom: $0.idiom,
                  filename: $0.filename,
                  appearances: appearances,
                  scale: $0.scale)
        }
    }
    
}

extension ImageContents: Mergeable {
    
    mutating func merge(from: ImageContents) {
        images.append(contentsOf: from.images)
    }
    
}
