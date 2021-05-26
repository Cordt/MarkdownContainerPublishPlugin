# Markdown Container plugin for Publish

A [Publish](https://github.com/johnsundell/publish) plugin that allows using plain Markdown to define containers (`<div>`) with a class in the Markdown files of a Publish website.

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

In your Markdown files, you can now add containers (div) using the following notation:

```Markdown
Some text
# start-container:table-of-contents #
## Table of Contents
Some paragraph
![Image](/assets/img/article.jpg)
# end-container:table-of-contents #
```

The plugin simply uses the Markdown-Parser to achieve this which means that the spaces are important.
It also verifies that every container that was opened is closed and the nesting of containers is not mixed up.
**Note**:  In the case of a wrong nesting, the plugin will simply return the html for that document and not handle the Markdown anymore, since Publish currently doesn't support throwing Markdown Modifiers.

It is also possible to add more than one class, by adding them separated by a colon:

```Markdown
# start-container:table-of-contents:a-second-class #
## Table of Contents
Some paragraph
![Image](/assets/img/article.jpg)
# end-container:table-of-contents:a-second-class #
```

**Note**: The end marker has to match all classes in the same order as well.
