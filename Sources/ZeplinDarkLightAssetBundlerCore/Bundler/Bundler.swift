//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/17.
//

import Foundation

typealias Bundlable = Directory & ColorModeIdentifiable & Mergeable

/// Bundler bundle source
struct Bundler<T>: BundlerProtocol where T: Bundlable {
    
    typealias BundleResult = [Result<T, BundlerError>]
    
    /// The source of bundle
    let source: [T]
    
    /// return bundled value
    func bundled() -> BundleResult {
        let dictionary = Dictionary(grouping: source) { $0.removedColorModePrefixName }
        
        return dictionary.compactMap({ keyWithValues -> Result<T, BundlerError> in
            
            guard let anySource = keyWithValues.value.first(where: { $0.colorMode == nil }) else {
                return .failure(.anyAssetDoesNotExist(key: keyWithValues.key,
                                                      source: source))
            }
            
            var bundledSource = anySource
            bundledSource.name = bundledSource.removedColorModePrefixName
            
            guard let darkSource = keyWithValues.value.first(where: { $0.colorMode == .dark }) else {
                return .failure(.darkAssetDoesNotExist(key: keyWithValues.key,
                                                       source: source))
            }
            bundledSource.merge(from: darkSource)

            /// I don't know usecase for using the light asset. so, I can't understand correct treatment of this case
            if let lightSource = keyWithValues.value.first(where: { $0.colorMode == .light }) {
                bundledSource.merge(from: lightSource)
            }
            
            return .success(bundledSource)
        })
    }
    
    /// Error occured when bundleing
    enum BundlerError: Error {
        
        /// Any source does not exist
        case anyAssetDoesNotExist(key: String, source: [T])
        
        /// Any source exist, but dark asset does not exist
        case darkAssetDoesNotExist(key: String, source: [T])
        
        var localizedDescription: String {
            switch self {
            case .anyAssetDoesNotExist(key: let key, source: let source):
                return "Any mode source does not exist in key: \(key), source: \(source)"
                
            case .darkAssetDoesNotExist(key: let key, source: let source):
                return "Dark mode source does not exist in key: \(key), source: \(source)"
            }
        }
    }

    
}
