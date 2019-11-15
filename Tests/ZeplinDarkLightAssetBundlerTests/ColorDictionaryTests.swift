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
        XCTAssertEqual(colorDictionary.contents.colors[0].color.colorSpace, "srgb")
        XCTAssertEqual(colorDictionary.contents.colors[0].color.components.red, "1.000")
        XCTAssertEqual(colorDictionary.contents.colors[0].color.components.alpha, "1.000")
        XCTAssertEqual(colorDictionary.contents.colors[0].color.components.blue, "1.000")
        XCTAssertEqual(colorDictionary.contents.colors[0].color.components.green, "1.000")
        
        XCTAssertEqual(colorDictionary.contents.colors.count, 3)
    }

    static var allTests = [
        ("testColorDictionary", testColorDictionry),
    ]
}

