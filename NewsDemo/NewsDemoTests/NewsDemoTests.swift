//
//  NewsDemoTests.swift
//  NewsDemoTests
//
//  Created by SOWJI on 23/11/20.
//

import XCTest
@testable import NewsDemo

class NewsDemoTests: XCTestCase {
    let newsVM = NewsViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchSource() throws {
        self.newsVM.fetchNewsFromSource("engadget") { (_) in
            XCTAssertTrue(self.newsVM.articleCount > 1, "Articles fetched")
        }
    }
    func testFetchSource2() throws {
        self.newsVM.fetchNewsFromSource("#%") { (_) in
            XCTAssertTrue(self.newsVM.articleCount == 0, "No Articles Found for the source")
        }
    }
    func testFetchSourceEmpty() throws {
        self.newsVM.fetchNewsFromSource("") { (_) in
            XCTAssertTrue(self.newsVM.articleCount == 0, "No Articles Found for the empty source")
        }
    }
    
    func testSearchArticle() throws {
        self.newsVM.searchForNews("test") { (_) in
            XCTAssertTrue(self.newsVM.articleCount > 1, "articles searched")
        }
    }
    func testSearchArticleEmpty() throws {
        self.newsVM.searchForNews("test") { (_) in
            XCTAssertTrue(self.newsVM.articleCount == 0, "No Articles Found for empty string")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
