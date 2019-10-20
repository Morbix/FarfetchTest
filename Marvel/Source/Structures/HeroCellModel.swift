import Foundation

struct HeroCellModel {
    let name: String
    let hasDetail: Bool

    init(name: String, hasDetail: Bool = false) {
        self.name = name
        self.hasDetail = hasDetail
    }
}
