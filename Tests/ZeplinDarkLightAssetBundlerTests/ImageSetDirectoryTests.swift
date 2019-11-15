//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import XCTest
@testable import ZeplinDarkLightAssetBundler

final class ImageSetDictionaryTests: XCTestCase {
    
    func testImageSetDictionary() {
        let url = TestUtils.testAssetDirectoryURL.appendingPathComponent("Image.imageset")
        let colorDictionary = ImageSetDirectory(imagesetURL: url)
        XCTAssertEqual(colorDictionary.contents.info.version, 1)
        XCTAssertEqual(colorDictionary.contents.info.author, "xcode")
        XCTAssertEqual(colorDictionary.contents.images[0].idiom, "universal")
        XCTAssertEqual(colorDictionary.contents.images[0].filename, "cat9302341_TP_V4.jpg")
        XCTAssertEqual(colorDictionary.contents.images[0].scale, "1x")
        XCTAssertNil(colorDictionary.contents.images[0].appearances)
        XCTAssertEqual(colorDictionary.contents.images[1].appearances?[0].appearance, "luminosity")
        XCTAssertEqual(colorDictionary.contents.images[1].appearances?[0].value, "dark")
    }
    
    func testLightImageDictionary() {
        let url = TestUtils.testAssetDirectoryURL.appendingPathComponent("light_cat.imageset")
        let lightImageDictionary = ImageSetDirectory(imagesetURL: url)
        XCTAssertEqual(lightImageDictionary.colorMode, .light)
        XCTAssertEqual(lightImageDictionary.name, "light_cat.imageset")
        XCTAssertEqual(lightImageDictionary.removedPrefixName, "cat.imageset")
    }
    
    func testDarkImageDictionary() {
        let url = TestUtils.testAssetDirectoryURL.appendingPathComponent("dark_cat.imageset")
        let darkImageDictionary = ImageSetDirectory(imagesetURL: url)
        XCTAssertEqual(darkImageDictionary.colorMode, .dark)
        XCTAssertEqual(darkImageDictionary.name, "dark_cat.imageset")
        XCTAssertEqual(darkImageDictionary.removedPrefixName, "cat.imageset")
    }

    static var allTests = [
        ("testImageSetDictionary", testImageSetDictionary),
        ("testLightImageDictionary", testLightImageDictionary),
        ("testDarkImageDictionary", testDarkImageDictionary),
    ]
}

