//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import XCTest
@testable import ZeplinDarkLightAssetBundler

final class ImageContentsTests: XCTestCase {
    
    func testDecode() {
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
    
    func testEncode() {
        let imageContents = ImageContents(info: .init(version: 1, author: "xcode"), images: [
            .init(idiom: "universal",
                  filename: "cat9302341_TP_V4.jpg",
                  appearances: nil,
                  scale: "1x"),
            .init(idiom: "universal",
                  filename: "cat9302341_TP_V4-1.jpg",
                  appearances: [Appearance(appearance: "luminosity", value: .dark)!],
                  scale: "1x"),
            .init(idiom: "universal",
                  filename: "cat9302341_TP_V4-4.jpg",
                  appearances: nil,
                  scale: "2x"),
            .init(idiom: "universal",
                  filename: "cat9302341_TP_V4-2.jpg",
                  appearances: [Appearance(appearance: "luminosity", value: .dark)!],
                  scale: "2x"),
            .init(idiom: "universal",
                  filename: "cat9302341_TP_V4-5.jpg",
                  appearances: nil,
                  scale: "3x"),
            .init(idiom: "universal",
                  filename: "cat9302341_TP_V4-3.jpg",
                  appearances: [Appearance(appearance: "luminosity", value: .dark)!],
                  scale: "3x"),
        ])
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let data = try! encoder.encode(imageContents)
        let string = String(data: data, encoding: .utf8)!
        
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
              "appearances" : [
                {
                  "appearance" : "luminosity",
                  "value" : "dark"
                }
              ],
              "scale" : "1x"
            },
            {
              "idiom" : "universal",
              "filename" : "cat9302341_TP_V4-4.jpg",
              "scale" : "2x"
            },
            {
              "idiom" : "universal",
              "filename" : "cat9302341_TP_V4-2.jpg",
              "appearances" : [
                {
                  "appearance" : "luminosity",
                  "value" : "dark"
                }
              ],
              "scale" : "2x"
            },
            {
              "idiom" : "universal",
              "filename" : "cat9302341_TP_V4-5.jpg",
              "scale" : "3x"
            },
            {
              "idiom" : "universal",
              "filename" : "cat9302341_TP_V4-3.jpg",
              "appearances" : [
                {
                  "appearance" : "luminosity",
                  "value" : "dark"
                }
              ],
              "scale" : "3x"
            }
          ],
          "info" : {
            "version" : 1,
            "author" : "xcode"
          }
        }
        """
        
        XCTAssertEqual(string, testString)
    }

    static var allTests = [
        ("testDecode", testDecode),
        ("testEncode", testEncode)
    ]
}

