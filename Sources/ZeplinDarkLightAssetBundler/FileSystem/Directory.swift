//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

/// Representation of directory
protocol Directory {
    
    /// The name of directory
    var name: String { get }
    
    init(url: URL)
}

extension Directory where Self: ColorModeIdentifiable {
    
    /// The name removed color prefix
    var removedColorModePrefixName: String {
        // - TODO: I have to consider other separators
        if let separatorIndex = name.firstIndex(of: "_") {
            let indexAfterSeparator = name.index(after: separatorIndex)
            let removedColorModePrefixNameRange = indexAfterSeparator..<name.endIndex
            return String(name[removedColorModePrefixNameRange])
        } else {
            return name
        }
    }
    
    /// The color mode of directory
    var colorMode: ColorMode {
        return ColorMode(rawValue: name.components(separatedBy: "_")[0])
    }
    
}
