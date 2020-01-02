import UIKit

class ViewControllerA: UIViewController {

    private let transition = CircularTransition()

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("P", for: .normal)
        button.layer.cornerRadius = 30
        button.backgroundColor = .purple
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self

        view.backgroundColor = .white

        view.addSubview(button)
        setupConstraints()

        button.addTarget(
            self, action:
            #selector(onButtonTouchUpInside(sender:)),
            for: .touchUpInside
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    @objc func onButtonTouchUpInside(sender: UIButton) {
        let viewControllerB = ViewControllerB()
        self.navigationController?.pushViewController(viewControllerB, animated: true)
    }

    private func setupConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 60),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

extension ViewControllerA: UINavigationControllerDelegate {

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        transition.operation = operation
        transition.circleColor = .purple
        transition.startingPoint = button.center
        return transition
    }

}
