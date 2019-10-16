import XCTest
@testable import Marvel

final class MD5Tests: XCTestCase {

    func testHash() {
        let hashGenerated =  "dummy content".md5
        let hashExpected = "90c55a38064627dca337dfa5fc5be120"

        XCTAssertEqual(hashGenerated, hashExpected)
    }

    func testPrintHash() {
        let timestamp = Int(Date().timeIntervalSince1970)
        let privateKey = MarvelKeys.private
        let publicKey = MarvelKeys.public

        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5

        print(timestamp, hash)
        print("hash=\(hash)&ts=\(timestamp)")
    }
}
