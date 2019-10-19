import XCTest
@testable import Marvel

final class URLSessionResumeTaskTests: XCTestCase {

    private let completionSpy = CompletionSpy<DecodableStub>()
    private let request = URLRequest(
        url: URL(string: "https://www.somedomain.com")!
    )
    private let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return config
    }()
    private lazy var sut = URLSession(configuration: configuration)

    func testFailureWithoutErrorAndWithoutData() {
        URLProtocolMock.stubs[request] = nil

        sut.resumeTask(with: request, returnType: DecodableStub.self, completion: completionSpy.completion)

        wait(for: [completionSpy.testExpectation], timeout: 1)

        XCTAssertEqual(completionSpy.completionCalled, true)
        let error = completionSpy.errorPassed as NSError?
        XCTAssertEqual(error?.code, -1)
        XCTAssertEqual(error?.domain, "Unexpected failure")
    }

    func testFailureWithError() {
        URLProtocolMock.stubs[request] = .failure(
            NSError(domain: "domain", code: 999, userInfo: nil)
        )

        sut.resumeTask(with: request, returnType: DecodableStub.self, completion: completionSpy.completion)

        wait(for: [completionSpy.testExpectation], timeout: 1)

        XCTAssertEqual(completionSpy.completionCalled, true)
        let error = completionSpy.errorPassed as NSError?
        XCTAssertEqual(error?.code, 999)
        XCTAssertEqual(error?.domain, "domain")
    }

    func testSuccessWithWrongDataFormat() throws {
        let data = try XCTUnwrap("some data".data(using: .utf8))
        URLProtocolMock.stubs[request] = .success(data)

        sut.resumeTask(with: request, returnType: DecodableStub.self, completion: completionSpy.completion)

        wait(for: [completionSpy.testExpectation], timeout: 1)

        XCTAssertEqual(completionSpy.completionCalled, true)
        let error = completionSpy.errorPassed as NSError?
        XCTAssertEqual(error?.code, -1)
        XCTAssertEqual(error?.domain, "Unexpected failure")
    }

    func testSuccessWithErrorResponseFormat() throws {
        let data = try JSONEncoder().encode(
            ErrorResponse(code: 999, status: "error message")
        )
        URLProtocolMock.stubs[request] = .success(data)

        sut.resumeTask(with: request, returnType: DecodableStub.self, completion: completionSpy.completion)

        wait(for: [completionSpy.testExpectation], timeout: 1)

        XCTAssertEqual(completionSpy.completionCalled, true)
        let error = completionSpy.errorPassed as NSError?
        XCTAssertEqual(error?.code, 999)
        XCTAssertEqual(error?.domain, "error message")
    }

    func testSuccessWithDataResponseFormat() throws {
        let data = try JSONEncoder().encode(
            DecodableStub(foo: 1, bar: "bar")
        )
        URLProtocolMock.stubs[request] = .success(data)

        sut.resumeTask(with: request, returnType: DecodableStub.self, completion: completionSpy.completion)

        wait(for: [completionSpy.testExpectation], timeout: 1)

        XCTAssertEqual(completionSpy.completionCalled, true)
        XCTAssertEqual(completionSpy.decodablePassed?.foo, 1)
        XCTAssertEqual(completionSpy.decodablePassed?.bar, "bar")
    }
}

// MARK: - DecodableStub

private struct DecodableStub: Codable {
    let foo: Int
    let bar: String
}

// MARK: - CompletionSpy

private class CompletionSpy<T: Decodable> {

    let testExpectation = XCTestExpectation(description: "completion")

    private(set) var completionCalled: Bool = false
    private(set) var decodablePassed: T? = nil
    private(set) var errorPassed: Error? = nil
    func completion(_ result: Result<T, Error>) {

        completionCalled = true

        switch result {
        case .success(let decodable):
            decodablePassed = decodable
        case .failure(let error):
            errorPassed = error
        }

        testExpectation.fulfill()
    }
}
