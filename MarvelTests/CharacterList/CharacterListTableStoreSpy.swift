@testable import Marvel

final class CharacterListTableStoreSpy: CharacterListTableStore {

    var heroes: [HeroCellModel] = []
    var lastCellState: State = .none
    
}
