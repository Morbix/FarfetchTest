import Foundation

final class Hero: Equatable {
    let id: Int
    let name: String
    var comics: [Content]
    var series: [Content]
    var stories: [Content]
    var events: [Content]

    static func == (lhs: Hero, rhs: Hero) -> Bool {
        return lhs.id == rhs.id
    }

    #warning("test constructor")
    init(id: Int,
         name: String,
         comics: [Content],
         series: [Content],
         stories: [Content],
         events: [Content]) {
        self.id = id
        self.name = name
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
    }
}

struct Content: Equatable {
    let name: String
    var description: String?
}
