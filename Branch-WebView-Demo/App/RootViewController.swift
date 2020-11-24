//
//  RootViewController.swift
//  Branch-WebView-Integration-Demo-iOS
//
//  Created by Michael Huber on 11/18/20.
//

import UIKit

class RootViewController: UIViewController {

    // MARK: - Views

    private lazy var launchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Launch WebView", for: .normal)
        button.addTarget(
            self,
            action: #selector(launchWebView),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.configureConstraints()
    }

    // MARK: - Layout

    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.launchButton)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            self.launchButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.launchButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    // MARK: - Actions

    @objc private func launchWebView() {
        let vc = BranchWebViewController()
        vc.delegate = self
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        self.present(nc, animated: true)
    }

}

// MARK: - BranchWebViewControllerDelegate

extension RootViewController: BranchWebViewControllerDelegate {

    func branchWebViewControllerDidCancel(_ viewController: BranchWebViewController) {
        viewController.dismiss(animated: true)
    }

    func branchWebViewControllerDidComplete(_ viewController: BranchWebViewController) {
        viewController.dismiss(animated: true)
    }

}
