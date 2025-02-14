import Foundation

extension URLSession: RequestSender {

    func sendRequest<T: Decodable>(with request: URLRequest,
                                   returnType: T.Type,
                                   completion: @escaping (Result<T, Error>) -> Void) {

        let task = dataTask(with: request) { data, _, error in
            guard let data = data, !data.isEmpty else {
                return completion(.failure(error ?? NSError.unexpectedFailure))
            }

            guard let response = try? JSONDecoder().decode(returnType, from: data) else {
                guard let response = try? JSONDecoder().decode(WrapperResponse.self, from: data) else {
                    return completion(.failure(NSError.unexpectedFailure))
                }
                let error = NSError(
                    domain: response.status,
                    code: response.code,
                    userInfo: nil
                )
                return completion(.failure(error))
            }

            completion(.success(response))
        }

        task.resume()
    }
}
