import XCTest
@testable import Marvel

final class MarvelCharactersServiceGetContentTests: MarvelCharactersServiceBaseTestCase {

    private let completionSpy = CompletionSpy()

    func testRequestPassedForCommics() throws {
        senderSpy.errorToReturn = NSError.unexpectedFailure

        sut.getContent(type: .comics, characterId: 999, completion: completionSpy.completion)

        XCTAssertEqual(senderSpy.requestPassed?.httpMethod, "GET")
        let url = try XCTUnwrap(senderSpy.requestPassed?.url)
        XCTAssertTrue(url.absoluteString.contains("https://gateway.marvel.com/v1/public/characters/999/comics?"))
        XCTAssertTrue(url.absoluteString.contains("limit=20"))
        XCTAssertTrue(url.absoluteString.contains("hash="))
        XCTAssertTrue(url.absoluteString.contains("apikey="))
        XCTAssertTrue(url.absoluteString.contains("ts="))
    }

    func testRequestPassedForSeries() throws {
        senderSpy.errorToReturn = NSError.unexpectedFailure

        sut.getContent(type: .series, characterId: 999, completion: completionSpy.completion)

        XCTAssertEqual(senderSpy.requestPassed?.httpMethod, "GET")
        let url = try XCTUnwrap(senderSpy.requestPassed?.url)
        XCTAssertTrue(url.absoluteString.contains("https://gateway.marvel.com/v1/public/characters/999/series?"))
        XCTAssertTrue(url.absoluteString.contains("limit=20"))
        XCTAssertTrue(url.absoluteString.contains("hash="))
        XCTAssertTrue(url.absoluteString.contains("apikey="))
        XCTAssertTrue(url.absoluteString.contains("ts="))
    }

    func testRequestPassedForStories() throws {
        senderSpy.errorToReturn = NSError.unexpectedFailure

        sut.getContent(type: .stories, characterId: 999, completion: completionSpy.completion)

        XCTAssertEqual(senderSpy.requestPassed?.httpMethod, "GET")
        let url = try XCTUnwrap(senderSpy.requestPassed?.url)
        XCTAssertTrue(url.absoluteString.contains("https://gateway.marvel.com/v1/public/characters/999/stories?"))
        XCTAssertTrue(url.absoluteString.contains("limit=20"))
        XCTAssertTrue(url.absoluteString.contains("hash="))
        XCTAssertTrue(url.absoluteString.contains("apikey="))
        XCTAssertTrue(url.absoluteString.contains("ts="))
    }

    func testRequestPassedForEvents() throws {
        senderSpy.errorToReturn = NSError.unexpectedFailure

        sut.getContent(type: .events, characterId: 999, completion: completionSpy.completion)

        XCTAssertEqual(senderSpy.requestPassed?.httpMethod, "GET")
        let url = try XCTUnwrap(senderSpy.requestPassed?.url)
        XCTAssertTrue(url.absoluteString.contains("https://gateway.marvel.com/v1/public/characters/999/events?"))
        XCTAssertTrue(url.absoluteString.contains("limit=20"))
        XCTAssertTrue(url.absoluteString.contains("hash="))
        XCTAssertTrue(url.absoluteString.contains("apikey="))
        XCTAssertTrue(url.absoluteString.contains("ts="))
    }

    func testFailure() {
        senderSpy.errorToReturn = NSError(
            domain: "domain", code: 999, userInfo: nil
        )

        sut.getContent(type: .comics, characterId: .init(), completion: completionSpy.completion)

        wait(for: [completionSpy.testExpectation], timeout: 3)

        XCTAssertEqual(completionSpy.isMainThread, true)
        XCTAssertEqual(completionSpy.completionCalled, true)
        let error = completionSpy.errorPassed as NSError?
        XCTAssertEqual(error?.code, 999)
        XCTAssertEqual(error?.domain, "domain")
    }

    func testSuccessWithEmptyResult() {
        senderSpy.successToReturn = ContentResponse(
            data: .init(
                offset: .init(),
                total: .init(),
                count: .init(),
                results: []
            )
        ) as Any

        sut.getContent(type: .fixtureRamdom, characterId: .init(), completion: completionSpy.completion)

        wait(for: [completionSpy.testExpectation], timeout: 3)

        XCTAssertEqual(completionSpy.isMainThread, true)
        XCTAssertEqual(completionSpy.completionCalled, true)
        XCTAssertEqual(completionSpy.contentPassed?.isEmpty, true)
    }

    func testSuccessWithContent() {
        senderSpy.successToReturn = ContentResponse(
            data: .init(
                offset: .init(),
                total: .init(),
                count: .init(),
                results: [
                    .init(id: 1)
                ]
            )
        ) as Any

        sut.getContent(type: .fixtureRamdom, characterId: .init(), completion: completionSpy.completion)

        wait(for: [completionSpy.testExpectation], timeout: 3)

        XCTAssertEqual(completionSpy.isMainThread, true)
        XCTAssertEqual(completionSpy.completionCalled, true)
        XCTAssertEqual(completionSpy.contentPassed?.count, 1)
        let item = completionSpy.contentPassed?.first
        XCTAssertEqual(item?.name, "item 1")
        XCTAssertEqual(item?.description, "description 1")
    }

    func testSuccessWithHeroes() {
        senderSpy.successToReturn = ContentResponse(
            data: .init(
                offset: .init(),
                total: .init(),
                count: .init(),
                results: [
                    .init(id: 1),
                    .init(id: 2),
                    .init(id: 3),
                ]
            )
        ) as Any

        sut.getContent(type: .fixtureRamdom, characterId: .init(), completion: completionSpy.completion)

        wait(for: [completionSpy.testExpectation], timeout: 3)

        XCTAssertEqual(completionSpy.isMainThread, true)
        XCTAssertEqual(completionSpy.completionCalled, true)
        XCTAssertEqual(completionSpy.contentPassed?.count, 3)

        let item1 = completionSpy.contentPassed?[safe: 0]
        XCTAssertEqual(item1?.name, "item 1")
        XCTAssertEqual(item1?.description, "description 1")

        let item2 = completionSpy.contentPassed?[safe: 1]
        XCTAssertEqual(item2?.name, "item 2")
        XCTAssertEqual(item2?.description, "description 2")

        let item3 = completionSpy.contentPassed?[safe: 2]
        XCTAssertEqual(item3?.name, "item 3")
        XCTAssertEqual(item3?.description, "description 3")
    }

}

// MARK: - CompletionSpy

private class CompletionSpy {

    let testExpectation = XCTestExpectation(description: "completion")

    private(set) var completionCalled: Bool = false
    private(set) var contentPassed: [Content]? = nil
    private(set) var errorPassed: Error? = nil
    private(set) var isMainThread: Bool = false
    func completion(_ result: ResultContent) {

        isMainThread = Thread.isMainThread

        completionCalled = true

        switch result {
        case .success(let content):
            contentPassed = content
        case .failure(let error):
            errorPassed = error
        }

        testExpectation.fulfill()
    }
}

// MARK: ContentResponse.Data.Item Dummy

extension ContentResponse.Data.Item {
    init(id: Int) {
        self.init(id: id, name: "item \(id)", description: "description \(id)")
    }
}

// MARK: ContentType {
extension ContentType {
    static var fixtureRamdom: ContentType {
        return [
            .comics,
            .series,
            .stories,
            .events
        ].randomElement() ?? .comics
    }
}
