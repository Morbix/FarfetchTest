import XCTest
@testable import Marvel

final class CharacterListPresenterTests: XCTestCase {

    private let dataStoreSpy = CharacterListDataStore()
    private let viewingSpy = CharacterListViewingSpy()
    private lazy var sut = CharacterListPresenter(
        dataStore: dataStoreSpy
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

}
