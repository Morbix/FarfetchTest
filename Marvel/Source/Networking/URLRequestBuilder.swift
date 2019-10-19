import Foundation

final class URLRequestBuilder {

    typealias URLDomain = String

    enum HTTPMethod: String {
        case get, post
    }

    private let domain: URLDomain
    private var pathes: [String] = []
    private var queryParameters: [String: String] = [:]
    private var method: HTTPMethod = .get

    init(with domain: URLDomain) {
        self.domain = domain
    }

    // MARK: Commands

    func appendPath(_ path: String) -> URLRequestBuilder {
        pathes.append(path)
        return self
    }

    func appendQueryParameter(_ key: String, value: @autoclosure () -> Any) -> URLRequestBuilder {
        queryParameters[key] = "\(value())".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        return self
    }

    func setHTTPMethod(_ method: HTTPMethod) -> URLRequestBuilder {
        self.method = method
        return self
    }

    // MARK: Build

    func build() -> URLRequest? {
        let separatedBy: (String) -> (String, String) -> String = { separator in
            return { (a: String, b: String) in
                "\(a)\(separator)\(b)"
            }
        }

        let allPathes = pathes
            .reduce("", separatedBy("/"))

        let allQParams = queryParameters
            .map(separatedBy("="))
            .sorted()
            .reduce("", separatedBy("&"))
            .dropFirst()

        let urlString = "\(domain)\(allPathes)\(allQParams.count > 0 ? "?\(allQParams)" : "")"

        if let url = URL(string: urlString) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            return urlRequest
        }

        return nil
    }
}
