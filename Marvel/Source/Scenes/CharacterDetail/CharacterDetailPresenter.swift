import Foundation

protocol CharacterDetailViewing {
    func setSceneTitle(_ title: String)
}

enum ContentType: String {
    case comics, series, stories, events
}

typealias ResultContent = Result<[Content], Error>
protocol CharacterDetailFetcher {
    func getContent(type: ContentType, completion: @escaping (ResultContent) -> Void)
}

final class CharacterDetailPresenter {

    private let dataStore: CharacterDetailDataStore
    private let fetcher: CharacterDetailFetcher

    init(dataStore: CharacterDetailDataStore,
         fetcher: CharacterDetailFetcher) {
        self.dataStore = dataStore
        self.fetcher = fetcher
    }

    func viewDidLoad(view: CharacterDetailViewing) {
        dataStore.view = view

        dataStore.view?.setSceneTitle(dataStore.hero.name)

        if dataStore.hero.comics.needFetchDescriptions {
            fetcher.getContent(type: .comics) { result in
                print(result)
            }
        }
    }
}

private extension Array where Element == Content {
    var hasSomeWithDescription: Bool {
        return contains { $0.description != nil }
    }

    var needFetchDescriptions: Bool {
        return !isEmpty && !hasSomeWithDescription
    }
}
