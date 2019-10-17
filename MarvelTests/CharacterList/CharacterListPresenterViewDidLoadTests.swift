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

    func testShowSceneSpinner() {
        XCTAssertEqual(viewingSpy.showSceneSpinnerCalled, true)
    }

    func testAskForCharacters() {
        XCTAssertEqual(fetcherSpy.getCharactersCalled, true)
    }

    // MARK: - GetCharacters Returns Any

    func testRemoveSpinnerWhenGetCharactersReturnsWithAnyResult() throws {
        let possibleResults: [Result<[Heroe], Error>] = [
            .success([.init()]),
            .success([]),
            .failure(NSError.init())
        ]
        let ramdomResult = try XCTUnwrap(possibleResults.randomElement())
        let completion = try XCTUnwrap(fetcherSpy.getCharactersCompletionPassed)
        completion(ramdomResult)

        XCTAssertEqual(viewingSpy.removeSceneSpinnerCalled, true)
    }

    // MARK: - GetCharacters Returns An Error

    func testUpdateInterfaceWhenGetCharactersReturnsWithErrorAndDataStoreIsEmpty() throws {
        let result: Result<[Heroe], Error> = .failure(NSError.init())
        dataStoreSpy.characters = []
        viewingSpy.reset()

        let completion = try XCTUnwrap(fetcherSpy.getCharactersCompletionPassed)
        completion(result)

        XCTAssertEqual(viewingSpy.hideCharactersTableCalled, true)
        XCTAssertEqual(viewingSpy.showRetryOptionCalled, true)
        XCTAssertEqual(viewingSpy.showRetryCellCalled, false)
    }

    func testUpdateInterfaceWhenGetCharactersReturnsWithErrorAndDataStoreIsNotEmpty() throws {
        let result: Result<[Heroe], Error> = .failure(NSError.init())
        dataStoreSpy.characters = [.init()]
        viewingSpy.reset()

        let completion = try XCTUnwrap(fetcherSpy.getCharactersCompletionPassed)
        completion(result)

        XCTAssertEqual(viewingSpy.hideCharactersTableCalled, false)
        XCTAssertEqual(viewingSpy.showRetryOptionCalled, false)
        XCTAssertEqual(viewingSpy.showRetryCellCalled, true)
    }

    // MARK: - GetCharacters Returns Success

    func testWhenGetCharactersReturnsWithEmptyResult() {
        XCTAssert(false)
    }

    func testWhenGetCharactersReturnsWithCharacters() {
        XCTAssert(false)
    }
}
