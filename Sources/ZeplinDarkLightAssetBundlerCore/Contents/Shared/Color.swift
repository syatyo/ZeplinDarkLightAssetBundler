//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/17.
//

import Foundation

/// Color representation of colorset Contents.json
struct Color: Codable {
    
    /// The idiom of color
    let idiom: String
    
    /// The appearance of color
    let appearances: [Appearance]?
    
    /// The actual values of color like rgb.
    let value: Value
    
    /// Inner color model of colorset color
    struct Value: Codable {
        let colorSpace: String
        let components: Components
        
        /// Components of color
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
    
    private enum CodingKeys: String, CodingKey {
        case idiom
        case appearances
        case value = "color"
    }


}

extension Color: Comparable {
    
    static func == (lhs: Color, rhs: Color) -> Bool {
        return priority(of: lhs.appearances?.first) == priority(of: rhs.appearances?.first)
    }
    
    static func < (lhs: Color, rhs: Color) -> Bool {
        
        func priority(of appearance: Appearance?) -> Int {
            guard let value = appearance?.value else {
                return 0 // top priprity
            }
            
            switch value {
            case .light:
                return 1
                
            case .dark:
                return 2
            }
        }
        
        return priority(of: lhs.appearances?.first) < priority(of: rhs.appearances?.first)
    }
    
    private static func priority(of appearance: Appearance?) -> Int {
        guard let value = appearance?.value else {
            return 0 // top priprity
        }
        
        switch value {
        case .light:
            return 1
            
        case .dark:
            return 2
        }
    }

        
}
