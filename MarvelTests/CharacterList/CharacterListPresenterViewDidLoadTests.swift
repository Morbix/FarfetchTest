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

    // MARK: GetCharacters Returns Any

    func testCallNothingIfViewIsNil() {
        dataStoreSpy.view = nil
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureRamdom)

        XCTAssertFalse(viewingSpy.showSceneSpinnerCalled)
        XCTAssertFalse(viewingSpy.removeSceneSpinnerCalled)
        XCTAssertFalse(viewingSpy.hideCharactersTableCalled)
        XCTAssertFalse(viewingSpy.hideRetryOptionCalled)
        XCTAssertFalse(viewingSpy.showRetryOptionCalled)
        XCTAssertFalse(viewingSpy.showEmptyFeebackCalled)
        XCTAssertFalse(viewingSpy.reloadDataCalled)
    }

    func testRemoveSpinnerWhenGetCharactersReturnsWithAnyResult() {
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureRamdom)

        XCTAssertEqual(viewingSpy.removeSceneSpinnerCalled, true)
        XCTAssertEqual(viewingSpy.reloadDataCalled, true)
    }

    // MARK: GetCharacters Returns An Error

    func testUpdateInterfaceWhenGetCharactersReturnsWithErrorAndDataStoreIsEmpty() {
        dataStoreSpy.characters = []
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureAnyFailure)

        XCTAssertEqual(viewingSpy.hideCharactersTableCalled, true)
        XCTAssertEqual(viewingSpy.showRetryOptionCalled, true)
    }

    func testUpdateInterfaceWhenGetCharactersReturnsWithErrorAndDataStoreIsNotEmpty() {
        dataStoreSpy.characters = [.init()]
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureAnyFailure)

        XCTAssertEqual(dataStoreSpy.lastCellState, .retry)
        XCTAssertEqual(viewingSpy.hideCharactersTableCalled, false)
        XCTAssertEqual(viewingSpy.showRetryOptionCalled, false)
    }

    // MARK: GetCharacters Returns Success

    func testUpdateInterfaceWhenGetCharactersReturnsWithAnySuccesResult() {
        dataStoreSpy.characters = [.init()]
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureAnySuccess)

        XCTAssertEqual(viewingSpy.hideRetryOptionCalled, true)
        XCTAssertEqual(dataStoreSpy.totalAvailable, 999)
    }

    func testUpdateInterfaceWhenGetCharactersReturnsWithEmptyResultAndDataStoreIsEmpty() {
        dataStoreSpy.characters = []
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureEmptySuccess)

        XCTAssertEqual(dataStoreSpy.lastCellState, .none)
        XCTAssertEqual(dataStoreSpy.characters.isEmpty, true)
        XCTAssertEqual(viewingSpy.showEmptyFeebackCalled, true)
        XCTAssertEqual(viewingSpy.hideCharactersTableCalled, true)
        XCTAssertEqual(dataStoreSpy.totalAvailable, 0)
    }

    func testUpdateInterfaceWhenGetCharactersReturnsWithEmptyResultAndDataStoreIsNotEmpty() {
        dataStoreSpy.characters = [.init()]
        let beforeCount = dataStoreSpy.characters.count
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureEmptySuccess)

        XCTAssertEqual(dataStoreSpy.lastCellState, .none)
        XCTAssertEqual(dataStoreSpy.characters.count, beforeCount)
        XCTAssertEqual(dataStoreSpy.characters.isEmpty, false)
        XCTAssertEqual(viewingSpy.showCharacteresTableCalled, true)
        XCTAssertEqual(dataStoreSpy.totalAvailable, 0)
    }

    func testUpdateInterfaceWhenGetCharactersReturnsWithCharactersAndDataStoreIsEmpty() {
        dataStoreSpy.characters = []
        let newItems: [Hero] = [.init()]
        let result: ResultHeroes = .success((newItems, 100))
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(result)

        XCTAssertEqual(viewingSpy.showCharacteresTableCalled, true)
        XCTAssertEqual(dataStoreSpy.characters.count, newItems.count)
        XCTAssertEqual(dataStoreSpy.characters, newItems)
        XCTAssertEqual(dataStoreSpy.totalAvailable, 100)
    }

    func testUpdateDataStoreWhenGetCharactersReturnsWithCharactersAndDataStoreIsNotEmpty() {
        dataStoreSpy.characters = [.init()]
        let beforeCount = dataStoreSpy.characters.count
        let newItems: [Hero] = [.init()]
        let result: ResultHeroes = .success((newItems, 100))

        fetcherSpy.getCharactersCompletionPassed?(result)

        XCTAssertEqual(viewingSpy.showCharacteresTableCalled, true)
        XCTAssertEqual(dataStoreSpy.characters.count, beforeCount + newItems.count)
        XCTAssertEqual(Array(dataStoreSpy.characters.dropFirst(beforeCount)), newItems)
        XCTAssertEqual(dataStoreSpy.totalAvailable, 100)
    }
}
// MARK: - Hero Dummy
extension Hero {
    init() {
        self.init(name: .init())
    }
}

// MARK: - ResultHeroes Fixtures

private extension ResultHeroes {

    static var fixtureAnyFailure: ResultHeroes {
        return .failure(
            NSError(
                domain: .init(),
                code: .init(),
                userInfo: nil
            )
        )
    }

    static var fixtureEmptySuccess: ResultHeroes {
        return .success(([], 0))
    }

    static var fixtureAnySuccess: ResultHeroes {
        var times = (0..<3).randomElement() ?? 0
        var heroes = [Hero]()
        while times > 0 {
            heroes.append(Hero())
            times -= 1
        }
        return .success((heroes, 999))
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
