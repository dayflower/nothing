// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NothingStatusBar",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "NothingStatusBar",
            targets: ["NothingStatusBar"]
        )
    ],
    targets: [
        .executableTarget(
            name: "NothingStatusBar",
            linkerSettings: [
                .unsafeFlags([
                    "-Xlinker", "-sectcreate",
                    "-Xlinker", "__TEXT",
                    "-Xlinker", "__info_plist",
                    "-Xlinker", "BuildSupport/Info.plist"
                ])
            ]
        )
    ]
)
