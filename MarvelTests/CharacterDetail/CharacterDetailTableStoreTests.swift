import XCTest
@testable import Marvel

final class CharacterDetailTableStoreTests: XCTestCase {
    
    private let dataStore = CharacterDetailDataStore(hero: .init())
    private lazy var sut = CharacterDetailPresenter(
        dataStore: dataStore,
        fetcher: CharacterDetailFetcherSpy()
    )

    func testSectionForEmptyContent() {
        dataStore.hero.comics = []
        dataStore.hero.series = []
        dataStore.hero.stories = []
        dataStore.hero.events = []

        XCTAssertEqual(sut.sections.count, 0)
    }

    func testSectionTitles() {
        dataStore.hero.comics = .fixtureRamdomList
        dataStore.hero.series = .fixtureRamdomList
        dataStore.hero.stories = .fixtureRamdomList
        dataStore.hero.events = .fixtureRamdomList

        XCTAssertEqual(sut.sections.count, 4)
        XCTAssertEqual(sut.sections[safe: 0]?.title, "Appearance in Comics")
        XCTAssertEqual(sut.sections[safe: 1]?.title, "Appearance in Series")
        XCTAssertEqual(sut.sections[safe: 2]?.title, "Appearance in Stories")
        XCTAssertEqual(sut.sections[safe: 3]?.title, "Appearance in Events")
    }

    func testSectionOnlyForContentThatHasSomethingToShow() {
        dataStore.hero.comics = []
        dataStore.hero.series = .fixtureRamdomList
        dataStore.hero.stories = []
        dataStore.hero.events = .fixtureRamdomList

        XCTAssertEqual(sut.sections.count, 2)
        XCTAssertEqual(sut.sections[safe: 0]?.title, "Appearance in Series")
        XCTAssertEqual(sut.sections[safe: 0]?.details.isEmpty, false)
        XCTAssertEqual(sut.sections[safe: 1]?.title, "Appearance in Events")
        XCTAssertEqual(sut.sections[safe: 1]?.details.isEmpty, false)
    }

    func testSectionWithOnlyFirst3ElementsOfEachKindOfContent() throws {
        dataStore.hero.comics = .fixtureRamdomList
        dataStore.hero.series = .fixtureRamdomList
        dataStore.hero.stories = .fixtureRamdomList
        dataStore.hero.events = .fixtureRamdomList

        XCTAssertEqual(sut.sections.count, 4)
        var count = Int.max
        count = try XCTUnwrap(sut.sections[safe: 0]?.details.count)
        XCTAssertEqual(count <= 3, true)

        count = try XCTUnwrap(sut.sections[safe: 1]?.details.count)
        XCTAssertEqual(count <= 3, true)

        count = try XCTUnwrap(sut.sections[safe: 2]?.details.count)
        XCTAssertEqual(count <= 3, true)

        count = try XCTUnwrap(sut.sections[safe: 3]?.details.count)
        XCTAssertEqual(count <= 3, true)
    }

    func testDetailsForComics() {
        dataStore.hero.comics = [
            .init(name: "item 1", description: nil),
            .init(name: "item 2", description: "description 2")
        ]

        XCTAssertEqual(sut.sections.count, 1)
        let details = sut.sections[safe: 0]?.details
        XCTAssertEqual(details?[safe: 0]?.title, "item 1")
        XCTAssertNil(details?[safe: 0]?.subtitle)
        XCTAssertEqual(details?[safe: 1]?.title, "item 2")
        XCTAssertEqual(details?[safe: 1]?.subtitle, "description 2")
    }

    func testDetailsForseries() {
        dataStore.hero.series = [
            .init(name: "item 1", description: nil),
            .init(name: "item 2", description: "description 2")
        ]

        XCTAssertEqual(sut.sections.count, 1)
        let details = sut.sections[safe: 0]?.details
        XCTAssertEqual(details?[safe: 0]?.title, "item 1")
        XCTAssertNil(details?[safe: 0]?.subtitle)
        XCTAssertEqual(details?[safe: 1]?.title, "item 2")
        XCTAssertEqual(details?[safe: 1]?.subtitle, "description 2")
    }

    func testDetailsForStories() {
        dataStore.hero.stories = [
            .init(name: "item 1", description: nil),
            .init(name: "item 2", description: "description 2")
        ]

        XCTAssertEqual(sut.sections.count, 1)
        let details = sut.sections[safe: 0]?.details
        XCTAssertEqual(details?[safe: 0]?.title, "item 1")
        XCTAssertNil(details?[safe: 0]?.subtitle)
        XCTAssertEqual(details?[safe: 1]?.title, "item 2")
        XCTAssertEqual(details?[safe: 1]?.subtitle, "description 2")
    }

    func testDetailsForEvents() {
        dataStore.hero.events = [
            .init(name: "item 1", description: nil),
            .init(name: "item 2", description: "description 2")
        ]

        XCTAssertEqual(sut.sections.count, 1)
        let details = sut.sections[safe: 0]?.details
        XCTAssertEqual(details?[safe: 0]?.title, "item 1")
        XCTAssertNil(details?[safe: 0]?.subtitle)
        XCTAssertEqual(details?[safe: 1]?.title, "item 2")
        XCTAssertEqual(details?[safe: 1]?.subtitle, "description 2")
    }
}

private extension Array where Element == Content {
    static var fixtureRamdomList: [Content] {
        var times = (1..<9).randomElement() ?? 0
        var result = [Content]()
        while times > 0 {
            result.append(.init(name: "", description: nil))
            times -= 1
        }
        return result
    }
}
