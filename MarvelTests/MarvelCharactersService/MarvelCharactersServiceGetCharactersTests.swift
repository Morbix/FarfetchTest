import XCTest
@testable import Marvel

final class MarvelCharactersServiceGetCharactersTests: MarvelCharactersServiceBaseTestCase {

    private let completionSpy = CompletionSpy()

    func testRequestPassed() throws {
        senderSpy.errorToReturn = NSError.unexpectedFailure

        sut.getCharacters(completionSpy.completion)

        XCTAssertEqual(senderSpy.requestPassed?.httpMethod, "GET")
        let url = try XCTUnwrap(senderSpy.requestPassed?.url)
        XCTAssertTrue(url.absoluteString.contains("https://gateway.marvel.com/v1/public/characters?"))
        XCTAssertTrue(url.absoluteString.contains("orderBy=name"))
        XCTAssertTrue(url.absoluteString.contains("limit=20"))
        XCTAssertTrue(url.absoluteString.contains("hash="))
        XCTAssertTrue(url.absoluteString.contains("apikey="))
        XCTAssertTrue(url.absoluteString.contains("ts="))
    }

    func testFailure() {
        senderSpy.errorToReturn = NSError(
            domain: "domain", code: 999, userInfo: nil
        )

        sut.getCharacters(completionSpy.completion)

        wait(for: [completionSpy.testExpectation], timeout: 1)

        XCTAssertEqual(completionSpy.isMainThread, true)
        XCTAssertEqual(completionSpy.completionCalled, true)
        let error = completionSpy.errorPassed as NSError?
        XCTAssertEqual(error?.code, 999)
        XCTAssertEqual(error?.domain, "domain")
    }

    func testSuccessWithEmptyResult() {
        senderSpy.successToReturn = CharactersResponse(
            data: .init(
                offset: .init(),
                total: .init(),
                count: .init(),
                results: []
            )
        ) as Any

        sut.getCharacters(completionSpy.completion)

        wait(for: [completionSpy.testExpectation], timeout: 1)

        XCTAssertEqual(completionSpy.isMainThread, true)
        XCTAssertEqual(completionSpy.completionCalled, true)
        XCTAssertEqual(completionSpy.heroesPassed?.isEmpty, true)
    }

    func testSuccessWithHero() {
        senderSpy.successToReturn = CharactersResponse(
            data: .init(
                offset: .init(),
                total: .init(),
                count: .init(),
                results: [
                    .init(id: 1, name: "name")
                ]
            )
        ) as Any

        sut.getCharacters(completionSpy.completion)

        wait(for: [completionSpy.testExpectation], timeout: 1)

        XCTAssertEqual(completionSpy.isMainThread, true)
        XCTAssertEqual(completionSpy.completionCalled, true)
        XCTAssertEqual(completionSpy.heroesPassed?.count, 1)
        let hero = completionSpy.heroesPassed?.first
        XCTAssertEqual(hero?.name, "name")
    }

    func testSuccessWithHeroes() {
        senderSpy.successToReturn = CharactersResponse(
            data: .init(
                offset: .init(),
                total: .init(),
                count: .init(),
                results: [
                    .init(id: 1, name: "name1"),
                    .init(id: 2, name: "name2"),
                    .init(id: 3, name: "name3"),
                ]
            )
        ) as Any

        sut.getCharacters(completionSpy.completion)

        wait(for: [completionSpy.testExpectation], timeout: 1)

        XCTAssertEqual(completionSpy.isMainThread, true)
        XCTAssertEqual(completionSpy.completionCalled, true)
        XCTAssertEqual(completionSpy.heroesPassed?.count, 3)

        let hero1 = completionSpy.heroesPassed?[safe: 0]
        XCTAssertEqual(hero1?.name, "name1")

        let hero2 = completionSpy.heroesPassed?[safe: 1]
        XCTAssertEqual(hero2?.name, "name2")

        let hero3 = completionSpy.heroesPassed?[safe: 2]
        XCTAssertEqual(hero3?.name, "name3")
    }

}

// MARK: - CompletionSpy

private class CompletionSpy {

    let testExpectation = XCTestExpectation(description: "completion")

    private(set) var completionCalled: Bool = false
    private(set) var heroesPassed: [Hero]? = nil
    private(set) var errorPassed: Error? = nil
    private(set) var isMainThread: Bool = false
    func completion(_ result: ResultHeroes) {

        isMainThread = Thread.isMainThread

        completionCalled = true

        switch result {
        case .success(let heroes):
            heroesPassed = heroes
        case .failure(let error):
            errorPassed = error
        }

        testExpectation.fulfill()
    }
}
