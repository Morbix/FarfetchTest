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

        #warning("test this")
        dataStore.view?.reloadData()
        dataStore.view?.setSceneTitle(dataStore.hero.name)

        let hero = dataStore.hero

        if hero.comics.needFetchDescriptions {
            fetcher.getContent(type: .comics, characterId: hero.id) { [dataStore] result in
                if case .success(let items) = result, !items.isEmpty {
                    dataStore.hero.comics = items
                    dataStore.view?.reloadData()
                }
            }
        }

        if hero.series.needFetchDescriptions {
            fetcher.getContent(type: .series, characterId: hero.id) { [dataStore] result in
                if case .success(let items) = result, !items.isEmpty {
                    dataStore.hero.series = items
                    dataStore.view?.reloadData()
                }
            }
        }

        if hero.stories.needFetchDescriptions {
            fetcher.getContent(type: .stories, characterId: hero.id) { [dataStore] result in
                if case .success(let items) = result, !items.isEmpty {
                    dataStore.hero.stories = items
                    dataStore.view?.reloadData()
                }
            }
        }

        if hero.events.needFetchDescriptions {
            fetcher.getContent(type: .events, characterId: hero.id) { [dataStore] result in
                if case .success(let items) = result, !items.isEmpty {
                    dataStore.hero.events = items
                    dataStore.view?.reloadData()
                }
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
