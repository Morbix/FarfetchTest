import XCTest
@testable import Marvel

final class URLRequestBuilderMarvelAuthTests: XCTestCase {

    private let builder: URLRequestBuilder = .init(with: "https://www.marvel.com")

    func testAppedingMarvelAuth1() {
        let date = Date(timeIntervalSince1970: 1)
        let request = builder
            .appendMarvelAuth(date: date, privateKey: "1", publicKey: "2")
            .build()

        XCTAssertEqual(
            request?.url?.absoluteString,
            "https://www.marvel.com?apikey=2&hash=7f6ffaa6bb0b408017b62254211691b5&ts=1"
        )
    }

    func testAppedingMarvelAuth2() {
        let date = Date(timeIntervalSince1970: 100)
        let request = builder
            .appendMarvelAuth(date: date, privateKey: "123", publicKey: "456")
            .build()

        XCTAssertEqual(
            request?.url?.absoluteString,
            "https://www.marvel.com?apikey=456&hash=b3545192e2d8ac6a6b0d069e6f54e83f&ts=100"
        )
    }

    func testAppedingMarvelAuth3() {
        let date = Date(timeIntervalSince1970: 10_000)
        let request = builder
            .appendMarvelAuth(date: date, privateKey: "12345", publicKey: "67890")
            .build()

        XCTAssertEqual(
            request?.url?.absoluteString,
            "https://www.marvel.com?apikey=67890&hash=c63e0d85305cc1259a665de83a054ed7&ts=10000"
        )
    }

}
