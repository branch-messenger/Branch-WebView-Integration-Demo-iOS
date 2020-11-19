//
//  BranchWebViewController.swift
//  Branch-WebView-Integration-Demo-iOS
//
//  Created by Michael Huber on 11/18/20.
//

import UIKit
import WebKit

protocol BranchWebViewControllerDelegate: class {
    func branchWebViewControllerDidCancel(_ viewController: BranchWebViewController)
    func branchWebViewControllerDidComplete(_ viewController: BranchWebViewController)
}

class BranchWebViewController: UIViewController {

    weak var delegate: BranchWebViewControllerDelegate?

    // MARK: - Views

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.configureConstraints()
        self.loadData()
    }

    private func loadData() {
        var urlComponents = URLComponents(string: "https://accounts-dev.branchapp.com")
        urlComponents?.queryItems = [
            URLQueryItem(name: "embedded", value: "native"),
            URLQueryItem(name: "org", value: "100019"),
            URLQueryItem(name: "callbackUrl", value: "https://branchapp.com/"),
            URLQueryItem(name: "bypassFlow", value: "true")
        ]

        guard let urlString = urlComponents?.string, let url = URL(string: urlString) else { return }
        self.webView.load(URLRequest(url: url))
    }

    // MARK: - Layout

    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.webView)
        self.view.addSubview(self.activityIndicator)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

}

// MARK: - WKNavigationDelegate

extension BranchWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.activityIndicator.stopAnimating()
    }

    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping ((WKNavigationActionPolicy) -> Void)
    ) {
        guard let urlString = navigationAction.request.url?.absoluteString,
              urlString == "https://branchapp.com/" else {
                decisionHandler(.allow)
                return
        }

        decisionHandler(.cancel)
        self.delegate?.branchWebViewControllerDidComplete(self)
    }

}

