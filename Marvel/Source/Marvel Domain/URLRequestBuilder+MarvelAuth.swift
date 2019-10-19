import Foundation

extension URLRequestBuilder {

    func appendMarvelAuth(date: Date = Date(),
                          privateKey: String = MarvelKeys.private,
                          publicKey: String = MarvelKeys.public) -> URLRequestBuilder {
        
        let timestamp = Int(date.timeIntervalSince1970)
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5

        return self
            .appendQueryParameter("apikey", value: publicKey)
            .appendQueryParameter("hash", value: hash)
            .appendQueryParameter("ts", value: timestamp)
    }
}
