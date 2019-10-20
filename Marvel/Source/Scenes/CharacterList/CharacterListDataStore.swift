import Foundation

final class CharacterListDataStore {
    var view: CharacterListViewing?
    var characters: [Hero] = .init()
    var lastCellState: State = .none
    var totalAvailable: Int = 0
}

// MARK: - CharacterListTableStore

extension CharacterListDataStore: CharacterListTableStore {

    var heroes: [HeroCellModel] {
        characters.map(HeroCellModel.init)
    }
}

private extension HeroCellModel {
    init(hero: Hero) {
        self.init(name: hero.name)
    }
}
