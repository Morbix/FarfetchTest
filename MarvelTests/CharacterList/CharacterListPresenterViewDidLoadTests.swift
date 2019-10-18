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
        XCTAssertFalse(viewingSpy.showRetryCellCalled)
        XCTAssertFalse(viewingSpy.showEmptyFeebackCalled)
        XCTAssertFalse(viewingSpy.hideRetryCellCalled)
    }

    func testRemoveSpinnerWhenGetCharactersReturnsWithAnyResult() {
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureRamdom)

        XCTAssertEqual(viewingSpy.removeSceneSpinnerCalled, true)
    }

    // MARK: GetCharacters Returns An Error

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

    // MARK: GetCharacters Returns Success

    func testUpdateInterfaceWhenGetCharactersReturnsWithAnySuccesResult() {
        dataStoreSpy.characters = [.init()]
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureAnySuccess)

        XCTAssertEqual(viewingSpy.hideRetryCellCalled, true)
        XCTAssertEqual(viewingSpy.hideRetryOptionCalled, true)
    }

    func testUpdateInterfaceWhenGetCharactersReturnsWithEmptyResultAndDataStoreIsEmpty() {
        dataStoreSpy.characters = []
        viewingSpy.reset()

        fetcherSpy.getCharactersCompletionPassed?(.fixtureEmptySuccess)

        XCTAssertEqual(viewingSpy.showEmptyFeebackCalled, true)
        XCTAssertEqual(viewingSpy.hideCharactersTableCalled, true)
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

    func testUpdateInterfaceWhenGetCharactersReturnsWithCharactersAndDataStoreIsEmpty() {
        dataStoreSpy.characters = []
        let newItems: [Heroe] = [.init()]
        let result: ResultHeroes = .success(newItems)

        fetcherSpy.getCharactersCompletionPassed?(result)

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

    // MARK: Update Table With Characteres

    func testUpdateTableWith1Character() {
        let newItems: [Heroe] = [
            .init(name: "item 1")
        ]
        let result: ResultHeroes = .success(newItems)

        fetcherSpy.getCharactersCompletionPassed?(result)

        XCTAssertEqual(viewingSpy.includeCharactersCalled, true)
        XCTAssertEqual(viewingSpy.charactersPassed?.count, 1)

        let item1 = viewingSpy.charactersPassed?.first
        XCTAssertEqual(item1?.name, "item 1")
    }

    func testUpdateTableWith3Characteres() {
        let newItems: [Heroe] = [
            .init(name: "item 1"),
            .init(name: "item 2"),
            .init(name: "item 3")
        ]
        let result: ResultHeroes = .success(newItems)

        fetcherSpy.getCharactersCompletionPassed?(result)

        XCTAssertEqual(viewingSpy.includeCharactersCalled, true)
        XCTAssertEqual(viewingSpy.charactersPassed?.count, 3)

        let item1 = viewingSpy.charactersPassed?[safe: 0]
        XCTAssertEqual(item1?.name, "item 1")

        let item2 = viewingSpy.charactersPassed?[safe: 1]
        XCTAssertEqual(item2?.name, "item 2")

        let item3 = viewingSpy.charactersPassed?[safe: 2]
        XCTAssertEqual(item3?.name, "item 3")
    }
}

// MARK: - Heroe Dummy
private extension Heroe {
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
        return .success([])
    }

    static var fixtureAnySuccess: ResultHeroes {
        var times = (0..<3).randomElement() ?? 0
        var heroes = [Heroe]()
        while times > 0 {
            heroes.append(Heroe())
            times -= 1
        }
        return .success(heroes)
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
