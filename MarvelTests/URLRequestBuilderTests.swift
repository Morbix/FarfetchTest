import XCTest
@testable import Marvel

final class URLRequestBuilderTests: XCTestCase {

    private let builder: URLRequestBuilder = .init(with: "https://www.marvel.com")

    func testEmptyDomain() {
        let builder = URLRequestBuilder(with: .init())
        XCTAssertNil(builder.build())
    }

    func testWithoutAnyConfiguration() {
        let request = builder
            .build()

        XCTAssertEqual(
            request?.url?.absoluteString,
            "https://www.marvel.com"
        )

        XCTAssertEqual(request?.httpMethod, "GET")
    }

    func testSettingGetMethod() {
        let request = builder
            .setHTTPMethod(.get)
            .build()

        XCTAssertEqual(request?.httpMethod, "GET")
    }

    func testSettingPostMethod() {
        let request = builder
            .setHTTPMethod(.post)
            .build()

        XCTAssertEqual(request?.httpMethod, "POST")
    }

    func testAppendingPath() {
        let request = builder
            .appendPath("somepath")
            .build()

        XCTAssertEqual(
            request?.url?.absoluteString,
            "https://www.marvel.com/somepath"
        )
    }

    func testAppendingPathes() {
        let request = builder
            .appendPath("somepath1")
            .appendPath("somepath2")
            .appendPath("somepath3")
            .build()

        XCTAssertEqual(
            request?.url?.absoluteString,
            "https://www.marvel.com/somepath1/somepath2/somepath3"
        )
    }

    func testAppendingQueryParameter() {
        let request = builder
            .appendQueryParameter("key", value: "value")
            .build()

        XCTAssertEqual(
            request?.url?.absoluteString,
            "https://www.marvel.com?key=value"
        )
    }

    func testAppendingQueryParameters() {
        let request = builder
            .appendQueryParameter("key1", value: "value 1")
            .appendQueryParameter("key2", value: 2)
            .appendQueryParameter("key3", value: ErrorResponse(code: -1, status: "error"))
            .build()

        XCTAssertEqual(
            request?.url?.absoluteString,
            "https://www.marvel.com?key1=value%201&key2=2&key3=ErrorResponse(code%3A%20-1,%20status%3A%20%22error%22)"
        )
    }
}
