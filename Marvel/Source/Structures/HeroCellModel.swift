import Foundation

struct HeroCellModel {
    let name: String
    let hasDetail: Bool
    let thumbnail: String?

    init(name: String, hasDetail: Bool = false, thumbnail: String? = nil) {
        self.name = name
        self.hasDetail = hasDetail
        self.thumbnail = thumbnail
    }
}
