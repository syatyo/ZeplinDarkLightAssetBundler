//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation

struct TestUtils {
    
    /// The test root directory url of `Tests`
    static var testRootDirectoryURL: URL {
        testMainDirectoryURL.deletingLastPathComponent()
    }
    
    /// The test main directory url of `Tests`
    static var testMainDirectoryURL: URL {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile
            .deletingLastPathComponent()
        return thisDirectory
    }
    
    /// The test asset
    static var testAssetDirectoryURL: URL {
        testMainDirectoryURL.appendingPathComponent("TestAssets.xcassets")
    }

}
