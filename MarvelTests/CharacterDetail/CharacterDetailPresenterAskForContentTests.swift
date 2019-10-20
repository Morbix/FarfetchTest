import XCTest
@testable import Marvel

final class CharacterDetailPresenterAskForContentTests: CharacterDetailPresenterBaseTestCase {

    // MARK: Ask for Comics

    func testAskForComicsWhenIsAvailableAndDescriptionIsNotPresent() {
        dataStoreSpy.hero.comics = [
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, true)
        XCTAssertEqual(fetcherSpy.typePassed, .comics)
        XCTAssertEqual(fetcherSpy.characterIdPassed, 999)
    }

    func testDontAskForComicsWhenIsAvailableAndDescriptionIsPresent() {
        dataStoreSpy.hero.comics = [
            .init(name: ""),
            .init(name: "", description: ""),
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }

    func testDontAskForComicsWhenIsNotAvailable() {
        dataStoreSpy.hero.comics = []

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }

    // MARK: Ask for Series

    func testAskForSeriesWhenIsAvailableAndDescriptionIsNotPresent() {
        dataStoreSpy.hero.series = [
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, true)
        XCTAssertEqual(fetcherSpy.typePassed, .series)
        XCTAssertEqual(fetcherSpy.characterIdPassed, 999)
    }

    func testDontAskForSeriesWhenIsAvailableAndDescriptionIsPresent() {
        dataStoreSpy.hero.series = [
            .init(name: ""),
            .init(name: "", description: ""),
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }

    func testDontAskForSeriesWhenIsNotAvailable() {
        dataStoreSpy.hero.series = []

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }

    // MARK: Ask for Stories

    func testAskForStoriesWhenIsAvailableAndDescriptionIsNotPresent() {
        dataStoreSpy.hero.stories = [
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, true)
        XCTAssertEqual(fetcherSpy.typePassed, .stories)
        XCTAssertEqual(fetcherSpy.characterIdPassed, 999)
    }

    func testDontAskForStoriesWhenIsAvailableAndDescriptionIsPresent() {
        dataStoreSpy.hero.stories = [
            .init(name: ""),
            .init(name: "", description: ""),
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }

    func testDontAskForStoriesWhenIsNotAvailable() {
        dataStoreSpy.hero.stories = []

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }

    // MARK: Ask for Events

    func testAskForEventsWhenIsAvailableAndDescriptionIsNotPresent() {
        dataStoreSpy.hero.events = [
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, true)
        XCTAssertEqual(fetcherSpy.typePassed, .events)
        XCTAssertEqual(fetcherSpy.characterIdPassed, 999)
    }

    func testDontAskForEventsWhenIsAvailableAndDescriptionIsPresent() {
        dataStoreSpy.hero.events = [
            .init(name: ""),
            .init(name: "", description: ""),
            .init(name: "")
        ]

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }

    func testDontAskForEventsWhenIsNotAvailable() {
        dataStoreSpy.hero.events = []

        sut.viewDidLoad(view: viewingSpy)

        XCTAssertEqual(fetcherSpy.getContentCalled, false)
    }

    // MARK: - ** Returns **



    // MARK: Comics Returns

    func testWhenComicsReturnsWithFailure() {
        dataStoreSpy.hero.comics = [
            .init(name: "")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()

        fetcherSpy.getContentCompletionPassed?(.fixtureAnyFailure)

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertNil(dataStoreSpy.hero.comics.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.comics.count, 1)
    }

    func testWhenComicsReturnsWithEmptySuccess() {
        dataStoreSpy.hero.comics = [
            .init(name: "")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()

        fetcherSpy.getContentCompletionPassed?(.fixtureEmptySuccess)

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertNil(dataStoreSpy.hero.comics.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.comics.count, 1)
    }

    func testWhenComicsReturnsWithSuccess() {
        dataStoreSpy.hero.comics = [
            .init(name: "old content")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()
        let response: [Content] = [
            .init(name: "new content", description: "description")
        ]

        XCTAssertNil(dataStoreSpy.hero.comics.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.comics.first?.name, "old content")

        fetcherSpy.getContentCompletionPassed?(.success(response))

        XCTAssertEqual(viewingSpy.reloadDataCalled, true)
        let comics = dataStoreSpy.hero.comics
        XCTAssertEqual(comics.first?.description, "description")
        XCTAssertEqual(comics.first?.name, "new content")
        XCTAssertEqual(comics.count, 1)
    }

    func testWhenComicsReturnsWithSuccessWithMoreContentThanPrevious() {
        dataStoreSpy.hero.comics = [
            .init(name: "old content")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()
        let response: [Content] = [
            .init(name: "new content 1", description: "description 1"),
            .init(name: "new content 2", description: "description 2")
        ]

        XCTAssertNil(dataStoreSpy.hero.comics.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.comics.first?.name,"old content")

        fetcherSpy.getContentCompletionPassed?(.success(response))

        XCTAssertEqual(viewingSpy.reloadDataCalled, true)
        let comics = dataStoreSpy.hero.comics
        XCTAssertEqual(comics.count, 2)
        XCTAssertEqual(comics.first?.description, "description 1")
        XCTAssertEqual(comics.first?.name, "new content 1")
        XCTAssertEqual(comics.last?.description,"description 2")
        XCTAssertEqual(comics.last?.name,"new content 2")

    }

    // MARK: Series Returns

    func testWhenSeriesReturnsWithFailure() {
        dataStoreSpy.hero.series = [
            .init(name: "")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()

        fetcherSpy.getContentCompletionPassed?(.fixtureAnyFailure)

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertNil(dataStoreSpy.hero.series.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.series.count, 1)
    }

    func testWhenSeriesReturnsWithEmptySuccess() {
        dataStoreSpy.hero.series = [
            .init(name: "")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()

        fetcherSpy.getContentCompletionPassed?(.fixtureEmptySuccess)

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertNil(dataStoreSpy.hero.series.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.series.count, 1)
    }

    func testWhenSeriesReturnsWithSuccess() {
        dataStoreSpy.hero.series = [
            .init(name: "old content")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()
        let response: [Content] = [
            .init(name: "new content", description: "description")
        ]

        XCTAssertNil(dataStoreSpy.hero.series.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.series.first?.name, "old content")

        fetcherSpy.getContentCompletionPassed?(.success(response))

        XCTAssertEqual(viewingSpy.reloadDataCalled, true)
        let series = dataStoreSpy.hero.series
        XCTAssertEqual(series.first?.description, "description")
        XCTAssertEqual(series.first?.name, "new content")
        XCTAssertEqual(series.count, 1)
    }

    func testWhenSeriesReturnsWithSuccessWithMoreContentThanPrevious() {
        dataStoreSpy.hero.series = [
            .init(name: "old content")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()
        let response: [Content] = [
            .init(name: "new content 1", description: "description 1"),
            .init(name: "new content 2", description: "description 2")
        ]

        XCTAssertNil(dataStoreSpy.hero.series.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.series.first?.name,"old content")

        fetcherSpy.getContentCompletionPassed?(.success(response))

        XCTAssertEqual(viewingSpy.reloadDataCalled, true)
        let series = dataStoreSpy.hero.series
        XCTAssertEqual(series.count, 2)
        XCTAssertEqual(series.first?.description, "description 1")
        XCTAssertEqual(series.first?.name, "new content 1")
        XCTAssertEqual(series.last?.description,"description 2")
        XCTAssertEqual(series.last?.name,"new content 2")

    }

    // MARK: Stories Returns

    func testWhenStoriesReturnsWithFailure() {
        dataStoreSpy.hero.stories = [
            .init(name: "")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()

        fetcherSpy.getContentCompletionPassed?(.fixtureAnyFailure)

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertNil(dataStoreSpy.hero.stories.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.stories.count, 1)
    }

    func testWhenStoriesReturnsWithEmptySuccess() {
        dataStoreSpy.hero.stories = [
            .init(name: "")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()

        fetcherSpy.getContentCompletionPassed?(.fixtureEmptySuccess)

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertNil(dataStoreSpy.hero.stories.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.stories.count, 1)
    }

    func testWhenStoriesReturnsWithSuccess() {
        dataStoreSpy.hero.stories = [
            .init(name: "old content")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()
        let response: [Content] = [
            .init(name: "new content", description: "description")
        ]

        XCTAssertNil(dataStoreSpy.hero.stories.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.stories.first?.name, "old content")

        fetcherSpy.getContentCompletionPassed?(.success(response))

        XCTAssertEqual(viewingSpy.reloadDataCalled, true)
        let stories = dataStoreSpy.hero.stories
        XCTAssertEqual(stories.first?.description, "description")
        XCTAssertEqual(stories.first?.name, "new content")
        XCTAssertEqual(stories.count, 1)
    }

    func testWhenStoriesReturnsWithSuccessWithMoreContentThanPrevious() {
        dataStoreSpy.hero.stories = [
            .init(name: "old content")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()
        let response: [Content] = [
            .init(name: "new content 1", description: "description 1"),
            .init(name: "new content 2", description: "description 2")
        ]

        XCTAssertNil(dataStoreSpy.hero.stories.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.stories.first?.name,"old content")

        fetcherSpy.getContentCompletionPassed?(.success(response))

        XCTAssertEqual(viewingSpy.reloadDataCalled, true)
        let stories = dataStoreSpy.hero.stories
        XCTAssertEqual(stories.count, 2)
        XCTAssertEqual(stories.first?.description, "description 1")
        XCTAssertEqual(stories.first?.name, "new content 1")
        XCTAssertEqual(stories.last?.description,"description 2")
        XCTAssertEqual(stories.last?.name,"new content 2")

    }

    // MARK: Events Returns

    func testWhenEventsReturnsWithFailure() {
        dataStoreSpy.hero.events = [
            .init(name: "")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()

        fetcherSpy.getContentCompletionPassed?(.fixtureAnyFailure)

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertNil(dataStoreSpy.hero.events.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.events.count, 1)
    }

    func testWhenEventsReturnsWithEmptySuccess() {
        dataStoreSpy.hero.events = [
            .init(name: "")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()

        fetcherSpy.getContentCompletionPassed?(.fixtureEmptySuccess)

        XCTAssertEqual(viewingSpy.reloadDataCalled, false)
        XCTAssertNil(dataStoreSpy.hero.events.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.events.count, 1)
    }

    func testWhenEventsReturnsWithSuccess() {
        dataStoreSpy.hero.events = [
            .init(name: "old content")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()
        let response: [Content] = [
            .init(name: "new content", description: "description")
        ]

        XCTAssertNil(dataStoreSpy.hero.events.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.events.first?.name, "old content")

        fetcherSpy.getContentCompletionPassed?(.success(response))

        XCTAssertEqual(viewingSpy.reloadDataCalled, true)
        let events = dataStoreSpy.hero.events
        XCTAssertEqual(events.first?.description, "description")
        XCTAssertEqual(events.first?.name, "new content")
        XCTAssertEqual(events.count, 1)
    }

    func testWhenEventsReturnsWithSuccessWithMoreContentThanPrevious() {
        dataStoreSpy.hero.events = [
            .init(name: "old content")
        ]
        sut.viewDidLoad(view: viewingSpy)
        viewingSpy.reset()
        let response: [Content] = [
            .init(name: "new content 1", description: "description 1"),
            .init(name: "new content 2", description: "description 2")
        ]

        XCTAssertNil(dataStoreSpy.hero.events.first?.description)
        XCTAssertEqual(dataStoreSpy.hero.events.first?.name,"old content")

        fetcherSpy.getContentCompletionPassed?(.success(response))

        XCTAssertEqual(viewingSpy.reloadDataCalled, true)
        let events = dataStoreSpy.hero.events
        XCTAssertEqual(events.count, 2)
        XCTAssertEqual(events.first?.description, "description 1")
        XCTAssertEqual(events.first?.name, "new content 1")
        XCTAssertEqual(events.last?.description,"description 2")
        XCTAssertEqual(events.last?.name,"new content 2")

    }

}

// MARK: - ResultContent Fixtures

private extension ResultContent {

    static var fixtureAnyFailure: ResultContent {
        return .failure(
            NSError(
                domain: .init(),
                code: .init(),
                userInfo: nil
            )
        )
    }

    static var fixtureEmptySuccess: ResultContent {
        return .success([])
    }

    static var fixtureAnySuccess: ResultContent {
        var times = (0..<3).randomElement() ?? 0
        var content = [Content]()
        while times > 0 {
            content.append(Content(name: "", description: ""))
            times -= 1
        }
        return .success(content)
    }

    static var fixtureRamdom: ResultContent {
        let possibilities: [ResultContent] = [
            fixtureAnyFailure,
            fixtureEmptySuccess,
            fixtureAnySuccess
        ]

        return possibilities.randomElement() ?? fixtureAnyFailure
    }
}

