//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/17.
//

import Foundation

protocol Mergeable {
    
    /// merge value that is same type
    mutating func merge(from: Self)
}
