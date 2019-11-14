//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

/// This represent Contents.json of colorset
struct ColorContents: Codable {
    let info: Info
    let colors: [ColorSet]
    
    struct ColorSet: Codable {
        let idiom: String
        let appearances: [AppearanceSet]?
        let color: Color
        
        /// Color model used in xcasset
        struct Color: Codable {
            let colorSpace: String
            let components: Components
            
            struct Components: Codable {
                let red: String
                let alpha: String
                let blue: String
                let green: String
            }
            
            private enum CodingKeys: String, CodingKey {
                case colorSpace = "color-space"
                case components
            }
        }

    }

}
