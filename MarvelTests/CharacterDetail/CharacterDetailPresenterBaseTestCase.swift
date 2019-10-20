import XCTest
@testable import Marvel

class CharacterDetailPresenterBaseTestCase: XCTestCase {

    let viewingSpy = CharacterDetailViewingSpy()
    let hero = Hero()
    lazy var dataStoreSpy = CharacterDetailDataStore(
        hero: hero
    )
    lazy var sut = CharacterDetailPresenter(
        dataStore: dataStoreSpy
    )

}
