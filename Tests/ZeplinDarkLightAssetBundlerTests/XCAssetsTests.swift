//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import XCTest
@testable import ZeplinDarkLightAssetBundlerCore

final class XCAssetsTests: XCTestCase {
    
    func testAssets() {
        let url = TestUtils.testAssetDirectoryURL
        let xcassets = try! XCAssets(url: url)
        XCTAssertEqual(xcassets.name, "TestAssets.xcassets")
        XCTAssertEqual(xcassets.contents.count, 5)
        XCTAssertEqual(xcassets.contents.filter { $0 == .colorset(.empty()) }.count, 2)
        XCTAssertEqual(xcassets.contents.filter { $0 == .imageset(.empty()) }.count, 2)
    }

    static var allTests = [
        ("testAssets", testAssets),
    ]
}

extension XCAssetsItem: Equatable {
    
    public static func == (lhs: XCAssetsItem, rhs: XCAssetsItem) -> Bool {
        switch (lhs, rhs) {
        case (.colorset, .colorset):
            return true
            
        case (.imageset, .imageset):
            return true
            
        case (.rootContentsJSON, .rootContentsJSON):
            return true
            
        default:
            return false
        }
    }
    
}

extension Colorset {
    
    static func empty() -> Colorset {
        return Colorset(targetURL: TestUtils.testRootDirectoryURL, name: "", contents: .init(info: .init(version: 0, author: ""), colors: []))
    }
    
}

extension Imageset {
    
    static func empty() -> Imageset {
        return Imageset(targetURL: TestUtils.testRootDirectoryURL, name: "", contents: .init(info: .init(version: 0, author: ""), images: []), fileURLs: [])
    }
    
}
