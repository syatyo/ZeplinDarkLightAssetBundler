//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/18.
//

import Foundation
import SPMUtility
import ZeplinDarkLightAssetBundlerCore

// arguments[0] is command name
let arguments = Array(CommandLine.arguments.dropFirst())

let parser = ArgumentParser(usage: "-i [input] -o [output]", overview: "Bundle colored assets from input to output")

let inputKeyword = parser.add(option: "--input", shortName: "-i", kind: String.self)
let outputKeyword = parser.add(option: "--output", shortName: "-o", kind: String.self)

func exitProcessAsFailure() -> Never {
    exit(1)
}

func exitProcessAsSuccess() -> Never {
    exit(0)
}

do {
    let result = try parser.parse(arguments)
    
    guard let inputKeyword = result.get(inputKeyword) else {
        print("Can not get input path from :\(result.description)")
        exitProcessAsFailure()
    }
    
    guard let outputKeyword = result.get(outputKeyword) else {
        print("Can not get output path from :\(result.description)")
        exitProcessAsFailure()
    }
    
    let inputURL = URL(fileURLWithPath: inputKeyword)
    let outputURL = URL(fileURLWithPath: outputKeyword)
    
    let bundler = ZeplinDarkLightAssetBundler(sourceXCAssetURL: inputURL, targetXCAssetURL: outputURL)
    try bundler.execute()
    
} catch {
    print(error)
}
