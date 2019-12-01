import XCTest
@testable import TSCUtility
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
    
    func testParseOmitInput() {
        let expectedInput = URL(fileURLWithPath: "/private/tmp/tmp/Assets.xcassets")
        let testOutputURL = TestUtils.testMainDirectoryURL.appendingPathComponent("TargetAssets.xcassets")
                
        let commandLineParser = CommandLineParser(arguments:
        [
            "-o",
            testOutputURL.relativePath
        ])
        
        let parsed = try! commandLineParser.parsed()
        XCTAssertEqual(parsed.inputURL, expectedInput)
        XCTAssertEqual(parsed.outputURL, testOutputURL)
    }
    
    func testParseOmitOutput() {
        let testInputURL = TestUtils.testAssetDirectoryURL
                
        let commandLineParser = CommandLineParser(arguments:
        [
            "-i",
            testInputURL.relativePath
        ])
        
        let parsed = try! commandLineParser.parsed()
        
        XCTAssertEqual(parsed.inputURL, testInputURL)
        XCTAssertEqual(parsed.outputURL, testInputURL)
    }
    
    func testParseWithNoOptions() {
        let commandLineParser = CommandLineParser(arguments: [])
        let parsed = try! commandLineParser.parsed()
        let expectedURL = URL(fileURLWithPath: "/private/tmp/tmp/Assets.xcassets")
        
        XCTAssertEqual(parsed.inputURL, expectedURL)
        XCTAssertEqual(parsed.outputURL, expectedURL)
    }

    static var allTests = [
        ("testParseFullArgumentsWithShortOption", testParseFullArgumentsWithShortOption),
        ("testParseFullArgumentsWithLongOption", testParseFullArgumentsWithLongOption),
        ("testParseOmitInput", testParseOmitInput),
        ("testParseOmitOutput", testParseOmitOutput),
        ("testParseWithNoOptions", testParseWithNoOptions)
    ]
}
