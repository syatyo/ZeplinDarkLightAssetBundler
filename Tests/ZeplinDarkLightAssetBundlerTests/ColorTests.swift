import XCTest
@testable import ZeplinDarkLightAssetBundler

final class ColorTests: XCTestCase {
    
    func testParse() {
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
            }
          ]
        }
        """
        let testData = testString.data(using: .utf8)!
        let colorContents = try! JSONDecoder().decode(ColorContents.self, from: testData)
        XCTAssertEqual(colorContents.info.version, 1)
        XCTAssertEqual(colorContents.info.author, "xcode")
        
        let firstColorSet = colorContents.colors[0]
        XCTAssertEqual(firstColorSet.idiom, "universal")
        XCTAssertEqual(firstColorSet.color.colorSpace, "srgb")
        XCTAssertEqual(firstColorSet.color.components.red, "1.000")
        XCTAssertEqual(firstColorSet.color.components.alpha, "1.000")
        XCTAssertEqual(firstColorSet.color.components.blue, "0.212")
        XCTAssertEqual(firstColorSet.color.components.green, "0.162")
    }

    static var allTests = [
        ("testExample", testParse),
    ]
}
