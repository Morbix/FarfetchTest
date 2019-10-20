import Foundation

final class CharacterListDataStore {
    var view: CharacterListViewing?
    var characters: [Hero] = .init()
    var lastCellState: State = .none
    var totalAvailable: Int = 0
}
