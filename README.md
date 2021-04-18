# Markdown Container plugin for Publish

A [Publish](https://github.com/johnsundell/publish) plugin that allows using container (`<div>`) with ids or classes in a Publish website.

## Installation

To install it into your [Publish](https://github.com/johnsundell/publish) package, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    ...
    dependencies: [
        ...
        .package(name: "MarkdownContainerPublishPlugin", url: "https://github.com/Cordt/MarkdownContainerPublishPlugin", .branch("main"))
    ],
    targets: [
        .target(
            ...
            dependencies: [
                ...
                "MarkdownContainerPublishPlugin"
            ]
        )
    ]
    ...
)
```

Then import MarkdownContainerPublishPlugin wherever you’d like to use it:

```swift
import MarkdownContainerPublishPlugin
```

For more information on how to use the Swift Package Manager, check out [this article by John Sundell](https://www.swiftbysundell.com/articles/managing-dependencies-using-the-swift-package-manager), or [its official documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation).

## Usage

The plugin can then be used within any publishing pipeline like this:

```swift
import ResponsivePublishPlugin
...
try DeliciousRecipes().publish(using: [
    ...
        .generateHTML(),
        .installPlugin(.identifiedMarkdownContainers()),
    ...
])
```

In your Markdown files, you can now wrap any markdown using containers with an id or class:

```Markdown
Some text
<div id="table-of-contents">
## Table of Contents
Some paragraph
![Image](/assets/img/article.jpg)
</div>
```
