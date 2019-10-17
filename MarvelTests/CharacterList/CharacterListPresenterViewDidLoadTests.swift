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

    func testCallNothingIfViewIsNil() throws {
        dataStoreSpy.view = nil
        viewingSpy.reset()

        let possibleResults: [ResultHeroes] = [
            .success([.init()]),
            .success([]),
            .failure(NSError.init())
        ]
        let ramdomResult = try XCTUnwrap(possibleResults.randomElement())
        let completion = try XCTUnwrap(fetcherSpy.getCharactersCompletionPassed)
        completion(ramdomResult)

        XCTAssertFalse(viewingSpy.showSceneSpinnerCalled)
        XCTAssertFalse(viewingSpy.removeSceneSpinnerCalled)
        XCTAssertFalse(viewingSpy.hideCharactersTableCalled)
        XCTAssertFalse(viewingSpy.hideRetryOptionCalled)
        XCTAssertFalse(viewingSpy.showRetryOptionCalled)
        XCTAssertFalse(viewingSpy.showRetryCellCalled)
        XCTAssertFalse(viewingSpy.showEmptyFeebackCalled)
        XCTAssertFalse(viewingSpy.hideRetryCellCalled)
    }

    func testRemoveSpinnerWhenGetCharactersReturnsWithAnyResult() throws {
        let possibleResults: [ResultHeroes] = [
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
        let result: ResultHeroes = .failure(NSError.init())
        dataStoreSpy.characters = []
        viewingSpy.reset()

        let completion = try XCTUnwrap(fetcherSpy.getCharactersCompletionPassed)
        completion(result)

        XCTAssertEqual(viewingSpy.hideCharactersTableCalled, true)
        XCTAssertEqual(viewingSpy.showRetryOptionCalled, true)

        XCTAssertEqual(viewingSpy.showRetryCellCalled, false)
    }

    func testUpdateInterfaceWhenGetCharactersReturnsWithErrorAndDataStoreIsNotEmpty() throws {
        let result: ResultHeroes = .failure(NSError.init())
        dataStoreSpy.characters = [.init()]
        viewingSpy.reset()

        let completion = try XCTUnwrap(fetcherSpy.getCharactersCompletionPassed)
        completion(result)

        XCTAssertEqual(viewingSpy.showRetryCellCalled, true)

        XCTAssertEqual(viewingSpy.hideCharactersTableCalled, false)
        XCTAssertEqual(viewingSpy.showRetryOptionCalled, false)
    }

    // MARK: - GetCharacters Returns Success But Empty

    func testUpdateInterfaceWhenGetCharactersReturnsWithEmptyResultAndDataStoreIsEmpty() throws {
        let result: ResultHeroes = .success([])
        dataStoreSpy.characters = []
        viewingSpy.reset()

        let completion = try XCTUnwrap(fetcherSpy.getCharactersCompletionPassed)
        completion(result)

        XCTAssertEqual(viewingSpy.showEmptyFeebackCalled, true)
        XCTAssertEqual(viewingSpy.hideRetryOptionCalled, true)
        XCTAssertEqual(viewingSpy.hideCharactersTableCalled, true)
        XCTAssertEqual(viewingSpy.hideRetryCellCalled, false)
    }

    func testUpdateInterfaceWhenGetCharactersReturnsWithEmptyResultAndDataStoreIsNotEmpty() throws {
        let result: ResultHeroes = .success([])
        dataStoreSpy.characters = [.init()]
        viewingSpy.reset()

        let completion = try XCTUnwrap(fetcherSpy.getCharactersCompletionPassed)
        completion(result)

        XCTAssertEqual(viewingSpy.hideRetryCellCalled, true)
        XCTAssertEqual(viewingSpy.showEmptyFeebackCalled, false)
        XCTAssertEqual(viewingSpy.hideRetryOptionCalled, false)
        XCTAssertEqual(viewingSpy.hideCharactersTableCalled, false)
    }

    func testDataStoreWhenGetCharactersReturnsWithEmptyResultAndDataStoreIsEmpty() throws {
        let result: ResultHeroes = .success([])
        dataStoreSpy.characters = []

        let completion = try XCTUnwrap(fetcherSpy.getCharactersCompletionPassed)
        completion(result)

        XCTAssertEqual(dataStoreSpy.characters.isEmpty, true)
    }

    func testDataStoreWhenGetCharactersReturnsWithEmptyResultAndDataStoreIsNotEmpty() throws {
        let result: ResultHeroes = .success([])
        dataStoreSpy.characters = [.init()]
        let beforeCount = dataStoreSpy.characters.count

        let completion = try XCTUnwrap(fetcherSpy.getCharactersCompletionPassed)
        completion(result)

        XCTAssertEqual(dataStoreSpy.characters.count, beforeCount)
        XCTAssertEqual(dataStoreSpy.characters.isEmpty, false)
    }

    // MARK: - GetCharacters Returns Characters

    func testWhenGetCharactersReturnsWithCharactersAndDataStoreIsEmpty() {
        XCTAssert(false)
        // show table
        // append items on data store
        // items.count on data store equal result.count
    }

    func testWhenGetCharactersReturnsWithCharactersAndDataStoreIsNotEmpty() {
        XCTAssert(false)
        // append items on data store
        // items.count on data store equal before + result.count
    }
}
