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
    
    func testContainerIsAdded() throws {
        var parser = MarkdownParser()
        parser.addModifier(.identifiedMarkdownContainers())
        let html = parser.html(from:
            """
            Some text
            
            # start-container:table-of-contents #
            
            ## Table of Contents
            Some paragraph
            ![Image](/assets/img/article.jpg)
            
            # end-container:table-of-contents #
            """
        )
        
        let expected =
            """
            <p>Some text</p><div class="table-of-contents"><h2>Table of Contents</h2><p>Some paragraph <img src="/assets/img/article.jpg" alt="Image"/></p></div>
            """
        
        XCTAssertEqual(html, expected)
    }
    
    func testContainerWithMoreClassesIsAdded() throws {
        var parser = MarkdownParser()
        parser.addModifier(.identifiedMarkdownContainers())
        let html = parser.html(from:
            """
            Some text
            
            # start-container:table-of-contents:second-class #
            
            ## Table of Contents
            Some paragraph
            ![Image](/assets/img/article.jpg)
            
            # end-container:table-of-contents:second-class #
            """
        )
        
        let expected =
            """
            <p>Some text</p><div class="table-of-contents second-class"><h2>Table of Contents</h2><p>Some paragraph <img src="/assets/img/article.jpg" alt="Image"/></p></div>
            """
        
        XCTAssertEqual(html, expected)
    }
    
    func testNestedContainersAreAdded() throws {
        var parser = MarkdownParser()
        parser.addModifier(.identifiedMarkdownContainers())
        let html = parser.html(from:
            """
            Some text
            
            # start-container:table-of-contents #
            
            ## Table of Contents
            Some paragraph
            ![Image](/assets/img/article.jpg)
            
            # start-container:highlighted-image #
            ![Image](/assets/img/article.jpg)
            # end-container:highlighted-image #
            
            # end-container:table-of-contents #
            """
        )
        
        let expected =
            """
            <p>Some text</p><div class="table-of-contents"><h2>Table of Contents</h2><p>Some paragraph <img src="/assets/img/article.jpg" alt="Image"/></p><div class="highlighted-image"><img src="/assets/img/article.jpg" alt="Image"/></div></div>
            """
        
        XCTAssertEqual(html, expected)
    }
    
    func testWrongNestingFails() {
        var parser = MarkdownParser()
        parser.addModifier(.identifiedMarkdownContainers())
        let html = parser.html(from:
            """
            Some text
            
            # start-container:table-of-contents #
            
            ## Table of Contents
            Some paragraph
            ![Image](/assets/img/article.jpg)
            
            # start-container:highlighted-image #
            ![Image](/assets/img/article.jpg)
            # end-container:table-of-contents #
            
            # end-container:highlighted-image #
            """
        )
        
        let expected =
            """
            <p>Some text</p><div class="table-of-contents"><h2>Table of Contents</h2><p>Some paragraph <img src="/assets/img/article.jpg" alt="Image"/></p><div class="highlighted-image"><img src="/assets/img/article.jpg" alt="Image"/><h1>end-container:table-of-contents</h1><h1>end-container:highlighted-image</h1>
            """
        
        XCTAssertEqual(html, expected)
    }
}
