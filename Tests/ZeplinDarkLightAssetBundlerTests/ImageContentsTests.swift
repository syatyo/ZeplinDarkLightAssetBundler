//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import XCTest
@testable import ZeplinDarkLightAssetBundler

final class ImageContentsTests: XCTestCase {
    
    func testExample() {
        let testString = """
        {
          "images" : [
            {
              "idiom" : "universal",
              "filename" : "cat9302341_TP_V4.jpg",
              "scale" : "1x"
            },
            {
              "idiom" : "universal",
              "filename" : "cat9302341_TP_V4-1.jpg",
              "scale" : "2x"
            },
            {
              "idiom" : "universal",
              "filename" : "cat9302341_TP_V4-2.jpg",
              "scale" : "3x"
            }
          ],
          "info" : {
            "version" : 1,
            "author" : "xcode"
          }
        }
        """
        let testData = testString.data(using: .utf8)!
        let colorContents = try! JSONDecoder().decode(ImageContents.self, from: testData)
        
        XCTAssertEqual(colorContents.info.version, 1)
        XCTAssertEqual(colorContents.info.author, "xcode")
        
        XCTAssertEqual(colorContents.images[0].idiom, "universal")
        XCTAssertEqual(colorContents.images[0].filename, "cat9302341_TP_V4.jpg")
        XCTAssertEqual(colorContents.images[0].scale, "1x")

        XCTAssertEqual(colorContents.images[1].idiom, "universal")
        XCTAssertEqual(colorContents.images[1].filename, "cat9302341_TP_V4-1.jpg")
        XCTAssertEqual(colorContents.images[1].scale, "2x")

        XCTAssertEqual(colorContents.images[2].idiom, "universal")
        XCTAssertEqual(colorContents.images[2].filename, "cat9302341_TP_V4-2.jpg")
        XCTAssertEqual(colorContents.images[2].scale, "3x")

    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

