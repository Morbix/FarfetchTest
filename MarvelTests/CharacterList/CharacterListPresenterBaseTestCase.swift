import XCTest
@testable import Marvel

class CharacterListPresenterBaseTestCase: XCTestCase {

    let fetcherSpy = CharacterListFetcherSpy()
    let dataStoreSpy = CharacterListDataStore()
    let viewingSpy = CharacterListViewingSpy()
    
    lazy var sut = CharacterListPresenter(
        dataStore: dataStoreSpy,
        fetcher: fetcherSpy
    )
}
