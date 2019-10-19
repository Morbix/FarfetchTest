import UIKit

extension UIView {
    func hasActiveAnchor(_ attribute: NSLayoutConstraint.Attribute,
                         _ constant: Int) -> Bool {
        return constraints.contains {
            return $0.constant == CGFloat(constant)
                && $0.firstAttribute == attribute
                && $0.isActive
        }
    }
}
