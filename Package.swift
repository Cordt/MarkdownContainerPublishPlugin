// swift-tools-version:5.5

//
//  Package.swift
//  MarkdownContainerPublishPlugin
//
//  Created by Cordt Zermin on 18.04.21.
//


import PackageDescription

let package = Package(
    name: "MarkdownContainerPublishPlugin",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "MarkdownContainerPublishPlugin",
            targets: ["MarkdownContainerPublishPlugin"]),
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", "0.7.0"..."0.8.0"),
    ],
    targets: [
        .target(
            name: "MarkdownContainerPublishPlugin",
            dependencies: ["Publish"]
        ),
        .testTarget(
            name: "MarkdownContainerPublishPluginTests",
            dependencies: ["MarkdownContainerPublishPlugin"]
        ),
    ]
)
