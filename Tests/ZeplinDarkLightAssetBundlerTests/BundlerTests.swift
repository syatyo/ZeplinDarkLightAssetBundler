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
            XCTAssertEqual(assets.contents.count, 4)
        }
        
        let bundler = Bundler(source: imagesets)
        let result = bundler.bundled()

        XCTContext.runActivity(named: "Imageset shoud be bundled") { _ in
            XCTAssertEqual(result.count, 1)
            
            let value = try! result.first!.get()
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
            var value = try! result.first!.get().contents
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
            XCTAssertEqual(assets.contents.count, 4)
        }
        
        let bundler = Bundler(source: colorsets)
        let result = bundler.bundled()

        XCTContext.runActivity(named: "Colorset shoud be bundled") { _ in
            XCTAssertEqual(result.count, 1)
            
            let value = try! result.first!.get()
            XCTAssertEqual(value.name, "red.colorset")
            XCTAssertEqual(value.contents.info.version, 1)
            XCTAssertEqual(value.contents.info.author, "xcode")
            XCTAssertEqual(value.contents.colors.filter { $0.appearances?[0] == nil }.count, 1)
            XCTAssertEqual(value.contents.colors.filter { $0.appearances?[0].value == .dark }.count, 1)
            XCTAssertEqual(value.contents.colors.filter { $0.appearances?[0].value == .light }.count, 0)

            XCTAssertEqual(value.contents.colors.count, 2)
        }
        
        XCTContext.runActivity(named: "Encoded text should be equal to expected") { _ in
            var value = try! result.first!.get().contents
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
    
    func testLuckAssets() {
        let url = TestUtils.testResourcesDirectoryURL.appendingPathComponent("TestLuckAssets.xcassets")
        let assets = try! XCAssets(url: url)
        
        XCTContext.runActivity(named: "Darkのアセットがない画像がある") { _ in
            let imagesets: [Imageset] = assets.contents.compactMap {
                if case .imageset(let value) = $0 {
                    return value
                } else {
                    return nil
                }
            }
            
            let imageBundler = Bundler(source: imagesets)
            let imageBundleResults = imageBundler.bundled()
            
            XCTAssertEqual(imageBundleResults.filter { (try? $0.get()) != nil }.count, 0)
            XCTAssertNotEqual(imageBundleResults.filter { $0.error != nil }.count, 0)

            let error = imageBundleResults.first { $0.error != nil }?.error as? Bundler<Imageset>.BundlerError
            XCTAssertEqual(error, Bundler<Imageset>.BundlerError.darkAssetDoesNotExist(key: "cat.imageset", source: []))
        }
        
        XCTContext.runActivity(named: "Anyのアセットがない色がある") { _ in
            let colorSets: [Colorset] = assets.contents.compactMap {
                if case .colorset(let value) = $0 {
                    return value
                } else {
                    return nil
                }
            }
            
            let colorBundler = Bundler(source: colorSets)
            let colorBundleResults = colorBundler.bundled()
            
            XCTAssertEqual(colorBundleResults.filter { (try? $0.get()) != nil }.count, 0)
            XCTAssertNotEqual(colorBundleResults.filter { $0.error != nil }.count, 0)

            let error = colorBundleResults.first { $0.error != nil }?.error as? Bundler<Colorset>.BundlerError
            XCTAssertEqual(error, Bundler<Colorset>.BundlerError.anyAssetDoesNotExist(key: "red.colorset", source: []))
        }


    }
    
    static var allTests = [
        ("testImagesetBundle", testImagesetBundle),
        ("testColorBundle", testColorBundle),
        ("testAnyLuckAssets", testLuckAssets)
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

extension Bundler.BundlerError: Equatable {
    
    public static func == (lhs: Bundler.BundlerError, rhs: Bundler.BundlerError) -> Bool {
        switch (lhs, rhs) {
        case (.anyAssetDoesNotExist(key: let lhsValue, source: _), .anyAssetDoesNotExist(key: let rhsValue, source: _)):
            return lhsValue == rhsValue
            
        case (.darkAssetDoesNotExist(key: let lhsValue, source: _), .darkAssetDoesNotExist(key: let rhsValue, source: _)):
            return lhsValue == rhsValue
            
        default:
            return false
        }
    }
    
}
