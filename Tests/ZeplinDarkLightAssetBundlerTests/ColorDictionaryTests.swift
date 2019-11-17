//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import XCTest
@testable import ZeplinDarkLightAssetBundler

final class ColorDictionaryTests: XCTestCase {
        
    func testLightColorDictionary() {
        let url = TestUtils.testAssetDirectoryURL.appendingPathComponent("light_red.colorset")
        let lightColorDictionary = try! Colorset(url: url)
        XCTAssertEqual(lightColorDictionary.colorMode, nil)
        XCTAssertEqual(lightColorDictionary.name, "light_red.colorset")
        XCTAssertEqual(lightColorDictionary.removedColorModePrefixName, "red.colorset")
    }
    
    func testDarkColorDictionary() {
        let url = TestUtils.testAssetDirectoryURL.appendingPathComponent("dark_red.colorset")
        let lightColorDictionary = try! Colorset(url: url)
        XCTAssertEqual(lightColorDictionary.colorMode, .dark)
        XCTAssertEqual(lightColorDictionary.name, "dark_red.colorset")
        XCTAssertEqual(lightColorDictionary.removedColorModePrefixName, "red.colorset")
    }


    static var allTests = [
        ("testLightColorDictionary", testLightColorDictionary),
        ("testDarkColorDictionary", testDarkColorDictionary)
    ]
}

