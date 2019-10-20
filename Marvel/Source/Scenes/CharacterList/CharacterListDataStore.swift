import Foundation

final class CharacterListDataStore {

    enum State {
        case loading, retry, hidden
    }

    var view: CharacterListViewing?
    var characters: [Hero] = .init()
    var lastCellState: State = .hidden
}
