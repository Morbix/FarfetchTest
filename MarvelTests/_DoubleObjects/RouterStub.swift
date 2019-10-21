import UIKit
@testable import Marvel

final class RouterStub: Router {

    var viewControllerToReturn: UIViewController = UIViewControllerMock()
    func makeViewController() -> UIViewController {
        return viewControllerToReturn
    }
}
