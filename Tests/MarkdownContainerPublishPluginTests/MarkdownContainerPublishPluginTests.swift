//
//  MarkdownContainerPublishPluginTests.swift
//  MarkdownContainerPublishPlugin
//
//  Created by Cordt Zermin on 18.04.21.
//

import XCTest
@testable import MarkdownContainerPublishPlugin
import Ink

final class MarkdownContainerPublishPluginTests: XCTestCase {
    
    func testHighlightingMarkdown() {
        var parser = MarkdownParser()
        parser.addModifier(.identifiedMarkdownContainers(parser: parser.html))
        let html = parser.html(from:
            """
            Some text
            <div id="table-of-contents">
            ## Table of Contents
            Some paragraph
            ![Image](/assets/img/article.jpg)
            </div>
            """
        )
        
        let expected =
            """
            <p>Some text</p><div id="table-of-contents"><h2>Table of Contents</h2><p>Some paragraph <img src="/assets/img/article.jpg" alt="Image"/></p></div>
            """
        
        XCTAssertEqual(html, expected)
    }
}
