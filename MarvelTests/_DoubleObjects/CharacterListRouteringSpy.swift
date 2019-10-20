@testable import Marvel

final class CharacterListRouteringSpy: CharacterListRoutering {
    private(set) var navigateToDetailCalled: Bool = false
    private(set) var heroPassed: Hero? = nil
    func navigateToDetail(hero: Hero) {
        navigateToDetailCalled = true
        heroPassed = hero
    }
}
