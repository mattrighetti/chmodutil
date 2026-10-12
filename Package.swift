// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "ChmodCore",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [.library(name: "ChmodCore", targets: ["ChmodCore"])],
    targets: [
        .target(name: "ChmodCore", path: "Shared/Utils"),
        .testTarget(name: "ChmodCoreTests", dependencies: ["ChmodCore"], path: "CoreTests")
    ]
)
