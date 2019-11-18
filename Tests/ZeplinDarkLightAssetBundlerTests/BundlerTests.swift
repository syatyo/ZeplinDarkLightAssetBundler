//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/17.
//

import XCTest
@testable import ZeplinDarkLightAssetBundlerCore

final class BundlerTests: XCTestCase {
    
    func testImagesetBundle() {
        
        let assets = try! XCAssets(url: TestUtils.testAssetDirectoryURL)
        let imagesets: [Imageset] = assets.contents.compactMap {
            if case .imageset(let value) = $0 {
                return value
            } else {
                return nil
            }
        }
        
        XCTContext.runActivity(named: "Should not bundled") { _ in
            XCTAssertEqual(imagesets.count, 2)
            XCTAssertEqual(assets.contents.count, 5)
        }
        
        let bundler = Bundler(source: imagesets)
        let result = bundler.bundled()

        XCTContext.runActivity(named: "Imageset shoud be bundled") { _ in
            XCTAssertEqual(result.count, 1)
            
            let value = result.first!
            XCTAssertEqual(value.name, "cat.imageset")
            XCTAssertEqual(value.contents.info.version, 1)
            XCTAssertEqual(value.contents.info.author, "xcode")
            XCTAssertEqual(value.contents.images.filter { $0.appearances?[0] == nil }.count, 3)
            XCTAssertEqual(value.contents.images.filter { $0.appearances?[0].value == .dark }.count, 3)
            XCTAssertEqual(value.contents.images.filter { $0.appearances?[0].value == .light }.count, 0)

            XCTAssertEqual(Set(value.sourceImageURLs).count, 6)
            XCTAssertEqual(value.contents.images.count, 6)
        }
        
        XCTContext.runActivity(named: "Encoded text should be equal to expected") { _ in
            var value = result.first!.contents
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
                  "filename" : "catwhite2_TP_V4.jpg",
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
                  "filename" : "cat9302341_TP_V4-1.jpg",
                  "scale" : "2x"
                },
                {
                  "idiom" : "universal",
                  "filename" : "catwhite2_TP_V4-1.jpg",
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
                  "filename" : "cat9302341_TP_V4-2.jpg",
                  "scale" : "3x"
                },
                {
                  "idiom" : "universal",
                  "filename" : "catwhite2_TP_V4-2.jpg",
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
            var decoded = try! JSONDecoder().decode(ImageContents.self, from: testString.data(using: .utf8)!)
            value.sort()
            decoded.sort()
            XCTAssertEqual(value, decoded)
        }
        
    }
    
    func testColorBundle() {
        let assets = try! XCAssets(url: TestUtils.testAssetDirectoryURL)
        let colorsets: [Colorset] = assets.contents.compactMap {
            if case .colorset(let value) = $0 {
                return value
            } else {
                return nil
            }
        }
        
        XCTContext.runActivity(named: "Should not bundled") { _ in
            XCTAssertEqual(colorsets.count, 2)
            XCTAssertEqual(assets.contents.count, 5)
        }
        
        let bundler = Bundler(source: colorsets)
        let result = bundler.bundled()

        XCTContext.runActivity(named: "Colorset shoud be bundled") { _ in
            XCTAssertEqual(result.count, 1)
            
            let value = result.first!
            XCTAssertEqual(value.name, "red.colorset")
            XCTAssertEqual(value.contents.info.version, 1)
            XCTAssertEqual(value.contents.info.author, "xcode")
            XCTAssertEqual(value.contents.colors.filter { $0.appearances?[0] == nil }.count, 1)
            XCTAssertEqual(value.contents.colors.filter { $0.appearances?[0].value == .dark }.count, 1)
            XCTAssertEqual(value.contents.colors.filter { $0.appearances?[0].value == .light }.count, 0)

            XCTAssertEqual(value.contents.colors.count, 2)
        }
        
        XCTContext.runActivity(named: "Encoded text should be equal to expected") { _ in
            var value = result.first!.contents
            let testString = """
            {
              "info" : {
                "version" : 1,
                "author" : "xcode"
              },
              "colors" : [
                {
                  "idiom" : "universal",
                  "color" : {
                    "color-space" : "srgb",
                    "components" : {
                      "red" : "1.000",
                      "alpha" : "1.000",
                      "blue" : "0.212",
                      "green" : "0.162"
                    }
                  }
                },
                {
                  "idiom" : "universal",
                  "appearances" : [
                    {
                      "appearance" : "luminosity",
                      "value" : "dark"
                    }
                  ],
                  "color" : {
                    "color-space" : "srgb",
                    "components" : {
                      "red" : "1.000",
                      "alpha" : "1.000",
                      "blue" : "0.097",
                      "green" : "0.044"
                    }
                  }
                }
              ]
            }
            """
            var decoded = try! JSONDecoder().decode(ColorContents.self, from: testString.data(using: .utf8)!)
            value.sort()
            decoded.sort()
            XCTAssertEqual(value, decoded)
        }

    }
    
    static var allTests = [
        ("testImagesetBundle", testImagesetBundle),
        ("testColorBundle", testColorBundle)
    ]
}

extension Info: Hashable, Equatable {
    
    public static func == (lhs: Info, rhs: Info) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
        
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.author)
        hasher.combine(self.version)
    }
    
}

extension ImageContents: Equatable {
    
    public static func == (lhs: ImageContents, rhs: ImageContents) -> Bool {
        return lhs.info == rhs.info && lhs.images == rhs.images
    }
    
    mutating func sort() {
        images.sort()
    }
        
}

extension ColorContents: Equatable {
    
    public static func == (lhs: ColorContents, rhs: ColorContents) -> Bool {
        return lhs.info == rhs.info && lhs.colors == rhs.colors
    }
    
    mutating func sort() {
        colors.sort()
    }

}
