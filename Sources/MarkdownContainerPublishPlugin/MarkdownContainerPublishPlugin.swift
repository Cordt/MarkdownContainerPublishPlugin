//
//  MarkdownContainerPublishPlugin.swift
//  MarkdownContainerPublishPlugin
//
//  Created by Cordt Zermin on 18.04.21.
//

import Foundation
import Publish
import Ink

fileprivate func container(from: String, using parser: @escaping (_ html: String) -> String) -> String {
    let containerPattern: String = #"<div\s*(id|class)=[\'\"](.*)[\'\"]>(.*)<\/div>"#
    do {
        let regex = try NSRegularExpression(pattern: containerPattern, options: [.dotMatchesLineSeparators])
        let stringRange = NSRange(location: 0, length: from.utf16.count)
        let matches = regex.matches(in: from, range: stringRange)
        var result: [[String]] = []
        for match in matches {
            var groups: [String] = []
            for rangeIndex in 1 ..< match.numberOfRanges {
                let range = match.range(at: rangeIndex)
                guard range.location != NSNotFound else {
                    groups.append("")
                    continue
                }
                groups.append((from as NSString).substring(with: range))
            }
            if !groups.isEmpty {
                result.append(groups)
            }
        }
        
        guard result.count == 1, let match = result.first
        else { return from }
        
        let html = parser(match[2])
        return "<div \(match[0])=\"\(match[1])\">\(html)</div>"
        
    } catch let error {
        print(error)
        return from
    }
}


public extension Plugin {
    static func identifiedMarkdownContainers() -> Self {
        Plugin(name: "MarkdownContainer") { context in
            context.markdownParser.addModifier(
                .identifiedMarkdownContainers(parser: context.markdownParser.html)
            )
        }
    }
}

public extension Modifier {
    static func identifiedMarkdownContainers(parser: @escaping (_ html: String) -> String) -> Self {
        return Modifier(target: .html) { html, _ in
            let updated = container(from: html, using: parser)
            return updated
        }
    }
}
