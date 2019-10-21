import UIKit

// **DISCLAIMER**
// This implementation is a version modified from Brian Advent's implementation
// https://www.brianadvent.com/ios-swift-tutorial-create-circular-transition-animation-custom-uiviewcontroller-transitions/
//
// And it was written a year ago by me.

final class CircularTransition: NSObject {

    fileprivate enum CircularTransitionMode: Int {
        case present, dismiss
    }

    var startingPoint = CGPoint.init(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    var duration = 0.6
    var timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

    // MARK: Private Properties

    fileprivate var transitionMode = CircularTransitionMode.present
}

// MARK: - UIViewControllerAnimatedTransitioning

extension CircularTransition: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let isPresent = transitionMode == .present

        guard let presentedView = transitionContext.view(forKey: isPresent ? .to : .from) else { return }

        containerView.addSubview(presentedView)

        let initialDiameter: CGFloat = 0.001
        let initialPath = createPath(diameter: initialDiameter)

        let finalDiameter = UIScreen.main.bounds.height * 2.0
        let finalPath = createPath(diameter: finalDiameter)

        let keyPath = #keyPath(CAShapeLayer.path)
        let animation: CABasicAnimation
        if transitionMode == .present {
            animation = createPathAnimation(from: initialPath, to: finalPath, keyPath: keyPath)
        } else {
            animation = createPathAnimation(from: finalPath, to: initialPath, keyPath: keyPath)
        }

        let mask = createMask(path: initialPath)
        presentedView.layer.mask = mask
        mask.add(animation, forKey: keyPath)

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            transitionContext.completeTransition(true)
        }
    }

    private func createPath(diameter: CGFloat) -> UIBezierPath {
        let point: CGPoint
        if diameter > 0 {
            point = CGPoint(x: startingPoint.x - diameter/2, y: startingPoint.y - diameter/2)
        } else {
            point = startingPoint
        }
        let frame = CGRect(origin: point, size: CGSize(width: diameter, height: diameter))
        return UIBezierPath(ovalIn: frame)
    }

    private func createPathAnimation(from: UIBezierPath, to: UIBezierPath, keyPath: String?) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.fromValue = from.cgPath
        animation.toValue = to.cgPath
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        return animation
    }

    private func createMask(path: UIBezierPath) -> CAShapeLayer {
        let mask = CAShapeLayer()
        mask.fillRule = CAShapeLayerFillRule.evenOdd
        mask.path = path.cgPath
        return mask
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension CircularTransition: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionMode = .present
        return self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionMode = .dismiss
        return self
    }
}
