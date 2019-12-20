//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/12/01.
//

import Foundation
import TSCUtility

public struct CommandLineParsedResult {
    public let inputURL: Foundation.URL
    public let outputURL: Foundation.URL
}

public enum CommandLineParserError: Error {
    case invalidInputPath(String)
    case invalidOutputPath(String)
}

/// Parser of commandLine
public struct CommandLineParser {
    
    public let arguments: [String]
    
    public init(arguments: [String]) {
        self.arguments = arguments
    }
    
    public func parsed() throws -> CommandLineParsedResult {
        let parser = ArgumentParser(usage: "-i [input] -o [output]", overview: "Bundle colored assets from input to output")

        let inputKeyword = parser.add(option: "--input", shortName: "-i", kind: String.self)
        let outputKeyword = parser.add(option: "--output", shortName: "-o", kind: String.self)
        
        let result = try parser.parse(arguments)
        
        let inputPath: String = {
            if let path = result.get(inputKeyword) {
                return path
            }
            
            let cwdPath = FileManager.default.currentDirectoryPath
            var cwdURL = URL(fileURLWithPath: cwdPath)
            cwdURL.appendPathComponent(cwdURL.lastPathComponent)
            
            let defaultAssets = "Assets.xcassets"
            cwdURL.appendPathComponent(defaultAssets)
            return cwdURL.relativePath
        }()
        
        let outputPath: String = {
            if let path = result.get(outputKeyword) {
                return path
            }
            return inputPath
        }()
                
        let inputURL = URL(fileURLWithPath: inputPath)
        let outputURL = URL(fileURLWithPath: outputPath)

        return .init(inputURL: inputURL, outputURL: outputURL)
    }
}
