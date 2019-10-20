import Foundation

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

// MARK: - Array needFetchDescriptions

private extension Array where Element == Content {
    private var hasSomeWithDescription: Bool {
        return contains { $0.description != nil }
    }

    var needFetchDescriptions: Bool {
        return !isEmpty && !hasSomeWithDescription
    }
}

// MARK: - CharacterDetailTableStore

#warning("1 cover mapping")
extension CharacterDetailPresenter: CharacterDetailTableStore {
    var sections: [HeroDetailSectionModel] {
        return [
            (dataStore.hero.comics, "appearance_in_comics".localized()),
            (dataStore.hero.series, "appearance_in_series".localized()),
            (dataStore.hero.stories, "appearance_in_stories".localized()),
            (dataStore.hero.events, "appearance_in_events".localized())
        ].compactMap { (list, title) in
            guard !list.isEmpty else { return nil }

            let first3Items: [HeroDetailCellModel] = list
                .map(HeroDetailCellModel.init)
                .dropLast(max(list.count-3, 0))

            return .init(title:  title, details: first3Items)
        }
    }
}

private extension HeroDetailCellModel {
    init(content: Content) {
        self.title = content.name
        self.subtitle = content.description
    }
}
