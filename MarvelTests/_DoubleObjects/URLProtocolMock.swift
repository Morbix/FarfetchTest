import Foundation

// https://www.hackingwithswift.com/articles/153/how-to-test-ios-networking-code-the-easy-way
final class URLProtocolMock: URLProtocol {
    static var stubs = [URLRequest: Result<Data, Error>]()

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let result = URLProtocolMock.stubs[request] {
            switch result {
            case .success(let data):
                client?.urlProtocol(self, didLoad: data)
            case .failure(let error):
                client?.urlProtocol(self, didFailWithError: error)
            }
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}
