//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/17.
//

import Foundation

/// Bundler bundle source
struct Bundler<T> where T: Directory, T: ColorModeIdentifiable, T: Mergeable {
    
    /// The source of bundle
    let source: [T]
    
    /// return bundled value
    func bundled() -> [T] {
        let dictionary = Dictionary(grouping: source) { $0.removedColorModePrefixName }
        return dictionary.compactMap({ keyWithValues -> T in
            // Any source should exist
            let anySource = keyWithValues.value.first(where: { $0.colorMode == nil })!
            
            var initialSource = anySource
            initialSource.name = initialSource.removedColorModePrefixName
            
            if let lightSource = keyWithValues.value.first(where: { $0.colorMode == .light }) {
                initialSource.merge(from: lightSource)
            }
            
            if let darkSource = keyWithValues.value.first(where: { $0.colorMode == .dark }) {
                initialSource.merge(from: darkSource)
            }
            return initialSource
        })
    }
    
}
