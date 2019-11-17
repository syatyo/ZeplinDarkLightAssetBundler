//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import XCTest
@testable import ZeplinDarkLightAssetBundler

final class ColorDictionaryTests: XCTestCase {
    
    func testColorDictionry() {
        let url = TestUtils.testAssetDirectoryURL.appendingPathComponent("Color.colorset")
        let colorDictionary = ColorSetDirectory(colorsetURL: url)
        
        XCTAssertEqual(colorDictionary.contents.info.version, 1)
        XCTAssertEqual(colorDictionary.contents.info.author, "xcode")
        XCTAssertEqual(colorDictionary.contents.colors[0].idiom, "universal")
        XCTAssertNil(colorDictionary.contents.colors[0].appearances)
        XCTAssertEqual(colorDictionary.contents.colors[0].value.colorSpace, "srgb")
        XCTAssertEqual(colorDictionary.contents.colors[0].value.components.red, "1.000")
        XCTAssertEqual(colorDictionary.contents.colors[0].value.components.alpha, "1.000")
        XCTAssertEqual(colorDictionary.contents.colors[0].value.components.blue, "1.000")
        XCTAssertEqual(colorDictionary.contents.colors[0].value.components.green, "1.000")
        
        XCTAssertEqual(colorDictionary.contents.colors.count, 3)
    }
    
    func testLightColorDictionary() {
        let url = TestUtils.testAssetDirectoryURL.appendingPathComponent("light_red.colorset")
        let lightColorDictionary = ColorSetDirectory(colorsetURL: url)
        XCTAssertEqual(lightColorDictionary.colorMode, .light)
        XCTAssertEqual(lightColorDictionary.name, "light_red.colorset")
        XCTAssertEqual(lightColorDictionary.removedPrefixName, "red.colorset")
    }
    
    func testDarkColorDictionary() {
        let url = TestUtils.testAssetDirectoryURL.appendingPathComponent("dark_red.colorset")
        let lightColorDictionary = ColorSetDirectory(colorsetURL: url)
        XCTAssertEqual(lightColorDictionary.colorMode, .dark)
        XCTAssertEqual(lightColorDictionary.name, "dark_red.colorset")
        XCTAssertEqual(lightColorDictionary.removedPrefixName, "red.colorset")
    }


    static var allTests = [
        ("testColorDictionary", testColorDictionry),
        ("testLightColorDictionary", testLightColorDictionary),
        ("testDarkColorDictionary", testDarkColorDictionary)
    ]
}

