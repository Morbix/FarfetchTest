import Foundation

protocol CharacterListViewing {
    func showSceneSpinner()
    func removeSceneSpinner()
    func showCharacteresTable()
    func hideCharactersTable()
    func showRetryOption()
    func hideRetryOption()
    func showEmptyFeeback()
    func hideEmptyFeedback()
    func reloadData()
    func setSceneTitle(_ title: String)
}

typealias ResultHeroes = Result<([Hero], Int), Error>
protocol CharacterListFetcher: class {
    func getCharacters(skip: Int, completion: @escaping (ResultHeroes) -> Void)
}

protocol CharacterListTableStore: class {
    var heroes: [HeroCellModel] { get }
    var lastCellState: State { get }
}

protocol CharacterListTableManagerDelegate: class {
    func tableDidReachRegionAroundTheEnd()
    func tableDidSelect(at: Int)
    func tableDidRetry()
}

protocol CharacterListRoutering {
    func navigateToDetail(hero: Hero)
}
