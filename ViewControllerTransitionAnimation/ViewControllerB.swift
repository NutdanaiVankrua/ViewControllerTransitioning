import UIKit

class ViewControllerB: UIViewController {

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("W", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 30
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple

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
        self.navigationController?.popViewController(animated: true)
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
