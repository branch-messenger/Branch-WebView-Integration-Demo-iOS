//
//  SceneDelegate.swift
//  Branch-WebView-Integration-Demo-iOS
//
//  Created by Michael Huber on 11/18/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = BranchWebViewController()
        self.window?.makeKeyAndVisible()
    }

}

