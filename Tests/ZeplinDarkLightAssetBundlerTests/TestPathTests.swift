//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import Foundation
import XCTest
@testable import ZeplinDarkLightAssetBundlerCore

final class TestPathTests: XCTestCase {
    
    /*
      Functional tests
    */
    func testTestMainURL() {
        let lastPath = TestUtils.testMainDirectoryURL.lastPathComponent
        
        XCTAssertEqual(lastPath, "ZeplinDarkLightAssetBundlerTests")
        
        var isDirectory: ObjCBool = false
        let existsDirectory = FileManager.default.fileExists(atPath: TestUtils.testMainDirectoryURL.relativePath,
                                                             isDirectory: &isDirectory)
        XCTAssertTrue(existsDirectory)
        XCTAssertTrue(isDirectory.boolValue)
    }
    
    func testTestRootURL() {
        let lastPath = TestUtils.testRootDirectoryURL.lastPathComponent
        
        XCTAssertEqual(lastPath, "Tests")
        
        var isDirectory: ObjCBool = false
        let existsDirectory = FileManager.default.fileExists(atPath: TestUtils.testRootDirectoryURL.relativePath,
                                                             isDirectory: &isDirectory)
        XCTAssertTrue(existsDirectory)
        XCTAssertTrue(isDirectory.boolValue)
    }
    
    func testTestAssetURL() {
        let lastPath = TestUtils.testAssetDirectoryURL.lastPathComponent
        
        XCTAssertEqual(lastPath, "TestAssets.xcassets")
        
        var isDirectory: ObjCBool = false
        let existsDirectory = FileManager.default.fileExists(atPath: TestUtils.testAssetDirectoryURL.relativePath,
                                                             isDirectory: &isDirectory)
        XCTAssertTrue(existsDirectory)
        XCTAssertTrue(isDirectory.boolValue)
    }

    static var allTests = [
        ("testMainURL", testTestMainURL),
        ("testRootURL", testTestRootURL),
        ("testAssetURL", testTestAssetURL)
    ]
}
