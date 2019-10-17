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

    func testCallNothingIfViewIsNil() {
        dataStoreSpy.view = nil
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureRamdom)

        XCTAssertFalse(viewingSpy.showSceneSpinnerCalled)
        XCTAssertFalse(viewingSpy.removeSceneSpinnerCalled)
        XCTAssertFalse(viewingSpy.hideCharactersTableCalled)
        XCTAssertFalse(viewingSpy.hideRetryOptionCalled)
        XCTAssertFalse(viewingSpy.showRetryOptionCalled)
        XCTAssertFalse(viewingSpy.showRetryCellCalled)
        XCTAssertFalse(viewingSpy.showEmptyFeebackCalled)
        XCTAssertFalse(viewingSpy.hideRetryCellCalled)
    }

    func testRemoveSpinnerWhenGetCharactersReturnsWithAnyResult() {
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureRamdom)

        XCTAssertEqual(viewingSpy.removeSceneSpinnerCalled, true)
    }

    // MARK: - GetCharacters Returns An Error

    func testUpdateInterfaceWhenGetCharactersReturnsWithErrorAndDataStoreIsEmpty() {
        dataStoreSpy.characters = []
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureAnyFailure)

        XCTAssertEqual(viewingSpy.hideCharactersTableCalled, true)
        XCTAssertEqual(viewingSpy.showRetryOptionCalled, true)
        XCTAssertEqual(viewingSpy.showRetryCellCalled, false)
    }

    func testUpdateInterfaceWhenGetCharactersReturnsWithErrorAndDataStoreIsNotEmpty() {
        dataStoreSpy.characters = [.init()]
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureAnyFailure)

        XCTAssertEqual(viewingSpy.showRetryCellCalled, true)
        XCTAssertEqual(viewingSpy.hideCharactersTableCalled, false)
        XCTAssertEqual(viewingSpy.showRetryOptionCalled, false)
    }

    // MARK: - GetCharacters Returns Success But Empty

    func testUpdateInterfaceWhenGetCharactersReturnsWithEmptyResultAndDataStoreIsEmpty() {
        dataStoreSpy.characters = []
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureEmptySuccess)

        XCTAssertEqual(viewingSpy.showEmptyFeebackCalled, true)
        XCTAssertEqual(viewingSpy.hideRetryOptionCalled, true)
        XCTAssertEqual(viewingSpy.hideCharactersTableCalled, true)
        XCTAssertEqual(viewingSpy.hideRetryCellCalled, false)
    }

    func testUpdateInterfaceWhenGetCharactersReturnsWithEmptyResultAndDataStoreIsNotEmpty() {
        dataStoreSpy.characters = [.init()]
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureEmptySuccess)

        XCTAssertEqual(viewingSpy.hideRetryCellCalled, true)
        XCTAssertEqual(viewingSpy.showEmptyFeebackCalled, false)
        XCTAssertEqual(viewingSpy.hideRetryOptionCalled, false)
        XCTAssertEqual(viewingSpy.hideCharactersTableCalled, false)
    }

    func testDataStoreWhenGetCharactersReturnsWithEmptyResultAndDataStoreIsEmpty() {
        dataStoreSpy.characters = []

        fetcherSpy.getCharactersCompletionPassed?(.fixtureEmptySuccess)

        XCTAssertEqual(dataStoreSpy.characters.isEmpty, true)
    }

    func testDataStoreWhenGetCharactersReturnsWithEmptyResultAndDataStoreIsNotEmpty() {
        dataStoreSpy.characters = [.init()]
        let beforeCount = dataStoreSpy.characters.count

        fetcherSpy.getCharactersCompletionPassed?(.fixtureEmptySuccess)

        XCTAssertEqual(dataStoreSpy.characters.count, beforeCount)
        XCTAssertEqual(dataStoreSpy.characters.isEmpty, false)
    }

    // MARK: - GetCharacters Returns Characters

    func testUpdateInterfaceWhenGetCharactersReturnsWithCharactersAndDataStoreIsEmpty() {
        dataStoreSpy.characters = []

        fetcherSpy.getCharactersCompletionPassed?(.fixtureAnySuccess)

        XCTAssertEqual(viewingSpy.showCharacteresTableCalled, true)
    }

    func testUpdateDataStoreWhenGetCharactersReturnsWithCharactersAndDataStoreIsEmpty() {
        dataStoreSpy.characters = []
        let newItems: [Heroe] = [.init()]
        let result: ResultHeroes = .success(newItems)

        fetcherSpy.getCharactersCompletionPassed?(result)

        XCTAssertEqual(dataStoreSpy.characters.count, newItems.count)
        XCTAssertEqual(dataStoreSpy.characters, newItems)
    }

    func testUpdateDataStoreWhenGetCharactersReturnsWithCharactersAndDataStoreIsNotEmpty() {
        dataStoreSpy.characters = [.init()]
        let beforeCount = dataStoreSpy.characters.count
        let newItems: [Heroe] = [.init()]
        let result: ResultHeroes = .success(newItems)

        fetcherSpy.getCharactersCompletionPassed?(result)

        XCTAssertEqual(dataStoreSpy.characters.count, beforeCount + newItems.count)
        XCTAssertEqual(Array(dataStoreSpy.characters.dropFirst(beforeCount)), newItems)
    }
}

// MARK: - ResultHeroes Fixtures

private extension ResultHeroes {

    static var fixtureAnyFailure: ResultHeroes {
        return .failure(NSError())
    }

    static var fixtureEmptySuccess: ResultHeroes {
        return .success([])
    }

    static var fixtureAnySuccess: ResultHeroes {
        return .success([.init()])
    }

    static var fixtureRamdom: ResultHeroes {
        let possibilities: [ResultHeroes] = [
            fixtureAnyFailure,
            fixtureEmptySuccess,
            fixtureAnySuccess
        ]

        return possibilities.randomElement() ?? fixtureAnyFailure
    }
}
