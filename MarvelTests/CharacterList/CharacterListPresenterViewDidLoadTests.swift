import XCTest
@testable import Marvel

final class CharacterListPresenterViewDidLoadTests: CharacterListPresenterBaseTestCase {

    override func setUp() {
        super.setUp()

        sut.viewDidLoad(view: viewingSpy)
    }
    func testSetView() {
        XCTAssertNotNil(dataStoreSpy.view)
        XCTAssertTrue(dataStoreSpy.view as? CharacterListViewingSpy === viewingSpy)
    }

    func testHideCharactersTable() {
        XCTAssertEqual(viewingSpy.hideCharactersTableCalled, true)
    }

    func testHideRetryOption() {
        XCTAssertEqual(viewingSpy.hideRetryOptionCalled, true)
    }

    func testHideEmptyFeeedback() {
        XCTAssertEqual(viewingSpy.hideEmptyFeedbackCalled, true)
    }

    func testShowSceneSpinner() {
        XCTAssertEqual(viewingSpy.showSceneSpinnerCalled, true)
    }

    func testAskForCharactersWithoutSkipping() {
        XCTAssertEqual(fetcherSpy.getCharactersCalled, true)
        XCTAssertEqual(fetcherSpy.skipPassed, 0)
    }

    func testSetSceneTitle() {
        XCTAssertEqual(viewingSpy.setSceneTitleCalled, true)
        XCTAssertEqual(viewingSpy.titlePassed, "Marvel Heroes")
    }
}
