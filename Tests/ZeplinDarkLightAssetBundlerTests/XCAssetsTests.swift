//
//  File.swift
//  
//
//  Created by 山田良治 on 2019/11/15.
//

import XCTest
@testable import ZeplinDarkLightAssetBundler

final class XCAssetsTests: XCTestCase {
    
    func testAssets() {
        let url = TestUtils.testAssetDirectoryURL
        let xcassets = XCAssets(url: url)
        XCTAssertEqual(xcassets.colorsetDirectories.count, 3)
        XCTAssertEqual(xcassets.imagesetDirectories.count, 3)
    }

    static var allTests = [
        ("testAssets", testAssets),
    ]
}
