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
}
