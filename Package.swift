// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "LightningKit",
    platforms: [.iOS(.v10)],
    products: [
        .library(name: "LightningKit", targets: ["LightningKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/grpc/grpc-swift.git", Package.Dependency.Requirement.branch("nio")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "5.0.0")
    ],
    targets: [
        .target(name: "LightningKit", dependencies: ["GRPC", "RxSwift", "RxCocoa"])
    ]
)
