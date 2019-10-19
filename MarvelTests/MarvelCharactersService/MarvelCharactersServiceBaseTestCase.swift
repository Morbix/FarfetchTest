import XCTest
@testable import Marvel

class MarvelCharactersServiceBaseTestCase: XCTestCase {

    let senderSpy = RequestSenderSpy()
    lazy var sut = MarvelCharactersService(
        sender: senderSpy
    )
    
    func testDefaultParameterForSender() {
        let sut = MarvelCharactersService()
        let mirror = Mirror(reflecting: sut)
        let senderProperty = mirror.firstChild(of: URLSession.self)
        XCTAssertEqual(senderProperty === URLSession.shared, true)
    }

}
