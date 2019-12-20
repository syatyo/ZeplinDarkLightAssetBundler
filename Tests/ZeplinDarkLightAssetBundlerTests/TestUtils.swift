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
    
    /// The test resources directory url.
    static var testResourcesDirectoryURL: URL {
        return testRootDirectoryURL.appendingPathComponent("Resources")
    }
    
    static var testAssetDirectoryURL: URL {
        return testResourcesDirectoryURL.appendingPathComponent("TestAssets.xcassets")
    }

}
