import XCTest
@testable import Marvel

final class CharacterListPresenterTests: XCTestCase {

    private let fetcherSpy = CharacterListFetcherSpy()
    private let dataStoreSpy = CharacterListDataStore()
    private let viewingSpy = CharacterListViewingSpy()
    private lazy var sut = CharacterListPresenter(
        dataStore: dataStoreSpy,
        fetcher: fetcherSpy
    )

    func testDataStorePassedOnContructor() {
        let mirror = Mirror(reflecting: sut)
        let dataStoreProperty = mirror.firstChild(of: CharacterListDataStore.self)
        XCTAssertNotNil(dataStoreProperty)
        XCTAssertTrue(dataStoreProperty === dataStoreSpy)
    }

    func testViewDidLoadShouldSetView() {
        sut.viewDidLoad(view: viewingSpy)

        XCTAssertNotNil(dataStoreSpy.view)
        XCTAssertTrue(dataStoreSpy.view as? CharacterListViewingSpy === viewingSpy)
    }

    func testViewDidLoadShouldShowSceneSpinner() {
        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(viewingSpy.showSceneSpinnerCalled, true)
    }

    func testViewDidLoadShouldAskForCharacters() {
        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getCharactersCalled, true)
    }

}

final class CharacterListFetcherSpy: CharacterListFetcher {

    private(set) var getCharactersCalled: Bool = false
    private(set) var getCharactersCompletionPassed: ((Result<Heroe, Error>) -> Void)? = nil
    func getCharacters(_ completion: @escaping (Result<Heroe, Error>) -> Void) {
        getCharactersCalled = true
        getCharactersCompletionPassed = completion
    }
}
