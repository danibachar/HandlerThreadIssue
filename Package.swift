// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "HandlerThreadIssue",
                      platforms: [.iOS(.v15), .macOS(.v13), .macCatalyst(.v15), .tvOS(.v16), .watchOS(.v9)],
                      products: [
                        .library(name: "HandlerThreadIssue",
                                 targets: ["HandlerThreadIssue"]),
                      ],
                      dependencies: [
                        .package(url: "https://github.com/apple/swift-log.git", .upToNextMajor(from: "1.5.4")),
                      ],
                      targets: [
                        .target(name: "HandlerThreadIssue",
                                dependencies: [
                                    .product(name: "Logging", package: "swift-log"),
                                ]),
                        .testTarget(name: "HandlerThreadIssueTests",
                                    dependencies: [
                                        "HandlerThreadIssue",
                                        .product(name: "Logging", package: "swift-log"),
                                    ]),
                      ])
