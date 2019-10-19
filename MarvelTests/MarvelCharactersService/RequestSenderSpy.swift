import Foundation
@testable import Marvel

final class RequestSenderSpy: RequestSender {
    private(set) var sendRequestCalled: Bool = false
    private(set) var requestPassed: URLRequest? = nil
    private(set) var returnTypePassed: Any? = nil
    var successToReturn: Any? = nil
    var errorToReturn: Error? = nil
    func sendRequest<T>(with request: URLRequest, returnType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        sendRequestCalled = true
        requestPassed = request
        returnTypePassed = returnType

        if let successToReturn = successToReturn as? T {
            return completion(.success(successToReturn))
        } else if let errorToReturn = errorToReturn {
            return completion(.failure(errorToReturn))
        }

        fatalError("Warning: set `successToReturn` or `errorToReturn` before invoke `sendRequest`.")
    }
}
