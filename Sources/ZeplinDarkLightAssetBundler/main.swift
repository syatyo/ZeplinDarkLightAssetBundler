//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/18.
//

import Foundation
import ZeplinDarkLightAssetBundlerCore

// arguments[0] is command name
let arguments = Array(CommandLine.arguments.dropFirst())

func exitProcessAsFailure() -> Never {
    exit(1)
}

func exitProcessAsSuccess() -> Never {
    exit(0)
}

do {
    let parser = CommandLineParser(arguments: arguments)
    let parsed = try parser.parsed()
    let bundler = ZeplinDarkLightAssetBundler(sourceXCAssetURL: parsed.inputURL,
                                              targetXCAssetURL: parsed.outputURL)
    try bundler.execute()
    exitProcessAsSuccess()
    
} catch {
    print(error)
    exitProcessAsFailure()
}
