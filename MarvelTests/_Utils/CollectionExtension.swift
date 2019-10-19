import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array where Element == AnyClass {
    func containsClass(_ class: AnyClass) -> Bool {
        return contains { $0 == `class` }
    }
}
