import Foundation

final class CharacterDetailDataStore {

    var view: CharacterDetailViewing?
    var hero: Hero

    init(hero: Hero) {
        self.hero = hero
    }
}

extension CharacterDetailDataStore: CharacterDetailTableStore {
    var sections: [HeroDetailSectionModel] {
        return [
            (hero.comics, "appearance_in_comics".localized()),
            (hero.series, "appearance_in_series".localized()),
            (hero.stories, "appearance_in_stories".localized()),
            (hero.events, "appearance_in_events".localized())
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
