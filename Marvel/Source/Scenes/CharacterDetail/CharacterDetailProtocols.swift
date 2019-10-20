import Foundation

protocol CharacterDetailViewing {
    func setSceneTitle(_ title: String)
    func reloadData()
}

enum ContentType: String {
    case comics, series, stories, events
}

typealias ResultContent = Result<[Content], Error>
protocol CharacterDetailFetcher {
    func getContent(type: ContentType, characterId: Int, completion: @escaping (ResultContent) -> Void)
}

protocol CharacterDetailTableStore: class {
    var sections: [HeroDetailSectionModel] { get }
}
