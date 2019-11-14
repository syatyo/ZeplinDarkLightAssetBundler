import XCTest
@testable import ZeplinDarkLightAssetBundler

final class ColorTests: XCTestCase {
    
    func testDecode() {
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
    
    func testEncode() {
        let lightColor = ColorContents.ColorSet(idiom: "universal",
                                                appearances: nil,
                                                color: .init(colorSpace: "srgb",
                                                             components: .init(red: "1.000",
                                                                               alpha: "1.000",
                                                                               blue: "1.000",
                                                                               green: "1.000")))
        let darkColor = ColorContents.ColorSet.init(idiom: "universal",
                                                    appearances: [.init(appearance: "luminosity", value: "dark")],
                                                    color: .init(colorSpace: "srgb",
                                                                 components: .init(red: "0.213",
                                                                                   alpha: "1.000",
                                                                                   blue: "1.000",
                                                                                   green: "0.417")))
        
        let contents = ColorContents(info: .init(version: 1, author: "xcode"),
                                     colors: [lightColor, darkColor])
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(contents)
        let string = String(data: data, encoding: .utf8)!
        
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
                  "blue" : "1.000",
                  "green" : "1.000"
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
                  "red" : "0.213",
                  "alpha" : "1.000",
                  "blue" : "1.000",
                  "green" : "0.417"
                }
              }
            }
          ]
        }
        """
        
        XCTAssertEqual(string, testString)
    }
    
    
    static var allTests = [
        ("testDecode", testDecode),
        ("testEncode", testEncode)
    ]
}
