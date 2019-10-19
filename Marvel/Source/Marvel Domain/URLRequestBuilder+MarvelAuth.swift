import Foundation

extension URLRequestBuilder {

    func appendMarvelAuth(date: Date = Date()) -> URLRequestBuilder {
        
        let timestamp = Int(date.timeIntervalSince1970)
        let privateKey = MarvelKeys.private
        let publicKey = MarvelKeys.public
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5

        return self
            .appendQueryParameter("apikey", value: publicKey)
            .appendQueryParameter("hash", value: hash)
            .appendQueryParameter("ts", value: timestamp)
    }
}
