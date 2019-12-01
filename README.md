# ZeplinDarkLightAssetBundler

Zeplin is great design spec tool, but It has not been implemented dark/light assets bundle function. This tool helps bundling them.

## Installation
1. Checkout the code
2. Run `swift build -c release`
3. run `cd .build/release`
4. `cp -f ZeplinDarkLightAssetBundler /usr/local/bin`

## Usage
`ZeplinDarkLightAssetBundler --input [inputXCAssetsURL] --output [expectedOutputXCAssetsURL]`

If you don't pass input path, `{cwd}/{PROJECT_DIR}/Assets.xcassets` is used to input
If you don't pass output path, input path is used as output path.

## Example
`ZeplinDarkLightAssetBundler --i path/to/your/assets.xcassets --output path/to/your/newAssets.xcassets`
