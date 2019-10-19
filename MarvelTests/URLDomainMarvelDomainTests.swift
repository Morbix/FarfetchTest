import XCTest
@testable import Marvel

final class URLDomainMarvelDomainTests: XCTestCase {

    func testExample() {
        XCTAssertEqual(
            URLRequestBuilder.URLDomain.marvelDomainAPI,
            "https://gateway.marvel.com"
        )
    }
}
