import Foundation

final class CharacterDetailDataStore {

    var view: CharacterDetailViewing?
    var hero: Hero

    init(hero: Hero) {
        self.hero = hero
    }
}
