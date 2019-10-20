import Foundation

extension Array where Element == AnyClass {
    func containsClass(_ class: AnyClass) -> Bool {
        return contains { $0 == `class` }
    }
}
