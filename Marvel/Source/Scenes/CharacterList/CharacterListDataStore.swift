import Foundation

final class CharacterListDataStore {
    var view: CharacterListViewing?
    var characters: [Hero] = .init()
    var isLoading: Bool = false
}
