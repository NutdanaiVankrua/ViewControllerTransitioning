import UIKit

class CircularTransition: NSObject {

    let animationDuration = 0.4
    var operation: UINavigationController.Operation = .push

    var circleColor: UIColor = .white
    var circleView = UIView()
    var startingPoint = CGPoint.zero {
        didSet {
            circleView.center = startingPoint
        }
    }

}

extension CircularTransition: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if operation == .push {
            UIView.animate(
                withDuration: animationDuration,
                delay: 0.0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0.1,
                options: .curveEaseOut,
                animations: presentAnimation(using: transitionContext),
                completion: { transitionContext.completeTransition($0) }
            )
            return
        }

        if operation == .pop {
            UIView.animate(
                withDuration: animationDuration,
                animations: popAnimation(using: transitionContext),
                completion: {
                    self.circleView.removeFromSuperview()
                    transitionContext.completeTransition($0)
            })
            return
        }
    }

    private func presentAnimation(using transitionContext: UIViewControllerContextTransitioning) -> () -> () {
        let containerView = transitionContext.containerView
        guard let viewTo = transitionContext.view(forKey: .to) else { return {} }

        circleView = UIView()

        circleView.frame = frameForCircle(
            withViewCenter: viewTo.center,
            size: viewTo.frame.size,
            startPoint: startingPoint
        )

        circleView.layer.cornerRadius = circleView.frame.size.height / 2
        circleView.center = startingPoint
        circleView.backgroundColor = circleColor
        circleView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        containerView.addSubview(circleView)

        viewTo.center = startingPoint
        viewTo.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        containerView.addSubview(viewTo)

        return {
            self.circleView.transform = CGAffineTransform.identity
            viewTo.transform = CGAffineTransform.identity
        }
    }

    private func popAnimation(using transitionContext: UIViewControllerContextTransitioning) -> () -> () {
        let containerView = transitionContext.containerView
        guard let viewTo = transitionContext.view(forKey: .to) else { return {} }
        guard let viewFrom = transitionContext.view(forKey: .from) else { return {} }

        circleView.frame = frameForCircle(
            withViewCenter: viewTo.center,
            size: viewTo.frame.size,
            startPoint: startingPoint
        )

        containerView.addSubview(viewTo)

        circleView.layer.cornerRadius = circleView.frame.size.height / 2
        circleView.center = startingPoint
        containerView.addSubview(circleView)

        return {
            self.circleView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            viewFrom.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }
    }

    private func frameForCircle(
        withViewCenter viewCenter:CGPoint,
        size viewSize:CGSize,
        startPoint:CGPoint
    ) -> CGRect {
        let xLength = max(startPoint.x, viewSize.width - startPoint.x)
        let yLength = max(startPoint.y, viewSize.height - startPoint.y)

        let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offestVector, height: offestVector)

        return CGRect(origin: CGPoint.zero, size: size)
    }

}
