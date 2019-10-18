import Foundation

// https://medium.com/@marcosantadev/app-localization-tips-with-swift-4e9b2d9672c9
extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}
