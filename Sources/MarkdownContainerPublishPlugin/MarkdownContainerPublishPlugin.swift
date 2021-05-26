//
//  MarkdownContainerPublishPlugin.swift
//  MarkdownContainerPublishPlugin
//
//  Created by Cordt Zermin on 18.04.21.
//


import Publish
import Ink

public extension Plugin {
    static func identifiedMarkdownContainers() -> Self {
        Plugin(name: "MarkdownContainer") { context in
            context.markdownParser.addModifier(.identifiedMarkdownContainers())
        }
    }
}

fileprivate var stack: [String] = []

public extension Modifier {
    static func identifiedMarkdownContainers() -> Self {
        return Modifier(target: .headings) { html, markdown in
            guard markdown[markdown.startIndex] == "#",
                  markdown[markdown.index(markdown.startIndex, offsetBy: 1)] != "#"
            else { return html }
            
            guard let separatorIndex = markdown.firstIndex(of: ":")
            else { return html }
            
            let containerPosition = markdown
                .prefix(upTo: separatorIndex)
                .suffix(from: markdown.index(markdown.startIndex, offsetBy: 2))
                
            let containerClasses = markdown
                .prefix(upTo: markdown.index(markdown.endIndex, offsetBy: -2))
                .suffix(from: markdown.index(after: separatorIndex))
                .split(separator: ":")
            
            if containerPosition.elementsEqual("start-container") {
                stack.append(String(containerClasses.joined(separator: ":")))
                return #"<div class="\#(containerClasses.joined(separator: " "))">"#
            }
            else if containerPosition.elementsEqual("end-container") {
                guard stack.removeLast() == containerClasses.joined(separator: ":")
                else { return html }
                return #"</div>"#
            }
            else {
                return html
            }
        }
    }
}
