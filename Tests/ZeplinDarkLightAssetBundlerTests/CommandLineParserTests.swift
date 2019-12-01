import XCTest
@testable import ZeplinDarkLightAssetBundlerCore

final class CommandLineParserTests: XCTestCase {
    
    func testParseFullArgumentsWithLongOption() {
        let testInputURL = TestUtils.testAssetDirectoryURL
        let testOutputURL = TestUtils.testMainDirectoryURL.appendingPathComponent("TargetAssets.xcassets")
        
        let commandLineParser = CommandLineParser(arguments:
        [
            "--input",
            testInputURL.relativePath,
            "--output",
            testOutputURL.relativePath
        ])
        
        let parsed = try! commandLineParser.parsed()
        
        XCTAssertEqual(parsed.inputURL, testInputURL)
        XCTAssertEqual(parsed.outputURL, testOutputURL)
    }

    func testParseFullArgumentsWithShortOption() {
        let testInputURL = TestUtils.testAssetDirectoryURL
        let testOutputURL = TestUtils.testMainDirectoryURL.appendingPathComponent("TargetAssets.xcassets")
        
        let commandLineParser = CommandLineParser(arguments:
        [
            "-i",
            testInputURL.relativePath,
            "-o",
            testOutputURL.relativePath
        ])
        
        let parsed = try! commandLineParser.parsed()
        
        XCTAssertEqual(parsed.inputURL, testInputURL)
        XCTAssertEqual(parsed.outputURL, testOutputURL)
    }

    static var allTests = [
        ("testParseFullArgumentsWithShortOption", testParseFullArgumentsWithShortOption),
        ("testParseFullArgumentsWithLongOption", testParseFullArgumentsWithLongOption),
    ]
}
