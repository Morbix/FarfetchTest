import XCTest
@testable import Marvel

final class CharacterDetailPresenterAskForContentTests: CharacterDetailPresenterBaseTestCase {

    // MARK: Ask for Comics

    func testAskForComicsWhenIsAvailableAndDescriptionIsNotPresent() {
        hero.comics = [
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, true)
        XCTAssertEqual(fetcherSpy.typePassed, .comics)
        XCTAssertEqual(fetcherSpy.characterIdPassed, 999)
    }

    func testDontAskForComicsWhenIsAvailableAndDescriptionIsPresent() {
        hero.comics = [
            .init(name: ""),
            .init(name: "", description: ""),
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }

    func testDontAskForComicsWhenIsNotAvailable() {
        hero.comics = []

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }

    // MARK: Ask for Series

    func testAskForSeriesWhenIsAvailableAndDescriptionIsNotPresent() {
        hero.series = [
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, true)
        XCTAssertEqual(fetcherSpy.typePassed, .series)
        XCTAssertEqual(fetcherSpy.characterIdPassed, 999)
    }

    func testDontAskForSeriesWhenIsAvailableAndDescriptionIsPresent() {
        hero.series = [
            .init(name: ""),
            .init(name: "", description: ""),
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }

    func testDontAskForSeriesWhenIsNotAvailable() {
        hero.series = []

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }

    // MARK: Ask for Stories

    func testAskForStoriesWhenIsAvailableAndDescriptionIsNotPresent() {
        hero.stories = [
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, true)
        XCTAssertEqual(fetcherSpy.typePassed, .stories)
        XCTAssertEqual(fetcherSpy.characterIdPassed, 999)
    }

    func testDontAskForStoriesWhenIsAvailableAndDescriptionIsPresent() {
        hero.stories = [
            .init(name: ""),
            .init(name: "", description: ""),
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }

    func testDontAskForStoriesWhenIsNotAvailable() {
        hero.stories = []

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }

    // MARK: Ask for Events

    func testAskForEventsWhenIsAvailableAndDescriptionIsNotPresent() {
        hero.events = [
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, true)
        XCTAssertEqual(fetcherSpy.typePassed, .events)
        XCTAssertEqual(fetcherSpy.characterIdPassed, 999)
    }

    func testDontAskForEventsWhenIsAvailableAndDescriptionIsPresent() {
        hero.events = [
            .init(name: ""),
            .init(name: "", description: ""),
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }

    func testDontAskForEventsWhenIsNotAvailable() {
        hero.events = []

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }
}
