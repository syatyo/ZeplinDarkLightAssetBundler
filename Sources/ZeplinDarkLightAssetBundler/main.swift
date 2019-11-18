//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/18.
//

import Foundation
import SPMUtility

// arguments[0] is command name
let arguments = Array(CommandLine.arguments.dropFirst())

let parser = ArgumentParser(usage: "-i [input] -o [output]", overview: "Bundle colored assets from input to output")

let inputKeyword = parser.add(option: "--input", shortName: "-i", kind: String.self)
let outputKeyword = parser.add(option: "--output", shortName: "-o", kind: String.self)

do {
    let result = try parser.parse(arguments)
    if let inputKeyword = result.get(inputKeyword), let outputKeyword = result.get(outputKeyword) {
        
    }
}
