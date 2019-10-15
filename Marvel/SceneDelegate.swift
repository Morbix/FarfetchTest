//
//  SceneDelegate.swift
//  Marvel
//
//  Created by Henrique Morbin on 15/10/19.
//  Copyright © 2019 Henrique Morbin. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: scene)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }

}

