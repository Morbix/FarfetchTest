import XCTest
@testable import Marvel

final class CharacterDetailPresenterViewDidLoadTests: CharacterDetailPresenterBaseTestCase {

    override func setUp() {
        super.setUp()

        sut.viewDidLoad(view: viewingSpy)
    }

    func testSetView() {
        XCTAssertNotNil(dataStoreSpy.view)
        XCTAssertTrue(dataStoreSpy.view as? CharacterDetailViewingSpy === viewingSpy)
    }

}
