//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import XCTest
@testable import ZeplinDarkLightAssetBundlerCore

final class ImageSetDictionaryTests: XCTestCase {
        
    func testLightImageDictionary() {
        let url = TestUtils.testAssetDirectoryURL.appendingPathComponent("light_cat.imageset")
        let lightImageDictionary = try! Imageset(url: url)
        XCTAssertEqual(lightImageDictionary.colorMode, nil)
        XCTAssertEqual(lightImageDictionary.name, "light_cat.imageset")
        XCTAssertEqual(lightImageDictionary.removedColorModePrefixName, "cat.imageset")
    }
    
    func testDarkImageDictionary() {
        let url = TestUtils.testAssetDirectoryURL.appendingPathComponent("dark_cat.imageset")
        let darkImageDictionary = try! Imageset(url: url)
        XCTAssertEqual(darkImageDictionary.colorMode, .dark)
        XCTAssertEqual(darkImageDictionary.name, "dark_cat.imageset")
        XCTAssertEqual(darkImageDictionary.removedColorModePrefixName, "cat.imageset")
    }

    static var allTests = [
        ("testLightImageDictionary", testLightImageDictionary),
        ("testDarkImageDictionary", testDarkImageDictionary),
    ]
}

