import Foundation

extension NSError {
    static var unexpectedFailure: NSError = .init(
        domain: "unexpected_failure".localized(),
        code: -1,
        userInfo: nil
    )
}
