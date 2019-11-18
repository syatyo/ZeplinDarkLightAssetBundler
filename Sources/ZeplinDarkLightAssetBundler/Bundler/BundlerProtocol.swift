//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/18.
//

import Foundation

protocol BundlerProtocol {
    associatedtype Source
    
    func bundled() -> Source
}
