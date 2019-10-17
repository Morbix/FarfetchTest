import XCTest
@testable import Marvel

final class CharacterListPresenterViewDidLoadTests: CharacterListPresenterBaseTestCase {

    func testShouldSetView() {
        sut.viewDidLoad(view: viewingSpy)

        XCTAssertNotNil(dataStoreSpy.view)
        XCTAssertTrue(dataStoreSpy.view as? CharacterListViewingSpy === viewingSpy)
    }

    func testShouldShowSceneSpinner() {
        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(viewingSpy.showSceneSpinnerCalled, true)
    }

    func testShouldAskForCharacters() {
        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getCharactersCalled, true)
    }
    
}
